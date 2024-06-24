import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_house_admin_version/screens/Bottom_navigation_bar_screens/statistics_screen.dart';
import 'package:coffee_house_admin_version/screens/Bottom_navigation_bar_screens/support_screen.dart';
import 'package:coffee_house_admin_version/shared/app_bloc/states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/constants.dart';
import '../../models/drink_model.dart';
import '../../models/home_item_model.dart';
import '../../models/last_update_data_model.dart';
import '../../models/percentage_value_of_variables_model.dart';
import '../../screens/Bottom_navigation_bar_screens/home_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(ChangeCurrentIndex());
  }

  List<Widget> screens = [
    const HomeScreen(),
    const SupportScreen(),
    const StatisticsScreen(),
  ];

  final List<String> categories = ['Coffee', 'Chocolate', 'Others'];

  List<HomeItemModel> homeItems = [
    HomeItemModel(
      title: 'Add',
      icon: Icons.add_box_outlined,
    ),
    HomeItemModel(
      title: 'Edit',
      icon: Icons.edit_outlined,
    ),
    HomeItemModel(
      title: 'Delete',
      icon: Icons.delete_outline,
    ),
    HomeItemModel(
      title: 'Recommendation',
      icon: Icons.recommend_outlined,
    ),
  ];


  List<DrinkModel> coffeeMenu = [];

  List<DrinkModel> chocolateMenu = [];

  List<DrinkModel> othersMenu = [];



  Future<void> getCoffeeMenu() async {
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc('Sections')
        .collection('Coffee')
        .get()
        .then((value) {
      for (var element in value.docs) {
        coffeeMenu.add(DrinkModel.fromJson(element.data()));
        allItems.add(DrinkModel.fromJson(element.data()));
      }
      emit(SuccessGetCoffeeMenu());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetCoffeeMenu());
    });
  }

  Future<void> getChocolateMenu() async {
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc('Sections')
        .collection('Chocolate')
        .get()
        .then((value) {
      for (var element in value.docs) {
        chocolateMenu.add(DrinkModel.fromJson(element.data()));
        allItems.add(DrinkModel.fromJson(element.data()));
      }
      emit(SuccessGetChocolateMenu());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetChocolateMenu());
    });
  }

  Future<void> getOthersMenu() async {
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc('Sections')
        .collection('Others')
        .get()
        .then((value) async {
      for (var element in value.docs) {
        othersMenu.add(DrinkModel.fromJson(element.data()));
        allItems.add(DrinkModel.fromJson(element.data()));
      }
      emit(SuccessGetOthersMenu());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetOthersMenu());
    });
  }


  Future<void> getOrders() async {
    await FirebaseFirestore.instance
        .collection('Orders')
        .get()
        .then((value) {
      for (var element in value.docs) {
        totalValueOfBeverageSales += element['Total of price'];
      }
      emit(SuccessGetOrders());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetOrders());
    });
  }


  bool showContent = false;

  Future<void> getAllDrinks() async {
    await getChocolateMenu().then((value) async {
      await getCoffeeMenu().then((value) async {
        await getOthersMenu().then((value) async {
          await getOrders().then((value) {
            extractTheRecommendedItems();
            getTotalOrders();
            getTotalUsers();
            getTotalBeverageSales();
            showContent = true;
          });
        });
      });
    });
  }

  List<DrinkModel> itemsNotRecommended = [];
  List<DrinkModel> itemsRecommended = [];

  void extractTheRecommendedItems() {
    for (var element in allItems) {
      if (element.isRecommendation) {
        itemsRecommended.add(element);
      } else {
        itemsNotRecommended.add(element);
      }
    }
  }

  Future<void> addIOrRemoveItemFromRecommend(
      {required DrinkModel model, required bool addItemToRecommend}) async {
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc('Sections')
        .collection(model.category)
        .doc(model.drinkName)
        .update({
      'Recommendation': addItemToRecommend,
    }).then((value) async {
      allItems = [];
      await getAllDrinks();
      emit(SuccessAddIOrRemoveItemFromRecommend());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorAddIOrRemoveItemFromRecommend());
    });
  }

  Future<void> deleteItem(DrinkModel model) async {
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc('Sections')
        .collection(model.category)
        .doc(model.drinkName)
        .delete()
        .then((value) async {
      allItems = [];
      getAllDrinks();
      emit(SuccessDeleteItem());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorDeleteItem());
    });
  }

  String category = '';

  Future<void> addItem({
    required String drinkName,
    required String image,
    required String description,
    required dynamic price,
  }) async {
    emit(LoadingAddItem());
    DrinkModel model = DrinkModel(
      category: category,
      drinkName: drinkName,
      image: image,
      description: description,
      isNew: true,
      isRecommendation: true,
      price: price,
      rate: 0.0,
      numberOfTimesSold: 0,
    );
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc('Sections')
        .collection(category)
        .doc(drinkName)
        .set(model.toMap())
        .then((value) async {
      category = '';
      emit(SuccessAddItem());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorAddItem());
    });
  }

  Future<void> editItem({
    required String drinkName,
    required String image,
    required String category,
    required String description,
    required dynamic price,
    required bool isNew,
  }) async {
    emit(LoadingEditItem());
    await FirebaseFirestore.instance
        .collection('Menu')
        .doc('Sections')
        .collection(category)
        .doc(drinkName)
        .update({
      'Name': drinkName,
      'Price': price,
      'Image': image,
      'Description': description,
      'New': isNew,
    })
        .then((value) async {
      allItems = [];
      getAllDrinks();
      emit(SuccessEditItem());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorEditItem());
    });
  }

  DateTime datetimeOfUpdateData = DateTime.now();


  Future<void> getStatisticsDataIfAvailable() async {
    await FirebaseFirestore.instance
        .collection('Statistics')
        .doc('Data update date')
        .get()
        .then((value) async {
      Timestamp firestoreTimestamp = value.data()?['Date'];
      datetimeOfUpdateData = firestoreTimestamp.toDate();
      if (datetimeOfUpdateData.isBefore(DateTime.now())) {
      await  getLastUpdateData().then((value) async => await updatePercentageValueOfVariables());
      }
      emit(SuccessGetStatisticsData());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetStatisticsData());
    });
  }

  Future<void> updateStatisticsDate() async {
     DateTime updatedDate = datetimeOfUpdateData.add(const Duration(days: 30));
        await FirebaseFirestore.instance
            .collection('Statistics')
            .doc('Data update date')
            .update({
          'Date': updatedDate
        });
  }


  Future<void> getTotalUsers() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .get()
        .then((value) {
      totalUser = value.docs.length;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(Error());
    });
  }

  Future<void> getTotalOrders() async {
    await FirebaseFirestore.instance
        .collection('Orders')
        .get()
        .then((value) {
      totalOrders = value.docs.length;
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(Error());
    });
  }

  void getTotalBeverageSales() async {
    for (var element in allItems) {
      totalBeverageSales += element.numberOfTimesSold as int;
    }
  }

  double calculatePercentageChange(double oldValue, double newValue) {
    double change = newValue - oldValue;
    double percentageChange = (change / oldValue) * 100;
    return percentageChange;
  }

  LastUpdateDataModel? lastUpdateDataModel;

  Future<void> getLastUpdateData() async {
    await FirebaseFirestore.instance
        .collection('Statistics')
        .doc('Last update Data')
        .get()
        .then((value) async {
      lastUpdateDataModel = LastUpdateDataModel.fromJson(value.data()!);
      putPercentageValuesInPercentageVariables();
      emit(SuccessGetLastUpdateData());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetLastUpdateData());
    });
  }

  PercentageValueOfVariablesModel? percentageValueOfVariablesModel;

  void putPercentageValuesInPercentageVariables() {
    if (lastUpdateDataModel == null) {
      if (kDebugMode) {
        print('lastUpdateDataModel is null. Cannot calculate percentage changes.');
      }
      return;
    }

    percentageValueOfVariablesModel = PercentageValueOfVariablesModel(
        totalUser: calculatePercentageChange(
          lastUpdateDataModel!.totalUser.toDouble(), totalUser.toDouble(),
        ),
        totalBeverageSales: calculatePercentageChange(
          lastUpdateDataModel!.totalBeverageSales.toDouble(), totalBeverageSales.toDouble(),
        ),
        totalValueOfBeverageSales: calculatePercentageChange(
          lastUpdateDataModel!.totalValueOfBeverageSales.toDouble(), totalValueOfBeverageSales.toDouble(),
        ),
        totalOrders: calculatePercentageChange(
          lastUpdateDataModel!.totalOrders.toDouble(), totalOrders.toDouble(),
        ),
    );
  }

  Future<void> getPercentageValueOfVariables() async {
    await FirebaseFirestore.instance
        .collection('Statistics')
        .doc('Percentage value of variables')
        .get()
        .then((value) async {
      percentageValueOfVariablesModel = PercentageValueOfVariablesModel.fromJson(value.data()!);
      emit(SuccessGetPercentageValueOfVariables());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorGetPercentageValueOfVariables());
    });
  }

  Future<void> updatePercentageValueOfVariables() async {
    await FirebaseFirestore.instance
        .collection('Statistics')
        .doc('Percentage value of variables')
        .update(percentageValueOfVariablesModel!.toMap())
        .then((value) async {
         await updateStatisticsDate();
      emit(SuccessUpdatePercentageValueOfVariables());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ErrorUpdatePercentageValueOfVariables());
    });
  }

}

import 'package:coffee_house_admin_version/components/components.dart';
import 'package:coffee_house_admin_version/shared/app_bloc/cubit.dart';
import 'package:coffee_house_admin_version/shared/app_bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/items.dart';
import '../style/colors.dart';


class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  State<RecommendationScreen> createState() =>
      _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  bool showListView = true;
  bool showItemsRecommended = true;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Visibility(
          visible: showListView,
          replacement: Visibility(
            visible: showItemsRecommended,
            /// add to recommend
            replacement: ListView.builder(
              itemCount: cubit.itemsNotRecommended.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  dialog(
                      context: context,
                      onTap: () =>cubit.addIOrRemoveItemFromRecommend(model: cubit.itemsNotRecommended[index], addItemToRecommend: true),

                      textColor: secColor,
                      title: 'add to recommend');
                },
                child: drinkItem(
                  cubit.itemsNotRecommended[index],
                ),
              ),
            ),
            /// remove from recommend
            child: ListView.builder(
              itemCount: cubit.itemsRecommended.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  dialog(
                      context: context,
                      onTap: () =>cubit.addIOrRemoveItemFromRecommend(model: cubit.itemsRecommended[index], addItemToRecommend: false),
                      textColor: Colors.red,
                      title: 'remove from recommend');
                },
                child: drinkItem(
                  cubit.itemsRecommended[index],
                ),
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defButton(
                  onTap: () {
                    setState(() {
                      showListView = false;
                      showItemsRecommended = false;
                    });
                  },
                  child: defText(
                      text: 'Add item to recommend', textColor: defColor)),
              defButton(
                  onTap: () {
                    setState(() {
                      showListView = false;
                    });
                  },
                  child: defText(
                      text: 'Remove item from recommend', textColor: defColor)),
            ],
          ),
        );
      },
    );
  }
}

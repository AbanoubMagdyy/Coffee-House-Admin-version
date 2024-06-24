import 'package:coffee_house_admin_version/models/drink_model.dart';
import 'package:restart_app/restart_app.dart';
import '../shared/shared_preferences.dart';

 List<DrinkModel> allItems = [] ;
int totalBeverageSales = 0;
dynamic totalValueOfBeverageSales = 0;
int totalOrders = 0;
int totalUser = 0 ;

 const String appName = 'Coffee House';
String email = '';

void logout(context) {
  Shared.deleteData('Email')?.then((value) {
    Restart.restartApp();
    },
  );
}
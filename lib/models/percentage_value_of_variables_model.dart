
class PercentageValueOfVariablesModel {
  dynamic totalBeverageSales = 0;
  dynamic totalValueOfBeverageSales = 0;
  dynamic totalOrders = 0;
  dynamic totalUser = 0 ;

  PercentageValueOfVariablesModel(
      {
        required this.totalUser,
        required this.totalBeverageSales,
        required this.totalValueOfBeverageSales,
        required this.totalOrders,
      });

  PercentageValueOfVariablesModel.fromJson(Map<String, dynamic> json){
    totalBeverageSales = json['Total beverage sales'];
    totalOrders = json['Total orders'];
    totalValueOfBeverageSales = json['Total value of beverage sales'];
    totalUser = json['Total users'];
  }



  Map<String, dynamic> toMap() {
    return {
      'Total beverage sales': totalBeverageSales,
      'Total orders': totalOrders,
      'Total value of beverage sales': totalValueOfBeverageSales,
      'Total users': totalUser,
    };
  }
}

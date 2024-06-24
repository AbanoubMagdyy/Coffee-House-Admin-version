class LastUpdateDataModel{
  late dynamic totalBeverageSales;
  late dynamic totalValueOfBeverageSales;
  late dynamic totalOrders;
  late dynamic totalUser;

  LastUpdateDataModel.fromJson(Map<String, dynamic> json){
    totalBeverageSales = json['Total beverage sales'];
    totalOrders = json['Total orders'];
    totalValueOfBeverageSales = json['Total value of beverage sales'];
    totalUser = json['Total users'];
  }

}
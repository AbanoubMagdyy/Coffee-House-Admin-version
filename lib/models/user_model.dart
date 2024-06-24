class UserModel{
  late String name;
  late String image;
  late String email;
  late String phoneNumber;
  late String theDateOfJoin;
  late bool doYouRateUs;
  late List<dynamic> favoriteDrinks;
  late List<dynamic> addresses;



  UserModel.fromJson(Map<String, dynamic> json){
    name = json['Name'];
    email = json['Email'];
    image = json['Image'];
    addresses = json['Addresses'];
    doYouRateUs = json['Do you rate us'];
    theDateOfJoin = json['The date of join'];
    phoneNumber = json['Phone number'];
  }


}
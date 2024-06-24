class DrinkModel{
  late String drinkName;
  late String image;
  late String category;
  late String description;
  late bool isNew;
  late bool isRecommendation;
  late dynamic price;
  late dynamic rate;
  late dynamic numberOfTimesSold;


  DrinkModel({
    required this.category,
    required this.drinkName,
    required this.image,
    required this.description,
    required this.isNew,
    required this.isRecommendation,
    required this.price,
    required this.rate,
    required this.numberOfTimesSold,
});

  DrinkModel.fromJson(Map<String, dynamic> json){
    drinkName = json['Name'];
    price = json['Price'];
    image = json['Image'];
    description = json['Description'];
    category = json['Category'];
    rate = json['Rate'];
    isNew = json['New'];
    isRecommendation = json['Recommendation'];
    numberOfTimesSold = json['Number of times sold'];
  }



  Map<String, dynamic> toMap() {
    return {
      'Name': drinkName,
      'Category': category,
      'Price': price,
      'Image': image,
      'Description': description,
      'Rate': rate,
      'New': isNew,
      'Recommendation': isRecommendation,
      'Number of times sold': numberOfTimesSold,
    };
  }

}
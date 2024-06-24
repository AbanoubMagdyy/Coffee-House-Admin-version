import 'package:coffee_house_admin_version/screens/add_drink_screen.dart';
import 'package:coffee_house_admin_version/models/home_item_model.dart';
import 'package:coffee_house_admin_version/screens/delete_item_screen.dart';
import 'package:coffee_house_admin_version/screens/edit_drink_screen.dart';
import 'package:coffee_house_admin_version/screens/recommendation_screen.dart';
import 'package:flutter/material.dart';
import '../components/components.dart';
import '../style/colors.dart';

class HomeItem extends StatelessWidget {
  final HomeItemModel itemModel;
  final int index;

   Widget widget = Container();
  final double requestHeightForIcon = 200;
    HomeItem({Key? key,
     required this.itemModel,
     required this.index,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0 :
        widget = const AddDrinkScreen();
        break ;
      case 1 :
        widget = const EditItemScreen();
        break ;
      case 2 :
        widget = const DeleteItemScreen();
        break ;
      case 3 :
        widget = const RecommendationScreen();
        break ;
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableHeight = constraints.maxHeight;
        return InkWell(
          onTap: ()=>bottomSheet(context,widget ),
          child: Container(
              decoration: BoxDecoration(
                color: secColor,
                borderRadius: BorderRadiusDirectional.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// icon
                  if(availableHeight > requestHeightForIcon)
                   Padding(
                     padding: const EdgeInsets.only(bottom: 15.0),
                     child: CircleAvatar(
                      radius: 40,
                      backgroundColor: defColor,
                      child: Icon(
                        itemModel.icon,
                        size: 35,
                      ),
                  ),
                   ),
                  /// title
                  defText(text: '${itemModel.title} item', textColor: defColor)
                ],
              )),
        );
      },
    );
  }
}

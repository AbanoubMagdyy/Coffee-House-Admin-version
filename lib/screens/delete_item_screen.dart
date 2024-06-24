import 'package:coffee_house_admin_version/shared/app_bloc/cubit.dart';
import 'package:flutter/material.dart';
import '../components/components.dart';
import '../components/constants.dart';
import '../components/items.dart';

class DeleteItemScreen extends StatelessWidget {
  const DeleteItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allItems.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          dialog(
            context: context,
            onTap: () =>AppCubit.get(context).deleteItem(allItems[index],),
            textColor: Colors.red,
            title: 'delete',
          );
        },
        child: drinkItem(
          allItems[index],
        ),
      ),
    );
  }
}

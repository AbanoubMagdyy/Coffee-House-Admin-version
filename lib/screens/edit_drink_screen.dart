import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_house_admin_version/models/drink_model.dart';
import 'package:coffee_house_admin_version/shared/app_bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/components.dart';
import '../components/constants.dart';
import '../components/items.dart';
import '../shared/app_bloc/cubit.dart';
import '../style/colors.dart';

class EditItemScreen extends StatefulWidget {
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController descriptionController =
      TextEditingController();
  static final TextEditingController imageURLController =
      TextEditingController();
  static final TextEditingController priceController = TextEditingController();

  const EditItemScreen({Key? key}) : super(key: key);

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final double minWidthForSCategory = 270;

  bool showListView = true;

  DrinkModel? model;

  var groupValue = 'Yes';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return LayoutBuilder(builder: (context, constraints) {
          final double availableWidth = constraints.maxWidth;
          return Visibility(
            visible: showListView,
            replacement: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// back icon and drink information
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            showListView = true;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: secColor,
                          size: 30,
                        ),
                    ),
                    defText(text: model?.drinkName ?? ''),
                    const Spacer(),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: CachedNetworkImageProvider(model?.image ?? ''),
                    )
                  ],
                ),

                /// name
                defTextFormField(
                  controller: EditItemScreen.nameController,
                  text: 'Name',
                ),

                /// category
                if (availableWidth < minWidthForSCategory)
                  Container(
                    width: 200,
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: secColor),
                        ),
                      ),
                      dropdownColor: backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      hint: FittedBox(
                        child: defText(
                          text: 'Category',
                          fontSize: 14,
                        ),
                      ),
                      items: cubit.categories.map(
                        (e) {
                          return DropdownMenuItem(
                            value: e,
                            child: defText(
                              text: e,
                              fontSize: 12,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (Object? value) {
                        cubit.category = value.toString();
                      },
                    ),
                  ),

                /// description
                Container(
                  padding: const EdgeInsetsDirectional.all(5),
                  margin: const EdgeInsetsDirectional.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    border: Border.all(
                      color: secColor,
                    ),
                  ),
                  child: defTextFormField(
                    controller: EditItemScreen.descriptionController,
                    text: 'Description',
                    maxLines: 4,
                    border: InputBorder.none,
                  ),
                ),

                /// image and price
                Row(
                  children: [
                    /// image url
                    Expanded(
                      flex: 3,
                      child: defTextFormField(
                        controller: EditItemScreen.imageURLController,
                        text: 'Image URL',
                      ),
                    ),

                    /// Price
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: defTextFormField(
                          keyboard: TextInputType.number,
                          controller: EditItemScreen.priceController,
                          text: 'Price',
                        ),
                      ),
                    )
                  ],
                ),

                defText(text: 'Is New'),
                Row(
                  children: [
                    Radio(

                        value: 'Yes', groupValue: groupValue, onChanged: (value){
                      setState(() {
                        groupValue = value!;

                      });
                    }),
                    defText(text: 'Yes'),
                    const SizedBox(
                      width: 50,
                    ),
                    Radio(value: 'No', groupValue: groupValue, onChanged: (value){
                      setState(() {
                        groupValue = value!;
                      });
                    }),
                    defText(text: 'No')
                  ],
                ),

                /// edit button
                defButton(
                  onTap: () {
                    if (EditItemScreen.nameController.text.isNotEmpty &&
                        EditItemScreen.imageURLController.text.isNotEmpty &&
                        EditItemScreen.descriptionController.text.isNotEmpty &&
                        EditItemScreen.priceController.text.isNotEmpty ) {
                      Navigator.pop(context);
                      cubit.editItem(
                        drinkName: EditItemScreen.nameController.text,
                        image: EditItemScreen.imageURLController.text,
                        description: EditItemScreen.descriptionController.text,
                        price: double.tryParse(EditItemScreen.priceController.text),
                        category: model?.category ??'',
                        isNew: groupValue == 'Yes' ? true : false,
                      );
                    } else {
                      defMaterialBanner(context, 'Complete all information');
                    }
                  },
                  child: defText(
                    text: 'Edit item',
                    textColor: defColor,
                  ),
                )
              ],
            ),
            child: ListView.builder(
              itemCount: allItems.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      showListView = false;
                      model = allItems[index];
                      EditItemScreen.nameController.text = model?.drinkName ?? '';
                      EditItemScreen.descriptionController.text = model?.description ?? '';
                      EditItemScreen.imageURLController.text = model?.image ?? '';
                      EditItemScreen.priceController.text = model?.price.toString() ?? '';
                      if(model?.isNew ?? false){
                        groupValue = 'Yes';
                      }else{
                        groupValue = 'No';

                      }
                    });
                  },
                  child: drinkItem(
                    allItems[index],
                  ),
                );
              },
            ),
          );
        });
      },
    );
  }
}

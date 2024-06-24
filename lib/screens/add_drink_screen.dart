import 'package:coffee_house_admin_version/shared/app_bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/components.dart';
import '../shared/app_bloc/cubit.dart';
import '../style/colors.dart';

class AddDrinkScreen extends StatelessWidget {
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController descriptionController =
      TextEditingController();
  static final TextEditingController imageURLController =
      TextEditingController();
  static final TextEditingController priceController = TextEditingController();
  final double minWidthForSCategory = 270;

  const AddDrinkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is SuccessAddItem) {
          nameController.clear();
          descriptionController.clear();
          imageURLController.clear();
          priceController.clear();
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return LayoutBuilder(builder: (context, constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// name and category
              Row(
                children: [
                  /// name
                  Expanded(
                    child: defTextFormField(
                      controller: nameController,
                      text: 'Name',
                    ),
                  ),

                  /// category
                  if (availableWidth > minWidthForSCategory)
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
                ],
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
                  controller: descriptionController,
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
                      controller: imageURLController,
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
                        controller: priceController,
                        text: 'Price',
                      ),
                    ),
                  )
                ],
              ),
              defButton(
                onTap: () {
                  if (nameController.text.isNotEmpty &&
                      imageURLController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      cubit.category.isNotEmpty) {
                    Navigator.pop(context);
                    cubit.addItem(
                      drinkName: nameController.text,
                      image: imageURLController.text,
                      description: descriptionController.text,
                      price: double.tryParse(priceController.text),
                    );
                  } else {
                    defMaterialBanner(context, 'Complete all information');
                  }
                },
                child: defText(
                  text: 'Add item',
                  textColor: defColor,
                ),
              )
            ],
          );
        });
      },
    );
  }
}

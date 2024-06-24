import 'package:flutter/material.dart';
import '../models/drink_model.dart';
import '../style/colors.dart';
import 'components.dart';

Widget drinkItem(DrinkModel model) => LayoutBuilder(
      builder: (context, constraints) {
        const double minWidthForImage = 390;
        final double availableWidth = constraints.maxWidth;

        return Container(
          margin: const EdgeInsetsDirectional.all(
            10,
          ),
          padding: const EdgeInsetsDirectional.all(15),
          decoration: BoxDecoration(
            color: secColor,
            borderRadius: BorderRadiusDirectional.circular(20),
          ),
          child: Row(
            children: [
              /// image
              if (availableWidth > minWidthForImage)
                Container(
                  height: 150,
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsetsDirectional.only(
                    end: 15,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20)),
                  child: networkImage(model.image, width: 150),
                ),

              /// name and description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// name
                    FittedBox(
                        child: defText(
                            text: model.drinkName, textColor: defColor)),

                    /// description
                    defText(
                        text: model.description,
                        textColor: defColor.withOpacity(0.5)),
                  ],
                ),
              ),

              defText(text: '${model.price} E.P', textColor: defColor),
            ],
          ),
        );
      },
    );


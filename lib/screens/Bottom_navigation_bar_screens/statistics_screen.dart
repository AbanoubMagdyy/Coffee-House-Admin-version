import 'package:coffee_house_admin_version/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../components/constants.dart';
import '../../items/charts_items/best_seller_item.dart';
import '../../models/app_statistics_model.dart';
import '../../shared/app_bloc/cubit.dart';
import '../../shared/app_bloc/states.dart';
import '../../style/colors.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AppStatisticsModel> appStatistics = [
      AppStatisticsModel(
        title: 'Total users',
        icon: Icons.person,
        value: totalUser,
        percentageValue: AppCubit.get(context).percentageValueOfVariablesModel!.totalUser.toDouble(),
      ),
      AppStatisticsModel(
        title: 'Total orders',
        icon: Icons.motorcycle,
        value: totalOrders,
        percentageValue: AppCubit.get(context).percentageValueOfVariablesModel!.totalOrders.toDouble(),
      ),
      AppStatisticsModel(
        title: 'Total beverage sales',
        icon: Icons.emoji_food_beverage,
        value: totalBeverageSales,
        percentageValue: AppCubit.get(context).percentageValueOfVariablesModel!.totalBeverageSales.toDouble(),
      ),
      AppStatisticsModel(
        title: 'Total value of beverage sales',
        icon: Icons.monetization_on,
        value: totalValueOfBeverageSales,
        percentageValue: AppCubit.get(context).percentageValueOfVariablesModel!.totalValueOfBeverageSales.toDouble(),
      ),
    ];
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          body: LayoutBuilder(builder: (context, constraints) {
            // final double availableHeight = constraints.maxHeight;
            // final double availableWidth = constraints.maxWidth;
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const BestSellerItem(),
                      Container(
                        height: 750,
                        margin:
                            const EdgeInsetsDirectional.symmetric(vertical: 10),
                        padding: const EdgeInsetsDirectional.all(10),
                        decoration: BoxDecoration(
                            color: secColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    informationItem(
                                  appStatistics[index],
                                ),
                                separatorBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0),
                                  child: defLine(),
                                ),
                                itemCount: appStatistics.length,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0.0),
                              child: defLine(),
                            ),
                            defText(
                                text:
                                    'Last update was on ${formatLastUpdateDate(cubit.datetimeOfUpdateData)}',
                                textColor: defColor,
                                fontSize: 20,),
                            const SizedBox(
                              height: 15,
                            ),
                            defText(
                                text:
                                    '**Note: Data is usually updated every 30 days',
                                textColor: defColor,
                                fontSize: 15,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget informationItem(AppStatisticsModel model) => Container(
        padding: const EdgeInsetsDirectional.all(10),
        margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: defColor,
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// number and icon
            Row(
              children: [
                /// number
                Expanded(
                  child: defText(
                    text: model.value.toString(),
                    fontSize: 25,
                  ),
                ),

                /// icon
                Icon(
                  model.icon,
                  color: secColor,
                  size: 30,
                )
              ],
            ),

            /// title
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: defText(text: model.title),
            ),

            /// icon and The ratio
            Row(
              children: [
                /// icon
                if(model.percentageValue > 0)
                const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.greenAccent,
                  size: 30,
                ),
                if(model.percentageValue < 0)
                  const Icon(
                    Icons.arrow_downward,
                    color: Colors.red,
                    size: 30,
                  ),
                if(model.percentageValue == 0)
                  const Icon(
                    Icons.density_large,
                    color: secColor,
                    size: 30,
                  ),

                /// The ratio
                defText(
                    text:
                    '${model.percentageValue > 0 ? '+' :''}${model.percentageValue}% this month'),
              ],
            ),
          ],
        ),
      );
}

 formatLastUpdateDate(DateTime date){
  return DateFormat.yMMMd().format(date);
}

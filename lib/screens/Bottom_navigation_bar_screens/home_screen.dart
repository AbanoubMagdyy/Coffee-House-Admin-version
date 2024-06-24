import 'package:coffee_house_admin_version/components/components.dart';
import 'package:coffee_house_admin_version/items/home_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/app_bloc/cubit.dart';
import '../../shared/app_bloc/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          body: LayoutBuilder(
              builder: (context,constraints) {
                 final double availableHeight = constraints.maxHeight;
                 final double availableWidth = constraints.maxWidth;
                return SafeArea(
                    child:      Column(
                      children: [
                        if(state is LoadingAddItem || state is LoadingEditItem)
                          defLinearProgressIndicator(),
                        Expanded(
                          child: GridView.count(
                            padding: const EdgeInsetsDirectional.all(10),
                            childAspectRatio: availableWidth /
                                (availableHeight -10),
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            children: List.generate(
                             cubit.homeItems.length,
                                  (index) {
                                return HomeItem(itemModel: cubit.homeItems[index],index: index,);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                );
              }
          ),
        );
      },
    );
  }

}
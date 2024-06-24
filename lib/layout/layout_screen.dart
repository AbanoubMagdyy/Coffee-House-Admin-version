
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/components.dart';
import '../shared/app_bloc/cubit.dart';
import '../shared/app_bloc/states.dart';
import '../style/colors.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeCurrentIndex(index);
              },
              iconSize: 30,
              backgroundColor: secColor,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.white,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                  activeIcon: Icon(Icons.home),
                  backgroundColor: secColor,),
                BottomNavigationBarItem(
                  icon: Icon(Icons.support_agent_outlined),
                  label: 'Support',
                  activeIcon: Icon(Icons.support_agent_rounded),
                  backgroundColor: secColor,),
                BottomNavigationBarItem(
                  icon: Icon(Icons.analytics_outlined),
                  label: 'Statistics',
                  activeIcon: Icon(Icons.analytics),
                  backgroundColor: secColor,
                ),
              ],
            ),
            body: Visibility(
                visible: cubit.showContent,
                replacement: loading(),
                child: cubit.screens[cubit.currentIndex])
        );
      },
    );
  }
}

import 'package:coffee_house_admin_version/screens/login_screen.dart';
import 'package:coffee_house_admin_version/shared/app_bloc/cubit.dart';
import 'package:coffee_house_admin_version/shared/bloc_observer.dart';
import 'package:coffee_house_admin_version/shared/shared_preferences.dart';
import 'package:coffee_house_admin_version/shared/support_bloc/cubit.dart';
import 'package:coffee_house_admin_version/style/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/constants.dart';
import 'firebase_options.dart';
import 'layout/layout_screen.dart';



main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Shared.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  email = await Shared.getDate('Email') ?? '';
  Widget screen;
  if (email != '') {
    screen = const LayoutScreen();
  } else {
    screen =  LoginScreen();
  }
  runApp(MyApp(screen));
}




class MyApp extends StatelessWidget {

  final Widget screen;
  const MyApp(this.screen,{super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:  (context)=>AppCubit()..getAllDrinks()..getPercentageValueOfVariables()..getStatisticsDataIfAvailable(),),
        BlocProvider(create:  (context)=>SupportCubit()..getThePeopleWhoSentTheirComplaints(),)
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Noto',primarySwatch: Colors.brown,
            scaffoldBackgroundColor: backgroundColor,
          ),
          home: screen
      ),
    );
  }
}

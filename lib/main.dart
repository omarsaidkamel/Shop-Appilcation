import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/screens/HomeScreen.dart';
import 'package:shop_app/screens/MainScreen.dart';
import 'package:shop_app/screens/login_screen.dart';
import 'package:shop_app/screens/onboarding_screen.dart';
import 'package:shop_app/tools/Sharedpreferencesclass.dart';
import 'package:shop_app/tools/bloc.dart';
import 'package:shop_app/tools/default_widget.dart';

void main() async{

  Widget initwidget;
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await sharedpreferencesshop.init();

  bool? onboarding = sharedpreferencesshop.getData(key: 'onboarding');
  String? token = sharedpreferencesshop.getData(key: 'token');
  if(onboarding != null){
    if(token != null ) {
      initwidget = const MainScreen();
    } else {
      initwidget = const LoginScreen();
    }
  }
  else {
    initwidget = const OnBoardingScreen();
  }
  runApp(
      MaterialApp(
         debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: initwidget,
      )
  );
}

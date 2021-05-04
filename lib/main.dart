import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Modules/login_screen/login.dart';
import 'package:flutter_appp/Modules/register_screen/register.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/remote/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Layout/app/app.dart';
import 'Shared/bloc_observer.dart';
import 'Shared/network/end_notes.dart';
import 'Shared/network/locale/globalUserData.dart';
import 'Shared/styles/colors.dart';
import 'models/userInformation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  DioHelper.init();
  bool isLoggedBefore;
  var userData = CashHelper.getData('userLogInData');
  if (userData != null) {
    allUserData = UserLogInModel.fromJson(jsonDecode(userData));
    if (allUserData.status == true) {
      isLoggedBefore = true;
    } else {
      isLoggedBefore = false;
    }
  } else {
    isLoggedBefore = false;
  }

  runApp(MyApp(
    isLoggedBefore: isLoggedBefore,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedBefore;
  MyApp({this.isLoggedBefore});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: blueColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      home: isLoggedBefore ? App() : LogIn(),
    );
  }
}

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appp/Modules/login_screen/login.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/remote/remote.dart';
import 'Shared/bloc_observer.dart';
import 'Shared/styles/colors.dart';
import 'models/userInformation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  var userData = CashHelper.getData('userData');
  if (userData != null) {
    UserModel userModel = UserModel.fromJson(jsonDecode(userData));
    print(userModel.status);
    print(userModel.message);
    print(userModel.data.token);
  } else {
    print('new user');
  }

  DioHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: LogIn(),
    );
  }
}

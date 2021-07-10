import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Modules/login_screen/login.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/remote/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Layout/app/app.dart';
import 'Shared/bloc_observer.dart';
import 'Shared/network/locale/globalUserData.dart';
import 'Shared/styles/Consts.dart';
import 'models/userInformation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  DioHelper.init();
  bool isLoggedBefore;
  lan = CashHelper.getData('lan');
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
    return BlocProvider(
      create: (context) => ShopCubit()..getTranslation(context),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: isLoggedBefore ? App() : LogIn(),
        ),
      ),
    );
  }
}

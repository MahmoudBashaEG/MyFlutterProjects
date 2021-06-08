import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Modules/EnterApp/EnterCubit.dart';
import 'package:socialapp/Modules/EnterApp/login/login.dart';
import 'package:socialapp/Modules/EnterApp/register/register.dart';
import 'package:socialapp/Shared/network/locale/locale.dart';
import 'package:socialapp/globalVariable.dart';
import 'Layout/app.dart';
import 'Shared/bloc_observer.dart';
import 'Shared/styles/Consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();

  Widget startScreen;
  String uid = CashHelper.getData('uid');
  if (uid == null) {
    startScreen = Register();
  } else {
    // Global Variable Was used in SocialCubit Like A Token
    userUid = uid;
    startScreen = SocialLayout();
  }

  runApp(MyApp(
    startScreen: startScreen,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  MyApp({this.startScreen});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EnterCubit(),
        ),
        BlocProvider(
          create: (context) => SocialCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        home: startScreen,
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Modules/EnterApp/EnterCubit.dart';
import 'package:socialapp/Modules/EnterApp/register/register.dart';
import 'package:socialapp/Shared/network/locale/locale.dart';
import 'package:socialapp/globalVariable.dart';
import 'Layout/app.dart';
import 'Shared/Components/Components.dart';
import 'Shared/bloc_observer.dart';
import 'Shared/network/remote/Notification.dart';
import 'Shared/styles/Consts.dart';

Future<void> onBackGroundMessage(RemoteMessage messageBack) async {
  message(message: 'backGround', state: MessageType.Succeed);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  mobileToken = await FirebaseMessaging.instance.getToken();
  print(mobileToken);
  Fcm.init();
  await CashHelper.init();

  Widget startScreen;
  if (FirebaseAuth.instance.currentUser == null) {
    startScreen = Register();
  } else {
    // Global Variable Was used in SocialCubit Like A Token
    globalUserData = FirebaseAuth.instance.currentUser;
    startScreen = SocialLayout();
  }

  FirebaseMessaging.onMessage.listen((event) {
    message(message: 'OnMessage', state: MessageType.Succeed);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    message(message: 'app is opened pro', state: MessageType.Succeed);
  });
  FirebaseMessaging.onBackgroundMessage(onBackGroundMessage);

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

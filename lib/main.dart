import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api_cloud_db/Shared/network/remote.dart';
import 'package:news_app_api_cloud_db/layouts/news/news.dart';
import 'Shared/bloc_observer.dart';
import 'layouts/news/news_cubit/cubit.dart';

// main method in app
void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  // run my app method
  // param is object from Widget class
  runApp(MyApp());
}

// 1. stateless
// 2. stateful

// main class extends widget
class MyApp extends StatelessWidget {
  // main method of class to build screen UI
  @override
  Widget build(BuildContext context) {
    // material app object wrap all screens
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getEconomics(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
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
        home: Directionality(
          textDirection: TextDirection.ltr,
          child: News(),
        ),
      ),
    );
  }
}

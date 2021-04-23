import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app_api_cloud_db/Shared/network/locale/locale.dart';
import 'file:///C:/Users/MBasha/Desktop/news_app_api_cloud_db/lib/Shared/network/remote/remote.dart';
import 'package:news_app_api_cloud_db/layouts/news/news.dart';
import 'Shared/bloc_observer.dart';
import 'layouts/news/news_cubit/cubit.dart';
import 'layouts/news/news_cubit/states.dart';

// main method in app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  String userCountryNameShPref = CashHelper.getData('country');
  String userCountryCodeShPref = CashHelper.getData('country');
  bool isDarkShPref = CashHelper.getData('isDark');

  runApp(MyApp(
    isDarkShPref: isDarkShPref,
    userCountryNameShPref: userCountryNameShPref,
    userCountryCodeShPref: userCountryCodeShPref,
  ));
}

// main class extends widget
class MyApp extends StatelessWidget {
  MyApp({
    this.isDarkShPref,
    this.userCountryNameShPref,
    this.userCountryCodeShPref,
  });
  final bool isDarkShPref;
  final String userCountryNameShPref;
  final String userCountryCodeShPref;
  // main method of class to build screen UI
  @override
  Widget build(BuildContext context) {
    // material app object wrap all screens
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..changeCountryCode(userCountryCodeShPref)
            ..getDataFromShPrefToHer(
              isDarkPrefSh: isDarkShPref,
              country: userCountryNameShPref,
            ),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
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
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.teal,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: News(),
            ),
          );
        },
      ),
    );
  }
}

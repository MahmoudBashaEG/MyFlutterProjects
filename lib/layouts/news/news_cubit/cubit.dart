import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api_cloud_db/Shared/network/locale/locale.dart';
import 'file:///C:/Users/MBasha/Desktop/news_app_api_cloud_db/lib/Shared/network/remote/remote.dart';
import 'package:news_app_api_cloud_db/layouts/news/news_cubit/states.dart';
import 'package:news_app_api_cloud_db/model/model.dart';
import 'package:news_app_api_cloud_db/modules/business.dart';
import 'package:news_app_api_cloud_db/modules/economic.dart';
import 'package:news_app_api_cloud_db/modules/settings.dart';
import 'package:news_app_api_cloud_db/modules/sport.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = [
    'Business',
    'Sports',
    'Science',
    'Settings',
  ];
  List<Widget> screens = [
    Business(),
    Sport(),
    Economic(),
    Setting(),
  ];

  void getDataFromShPrefToHer({bool isDarkPrefSh, String country}) {
    if (isDarkPrefSh == null)
      isDark = false;
    else
      isDark = isDarkPrefSh;
    selectedUser = country;
  }

  bool isDark = false;

  void changeMode() {
    isDark = !isDark;
    CashHelper.setData(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeModeState());
    });
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(NewsChangeBottomNavBarState());
  }

  String selectedUser;
  String countryCode;

  List<Country> country = [
    Country(countryCode: 'eg', countryName: 'Egypt'),
    Country(countryCode: 'us', countryName: 'United States'),
    Country(countryCode: 'uk', countryName: 'United Kingdom'),
  ];

  void changeCountryName(String countryName) {
    selectedUser = countryName;
    CashHelper.setData(key: 'country', value: selectedUser);
    emit(NewsChangeCountryNameState());
  }

  void changeCountryCode(String value) {
    countryCode = value;
    CashHelper.setData(key: 'countryCode', value: countryCode);
    getBusiness();
    getSports();
    getEconomics();
    emit(NewsChangeCountryCodeState());
  }

  List business = [];

  void getBusiness() {
    emit(NewsBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': countryCode,
        'category': 'business',
        'apiKey': '1c212b053bb0413a9f733b9502b57a87',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsBusinessErrorState());
    });
  }

  List sports = [];

  void getSports() {
    emit(NewsSportsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': countryCode,
        'category': 'sports',
        'apiKey': '1c212b053bb0413a9f733b9502b57a87',
      },
    ).then((value) {
      sports = value.data['articles'];
      emit(NewsSportsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSportsErrorState());
    });
  }

  List economics = [];

  void getEconomics() {
    emit(NewsEconomicsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': countryCode,
        'category': 'science',
        'apiKey': '1c212b053bb0413a9f733b9502b57a87',
      },
    ).then((value) {
      economics = value.data['articles'];
      emit(NewsEconomicsSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(NewsEconomicsErrorState());
    });
  }

  List search = [];

  void getSearch(String value) {
    emit(NewsSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '1c212b053bb0413a9f733b9502b57a87',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchErrorState());
    });
  }
}

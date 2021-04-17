import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api_cloud_db/Shared/network/remote.dart';
import 'package:news_app_api_cloud_db/layouts/news/news_cubit/states.dart';
import 'package:news_app_api_cloud_db/modules/business.dart';
import 'package:news_app_api_cloud_db/modules/economic.dart';
import 'package:news_app_api_cloud_db/modules/sport.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<String> titles = [
    'Business',
    'Sports',
    'Science',
  ];
  List<Widget> screens = [
    Business(),
    Sport(),
    Economic(),
  ];

  bool search = false;
  void isSearch() {
    search = !search;
    emit(NewsSearchState());
  }

  void changeIndex(int index) {
    currentIndex = index;
    emit(NewsChangeBottomNavBarState());
  }

  List business = [];

  Future<void> getBusiness({String about}) {
    emit(NewsBusinessLoadingState());

    return DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': about,
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsBusinessSuccessState());
    }).catchError((error) {
      emit(NewsBusinessErrorState());
    });
  }

  List sports = [];

  void getSports() {
    emit(NewsSportsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      sports = value.data['articles'];
      emit(NewsSportsSuccessState());
    }).catchError((error) {
      emit(NewsSportsErrorState());
    });
  }

  List economics = [];

  void getEconomics() {
    emit(NewsEconomicsLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      economics = value.data['articles'];
      emit(NewsEconomicsSuccessState());
    }).catchError((error) {
      emit(NewsEconomicsErrorState());
    });
  }
}

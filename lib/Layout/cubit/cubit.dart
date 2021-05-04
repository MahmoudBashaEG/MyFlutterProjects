import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Modules/categories_screen/categories.dart';
import 'package:flutter_appp/Modules/favorites_screen/favorites.dart';
import 'package:flutter_appp/Modules/home_screen/home.dart';
import 'package:flutter_appp/Modules/login_screen/login.dart';
import 'package:flutter_appp/Modules/settings_screen/setting.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_appp/Shared/network/remote/remote.dart';
import 'package:flutter_appp/models/categoryModel.dart';
import 'package:flutter_appp/models/userprofiledata.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());
  static ShopCubit get(context) => BlocProvider.of(context);

  int bottomBarIndex = 0;
  List screens = [
    Home(),
    Categories(),
    Favorite(),
    Setting(),
  ];

  void changeBottomBarIndex(int index) {
    bottomBarIndex = index;
    emit(ChangeBottomBarIndexState());
  }

  UserProfileData userProfileData;

  void getProfileData({
    @required String url,
    Map<String, dynamic> query,
    Map<String, dynamic> options,
    String token,
  }) {
    emit(GetProfileDataLoadingState());
    DioHelper.getData(
      query: query,
      specialOptions: options,
      url: url,
      token: token,
    ).then((value) {
      userProfileData = UserProfileData.fromJson(value.data);
      emit(GetProfileDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileDataErrorState());
    });
  }

  CategoryInformation categoryInformation;

  void getCategoryData({
    @required String url,
    Map<String, dynamic> options,
  }) {
    emit(GetCategoryDataLoadingState());
    DioHelper.getData(
      specialOptions: {
        'lang': 'en',
      },
      url: url,
    ).then((value) {
      categoryInformation = CategoryInformation.fromJson(value.data);
      emit(GetCategoryDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryDataErrorState());
    });
  }

  void updateProfileData({
    @required String url,
    @required Map<String, dynamic> data,
    @required String token,
  }) {
    emit(UpdateDataLoadingState());
    DioHelper.updateData(
      url: url,
      data: data,
      token: token,
    ).then((value) {
      print(value.data);
      CashHelper.setData(key: 'userLogInData', value: jsonEncode(allUserData))
          .then((isSet) {
        if (isSet) {
          message(
            message: value.data['message'],
            messageBgColor: Colors.green,
          );
        }
      });
      emit(UpdateDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateDataErrorState());
    });
  }

  Future<void> logOut(
    context, {
    @required String url,
    Map<String, dynamic> data,
    String token,
  }) {
    emit(LogOutLoadingState());
    return DioHelper.postData(
      data: data,
      url: url,
      token: token,
    ).then((value) {
      message(
        message: value.data['message'],
        messageBgColor: Colors.green,
      );
      CashHelper.deleteData(
        key: 'userLogInData',
      ).then((isDelete) {
        if (isDelete) {
          navigatorToAndReplace(
            context: context,
            goTo: LogIn(),
          );
        }
      });
      emit(LogOutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LogOutErrorState());
    });
  }
}

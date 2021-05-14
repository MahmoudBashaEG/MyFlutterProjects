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
import 'package:flutter_appp/Shared/network/end_notes.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_appp/Shared/network/remote/remote.dart';
import 'package:flutter_appp/models/categoryModel.dart';
import 'package:flutter_appp/models/favoriteProducts.dart';
import 'package:flutter_appp/models/updateFavoriteProducts.dart';
import 'package:flutter_appp/models/home_data.dart';
import 'package:flutter_appp/models/searchModel.dart';
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

  HomeData userProfileData;
  Map<int, bool> favorites = {};

  void getProfileData() {
    emit(GetProfileDataLoadingState());
    DioHelper.getData(
      url: HOME,
      token: allUserData.data.token,
    ).then((value) {
      userProfileData = HomeData.fromJson(value.data);
      userProfileData.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavourite,
        });
      });

      emit(GetProfileDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileDataErrorState());
    });
  }

  CategoryInformation categoryInformation;

  void getCategoryData() {
    emit(GetCategoryDataLoadingState());
    DioHelper.getData(
      specialOptions: {
        'lang': 'en',
      },
      url: CATEGORIES,
    ).then((value) {
      categoryInformation = CategoryInformation.fromJson(value.data);
      emit(GetCategoryDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryDataErrorState());
    });
  }

  UpdateFavoriteProducts updateFavoriteProduct;

  void updateProductFavorite({
    int productId,
  }) {
    favorites[productId] = !favorites[productId];
    emit(UpdateFavoriteSuccessState());

    DioHelper.postData(
      token: allUserData.data.token,
      data: {
        "product_id": productId,
      },
      url: FAVORITE,
    ).then((value) {
      updateFavoriteProduct = UpdateFavoriteProducts.fromJson(value.data);
      message(message: value.data['message'], state: MessageType.Succeed);
      emit(UpdateFavoriteSuccessState());
      if (!updateFavoriteProduct.status)
        favorites[productId] = !favorites[productId];
      getProductFavorite();
    }).catchError((error) {
      print(error.toString());
      favorites[productId] = !favorites[productId];
      emit(UpdateFavoriteErrorState());
    });
  }

  FavoriteProductsData favoriteProductsData;

  void getProductFavorite() {
    emit(GetFavoriteLoadingState());
    DioHelper.getData(
      url: FAVORITE,
      token: allUserData.data.token,
    ).then((value) {
      favoriteProductsData = FavoriteProductsData.fromJson(value.data);
      print(favoriteProductsData.favoriteProducts[0].image);
      print(favoriteProductsData.favoriteProducts[0].name);
      print(favoriteProductsData.favoriteProducts[0].price);
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoriteErrorState());
    });
  }

  SearchData searchResult;

  void search({
    @required String searchInput,
    String onChangeValue,
  }) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: allUserData.data.token,
      data: {
        'text': searchInput,
      },
    ).then((value) {
      if (value.data['status'] && onChangeValue != '') {
        searchResult = SearchData.fromJson(value.data['data']['data']);
      } else {
        searchResult = null;
      }
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }

  void updateProfileData({
    @required Map<String, dynamic> data,
  }) {
    emit(UpdateDataLoadingState());
    DioHelper.updateData(
      url: UPDATE,
      data: data,
      token: allUserData.data.token,
    ).then((value) {
      print(value.data);
      CashHelper.setData(key: 'userLogInData', value: jsonEncode(allUserData))
          .then((isSet) {
        if (isSet) {
          message(message: value.data['message'], state: MessageType.Succeed);
        }
      });
      emit(UpdateDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      message(
        message: 'الرجاء التحقق من الانترنت',
        state: MessageType.Error,
      );
      emit(UpdateDataErrorState());
    });
  }

  Future<void> logOut(
    context, {
    Map<String, dynamic> data,
  }) {
    emit(LogOutLoadingState());
    return DioHelper.postData(
      data: data,
      url: LOGOUT,
      token: allUserData.data.token,
    ).then((value) {
      message(message: value.data['message'], state: MessageType.Succeed);
      if (value.data['status']) {
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
      }

      emit(LogOutSuccessState());
    }).catchError((error) {
      print(error.toString());
      message(message: 'الرجاء التحقق من الانترنت', state: MessageType.Warning);
      emit(LogOutErrorState());
    });
  }
}

import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Modules/cart.dart';
import 'package:flutter_appp/Modules/categories_screen/categories.dart';
import 'package:flutter_appp/Modules/favorites_screen/favorites.dart';
import 'package:flutter_appp/Modules/home_screen/home.dart';
import 'package:flutter_appp/Modules/login_screen/login.dart';
import 'package:flutter_appp/Modules/settings_screen/setting.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/end_points.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_appp/Shared/network/remote/remote.dart';
import 'package:flutter_appp/models/cartModel.dart';
import 'package:flutter_appp/models/categoryModel.dart';
import 'package:flutter_appp/models/favoriteProducts.dart';
import 'package:flutter_appp/models/translate.dart';
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
    Cart(),
    Setting(),
  ];
  Translator translation;
  void getTranslation(context) async {
    emit(ShopAppTranslateLoadingState());
    String data;
    if (lan == 'en') {
      print('en');
      data = await DefaultAssetBundle.of(context)
          .loadString("assets/translation/en.json");
    }
    if (lan == 'ar') {
      print('ar');
      data = await DefaultAssetBundle.of(context)
          .loadString("assets/translation/ar.json");
    }
    final jsonResult = json.decode(data);
    translation = Translator.fromJson(jsonResult);
    emit(ShopAppTranslateSuccessState());
    restartTheDataWithNewLanguage();
  }

  void changeLanguage(context, String language) {
    lan = language;
    getTranslation(context);
  }

  void changeBottomBarIndex(int index) {
    bottomBarIndex = index;
    emit(ChangeBottomBarIndexState());
  }

  HomeData userProfileData;
  Map<int, bool> inFavorites = {};
  Map<int, bool> inCarts = {};

  void getProfileData() {
    emit(GetProfileDataLoadingState());
    DioHelper.getData(
      url: HOME,
      token: allUserData.data.token,
      lan: lan,
    ).then((value) {
      userProfileData = HomeData.fromJson(value.data);

      userProfileData.data.products.forEach((element) {
        inFavorites.addAll({
          element.id: element.inFavourite,
        });
        inCarts.addAll({
          element.id: element.inCart,
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
      url: CATEGORIES,
      lan: lan,
    ).then((value) {
      categoryInformation = CategoryInformation.fromJson(value.data);
      emit(GetCategoryDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryDataErrorState());
    });
  }

  FavoriteProductsData productsOfCategory;
  void getProductsOfCategory({int id}) {
    emit(GetProductsOfCategoryLoadingState());
    DioHelper.getData(
      url: PRODUCTS,
      query: {'category_id': id},
      lan: lan,
      token: allUserData.data.token,
    ).then((value) {
      productsOfCategory = FavoriteProductsData.fromJson(value.data);
      emit(GetProductsOfCategorySuccessState());
    }).catchError((err) {
      print(err.toString());
      emit(GetProductsOfCategoryErrorState());
    });
  }

  UpdateFavoriteProducts updateFavoriteProduct;

  void updateProductFavorite({
    int productId,
  }) {
    inFavorites[productId] = !inFavorites[productId];
    emit(UpdateFavoriteSuccessState());

    DioHelper.postData(
            token: allUserData.data.token,
            data: {
              "product_id": productId,
            },
            url: FAVORITE,
            lan: lan)
        .then((value) {
      updateFavoriteProduct = UpdateFavoriteProducts.fromJson(value.data);
      if (updateFavoriteProduct.status) {
        message(
            message: updateFavoriteProduct.message, state: MessageType.Succeed);
      }

      if (!updateFavoriteProduct.status)
        inFavorites[productId] = !inFavorites[productId];
      getProductFavorite();
    }).catchError((error) {
      print(error.toString());
      inFavorites[productId] = !inFavorites[productId];
      emit(UpdateFavoriteErrorState());
    });
  }

  FavoriteProductsData favoriteProductsData;

  void getProductFavorite() {
    emit(GetFavoriteLoadingState());
    DioHelper.getData(url: FAVORITE, token: allUserData.data.token, lan: lan)
        .then((value) {
      favoriteProductsData = FavoriteProductsData.fromJson(value.data);
      emit(GetFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoriteErrorState());
    });
  }

  CartProductsData cartProductsData;

  void getProductCart() {
    emit(GetCartLoadingState());
    DioHelper.getData(url: CART, token: allUserData.data.token, lan: lan)
        .then((value) {
      cartProductsData = CartProductsData.fromJson(value.data);
      emit(GetCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCartErrorState());
    });
  }

  void updateProductCart({
    int productId,
  }) {
    inCarts[productId] = !inCarts[productId];
    emit(UpdateCartSuccessState());

    DioHelper.postData(
            token: allUserData.data.token,
            data: {
              "product_id": productId,
            },
            url: CART,
            lan: lan)
        .then((value) {
      if (value.data['status']) {
        message(message: value.data['message'], state: MessageType.Succeed);
      }

      if (!value.data['status']) inCarts[productId] = !inCarts[productId];
      getProductCart();
    }).catchError((error) {
      print(error.toString());
      inCarts[productId] = !inCarts[productId];
      emit(UpdateCartErrorState());
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
            lan: lan)
        .then((value) {
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
            url: UPDATE, data: data, token: allUserData.data.token, lan: lan)
        .then((value) {
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
            bottomBarIndex = 0;
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

  void restartTheDataWithNewLanguage() {
    this.getCategoryData();
    this.getProductCart();
    this.getProductFavorite();
    this.getProfileData();
  }
}

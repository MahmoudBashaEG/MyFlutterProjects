import 'package:flutter_appp/models/categoryModel.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates {}

class ShopAppTranslateSuccessState extends ShopStates {}

class ShopAppTranslateLoadingState extends ShopStates {}

class ChangeBottomBarIndexState extends ShopStates {}

class GetProfileDataLoadingState extends ShopStates {}

class GetProfileDataSuccessState extends ShopStates {}

class GetProfileDataErrorState extends ShopStates {}

class GetCategoryDataLoadingState extends ShopStates {}

class GetCategoryDataSuccessState extends ShopStates {}

class GetCategoryDataErrorState extends ShopStates {}

class GetCategoryProductsLoadingState extends ShopStates {}

class GetCategoryProductsSuccessState extends ShopStates {
  Category category;
  GetCategoryProductsSuccessState({this.category});
}

class GetCategoryProductsErrorState extends ShopStates {}

class UpdateDataLoadingState extends ShopStates {}

class UpdateDataSuccessState extends ShopStates {}

class UpdateDataErrorState extends ShopStates {}

class UpdateFavoriteLoadingState extends ShopStates {}

class UpdateFavoriteSuccessState extends ShopStates {}

class UpdateFavoriteErrorState extends ShopStates {}

class UpdateCartLoadingState extends ShopStates {}

class UpdateCartSuccessState extends ShopStates {}

class UpdateCartErrorState extends ShopStates {}

class GetFavoriteLoadingState extends ShopStates {}

class GetFavoriteSuccessState extends ShopStates {}

class GetFavoriteErrorState extends ShopStates {}

class GetCartLoadingState extends ShopStates {}

class GetCartSuccessState extends ShopStates {}

class GetCartErrorState extends ShopStates {}

class SearchLoadingState extends ShopStates {}

class SearchSuccessState extends ShopStates {}

class SearchErrorState extends ShopStates {}

class LogOutLoadingState extends ShopStates {}

class LogOutSuccessState extends ShopStates {}

class LogOutErrorState extends ShopStates {}

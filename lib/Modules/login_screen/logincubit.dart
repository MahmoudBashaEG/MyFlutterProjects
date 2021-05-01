import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appp/Modules/login_screen/loginstates.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/remote/remote.dart';
import 'package:flutter_appp/models/userInformation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitialState());
  static LogInCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  void showPassword() {
    isPassword = !isPassword;
    emit(LogInShowPasswordState());
  }

  UserModel userModel;

  Future<void> post({
    @required String url,
    @required Map<String, dynamic> data,
  }) {
    emit(LogInLoadingState());

    return DioHelper.postData(
      url: url,
      data: data,
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      if (userModel.status) {
        CashHelper.setData(key: 'userData', value: jsonEncode(value.data));
      } else {}

      emit(LogInSuccessState());
    }).catchError((error) {
      emit(LogInErrorState());
      print(error.toString());
    });
  }
}

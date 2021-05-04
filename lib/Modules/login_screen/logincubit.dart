import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/app/app.dart';
import 'package:flutter_appp/Modules/login_screen/loginstates.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
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

  UserLogInModel userLogInModel;

  Future<void> logIn(
    context, {
    @required String url,
    @required Map<String, dynamic> data,
  }) {
    emit(LogInLoadingState());
    return DioHelper.postData(
      url: url,
      data: data,
    ).then((value) {
      if (value.data['status']) {
        message(
          message: value.data['message'],
          messageBgColor: Colors.green,
        );
        userLogInModel = UserLogInModel.fromJson(value.data);
        allUserData = UserLogInModel.fromJson(value.data);
        CashHelper.setData(key: 'userLogInData', value: jsonEncode(value.data))
            .then((value) {
          navigatorToAndReplace(context: context, goTo: App());
        });
      } else {
        message(
          message: value.data['message'],
          messageBgColor: Colors.red,
        );
      }
      emit(LogInSuccessState());
    }).catchError((error) {
      message(
        message: 'الرجاء التحقق من الاتصال بالانترنت',
        messageBgColor: Colors.red,
      );
      emit(LogInErrorState());
      print(error.toString());
    });
  }
}

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/app/app.dart';
import 'package:flutter_appp/Modules/register_screen/registerstates.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/end_points.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_appp/Shared/network/remote/remote.dart';
import 'package:flutter_appp/models/userInformation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void register(
    context, {
    @required Map<String, dynamic> data,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: data,
    ).then((value) async {
      print(value.data);
      if (value.data['status']) {
        allUserData = UserLogInModel.fromJson(value.data);
        message(
          message: value.data['message'],
          state: MessageType.Succeed,
        );
        await CashHelper.setData(key: 'lan', value: 'en');
        CashHelper.setData(key: 'userLogInData', value: jsonEncode(value.data))
            .then((value) {
          if (value) {
            navigatorToAndReplace(context: context, goTo: App());
          }
        });
      } else {
        message(
          message: value.data['message'],
          messageColor: Colors.white,
          state: MessageType.Warning,
        );
      }

      emit(RegisterSuccessState());
    }).catchError((error) {
      message(
        message: 'الرجاء التحقق من الاتصال بالانترنت',
        state: MessageType.Error,
      );
      print(error.toString());
      emit(RegisterErrorState());
    });
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_appp/Modules/register_screen/registerstates.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/remote/remote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void post({
    @required Map<String, dynamic> data,
    @required url,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: url,
      data: data,
    ).then((value) {
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
    });
  }
}

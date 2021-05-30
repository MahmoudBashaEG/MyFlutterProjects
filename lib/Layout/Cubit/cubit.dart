import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Models/userModel.dart';
import 'package:socialapp/Modules/chat/chat_screen.dart';
import 'package:socialapp/Modules/home/home_screen.dart';
import 'package:socialapp/Modules/settings/setting_screen.dart';
import 'package:socialapp/Modules/users/users_screen.dart';
import 'package:socialapp/globalVariable.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> titles = [
    'Home',
    'Chat',
    'Users',
    'Settings',
  ];
  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    UserScreen(),
    SettingScreen(),
  ];
  void changeBottomNavIndex(int index) {
    currentIndex = index;
    emit(ChangeNavBarIndexState());
  }

  UserData userData;
  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userUid)
        .get()
        .then((value) {
      userData = UserData.fromJson(value.data());
      print(userData.uid);
      emit(SocialGetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserDataErrorState());
    });
  }

  void logOut() {
    emit(SocialLogOutLoadingState());
    FirebaseAuth.instance.signOut().then(
      (value) {
        emit(SocialLogOutSuccessState());
      },
    ).catchError((error) {
      emit(SocialLogOutErrorState());
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialapp/Models/userModel.dart';
import 'package:socialapp/Shared/network/locale/locale.dart';
import 'package:socialapp/globalVariable.dart';

import '../../Shared/Components/Components.dart';
import 'EnterStates.dart';

class EnterCubit extends Cubit<EnterStates> {
  EnterCubit() : super(EnterInitialState());

  static EnterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  void showPassword() {
    isPassword = !isPassword;
    emit(LogInShowPasswordState());
  }

  void login({
    @required String email,
    @required String password,
  }) {
    emit(LogInEmailLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(LogInEmailSuccessState(message: 'LogIn Succeeded'));
    }).catchError((error) {
      emit(LogInEmailErrorState(
        error: error.toString(),
      ));
    });
  }

  void signInWithGoogle() {
    Future<UserCredential> signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    emit(LogInGoogleLoadingState());
    signInWithGoogle().then(
      (value) {
        UserData userDataGoogle = UserData(
          email: value.user.email,
          uid: value.user.uid,
          name: value.user.displayName,
          isVerified: value.user.emailVerified,
          phone: value.user.phoneNumber,
        );
        createUser(
          succeededMessage: 'LogIn Succeeded',
          userData: userDataGoogle.getMap(),
          uid: userDataGoogle.uid,
        );
      },
    ).catchError(
      (error) {
        message(message: error.toString(), state: MessageType.Error);
        emit(LogInGoogleErrorState(error: error.toString()));
      },
    );
  }

  void registerEmail({
    @required String email,
    @required String password,
    @required String phone,
    @required String name,
  }) {
    emit(SignUpEmailLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      UserData userData = UserData(
        email: email,
        isVerified: value.user.emailVerified,
        name: name,
        uid: value.user.uid,
        phone: phone,
      );

      createUser(
        succeededMessage: 'Register Succeeded',
        uid: value.user.uid,
        userData: userData.getMap(),
      );
    }).catchError((error) {
      print(error.toString());
      message(message: error.toString(), state: MessageType.Error);
      emit(SignUpEmailErrorState());
    });
  }

  void createUser({
    String uid,
    Map<String, dynamic> userData,
    @required String succeededMessage,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userData)
        .then((value) {
      CashHelper.setData(key: 'uid', value: uid);
      userUid = uid;
      emit(CreateUserSuccessState(message: succeededMessage));
    }).catchError((error) {
      emit(CreateUserErrorState(error: error.toString()));
    });
  }

  void phoneAuth({
    String number,
    String code,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    emit(SignUpPhoneLoadingState());
    await auth.verifyPhoneNumber(
      phoneNumber: '+90$number',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        print('start');
        emit(SignUpPhoneSuccessState());
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          emit(SignUpPhoneErrorState());
        }
      },
      codeSent: (String verificationId, int resendToken) async {
        String smsCode = code;
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);
        print('verified');
        emit(SignUpPhoneSuccessState());

        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Modules/login_screen/login.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/end_notes.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Setting extends StatelessWidget {
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      defaultTextFormField(
                        label: 'Name',
                        controller: userName,
                        prefixIcon: FontAwesomeIcons.personBooth,
                        validate: 'Name Must Not Be Empty',
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        label: 'Email',
                        controller: userEmail,
                        prefixIcon: FontAwesomeIcons.voicemail,
                        validate: 'Email Must Not Be Empty',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        label: 'Phone',
                        controller: userPhone,
                        prefixIcon: FontAwesomeIcons.phone,
                        validate: 'Phone Must Not Be Empty',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        label: 'Password',
                        controller: userPassword,
                        isPassword: true,
                        prefixIcon: FontAwesomeIcons.lock,
                        validate: 'Password Must Not Be Empty',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: defaultButton(
                          text: 'Update',
                          press: () {
                            if (formKey.currentState.validate()) {
                              ShopCubit.get(context).updateProfileData(
                                url: UPDATE,
                                token: allUserData.data.token,
                                data: {
                                  "name": userName.text,
                                  "phone": userPhone.text,
                                  "email": userEmail.text,
                                  "password": userPassword.text,
                                },
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: defaultButton(
                            text: 'Log Out',
                            press: () {
                              ShopCubit.get(context).logOut(
                                context,
                                url: LOGOUT,
                                data: {
                                  'fcm_token': 'SomeFcmToken',
                                },
                                token: allUserData.data.token,
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

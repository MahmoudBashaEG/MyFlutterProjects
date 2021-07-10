import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Modules/login_screen/login.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/end_points.dart';
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
    return BlocConsumer<ShopCubit, ShopStates>(
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
                      label: ShopCubit.get(context).translation.name,
                      controller: userName,
                      prefixIcon: FontAwesomeIcons.personBooth,
                      validate:
                          ShopCubit.get(context).translation.nameValidator,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      label: ShopCubit.get(context).translation.email,
                      controller: userEmail,
                      prefixIcon: FontAwesomeIcons.voicemail,
                      validate:
                          ShopCubit.get(context).translation.emailValidator,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      label: ShopCubit.get(context).translation.phone,
                      controller: userPhone,
                      prefixIcon: FontAwesomeIcons.phone,
                      validate:
                          ShopCubit.get(context).translation.phoneValidator,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      label: ShopCubit.get(context).translation.password,
                      controller: userPassword,
                      isPassword: true,
                      prefixIcon: FontAwesomeIcons.lock,
                      validate:
                          ShopCubit.get(context).translation.passwordValidator,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: defaultButton(
                        text: ShopCubit.get(context).translation.update,
                        press: () {
                          if (formKey.currentState.validate()) {
                            ShopCubit.get(context).updateProfileData(
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
                          text: ShopCubit.get(context).translation.LogOut,
                          press: () {
                            ShopCubit.get(context).logOut(
                              context,
                              data: {
                                'fcm_token': 'SomeFcmToken',
                              },
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
    );
  }
}

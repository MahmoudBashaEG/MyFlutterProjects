import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Modules/EnterApp/EnterCubit.dart';
import 'package:socialapp/Modules/EnterApp/EnterStates.dart';
import 'package:socialapp/Shared/Components/Components.dart';
import 'package:socialapp/Shared/styles/colors.dart';

// ignore: must_be_immutable
class RegisterWithPhone extends StatelessWidget {
  TextEditingController phone = TextEditingController();
  TextEditingController code = TextEditingController();
  ScrollController con = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EnterCubit, EnterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SingleChildScrollView(
                controller: con,
                child: Column(
                  children: [
                    if (state is! SignUpPhoneSuccessState)
                      defaultTextFormField(
                        label: 'Phone Number',
                        controller: phone,
                        prefixIcon: Icons.phone,
                        validate: 'Phone Number must be entered',
                        keyboardType: TextInputType.number,
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    if (state is SignUpPhoneSuccessState)
                      defaultTextFormField(
                        label: 'Code',
                        controller: code,
                        prefixIcon: Icons.code,
                        validate: 'Code must be entered',
                        keyboardType: TextInputType.number,
                      ),
                    SizedBox(
                      height: 30,
                    ),
                    if (state is! SignUpPhoneSuccessState)
                      defaultButtonWithRadius(
                        text: 'Send Code',
                        backgroundColor: defaultColor,
                        press: () {
                          EnterCubit.get(context).phoneAuth(
                            number: phone.text,
                          );
                        },
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    if (state is SignUpPhoneSuccessState)
                      defaultButtonWithRadius(
                        text: 'Confirm',
                        backgroundColor: defaultColor,
                        press: () {
                          EnterCubit.get(context).phoneAuth(code: code.text);
                        },
                      ),
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

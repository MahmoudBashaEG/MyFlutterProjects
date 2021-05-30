import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/app.dart';
import 'package:socialapp/Modules/EnterApp/login/login.dart';
import 'package:socialapp/Modules/EnterApp/EnterCubit.dart';
import 'package:socialapp/Modules/EnterApp/EnterStates.dart';
import 'package:socialapp/Shared/styles/colors.dart';
import '../../../Shared/Components/Components.dart';
import 'RegisterWithPhone.dart';

class Register extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EnterCubit, EnterStates>(
      listener: (context, state) {
        if (state is CreateUserSuccessState) {
          message(
              message: state.message.toString(), state: MessageType.Succeed);
          navigatorToAndReplace(context: context, goTo: SocialLayout());
        }
        if (state is CreateUserErrorState) {
          message(message: state.error.toString(), state: MessageType.Error);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Register Now to browse out hot offers',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        defaultTextFormField(
                          label: 'User Name',
                          controller: name,
                          prefixIcon: Icons.account_circle,
                          validate: 'Name must be entered',
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        defaultTextFormField(
                            label: 'Email Address',
                            controller: email,
                            prefixIcon: Icons.email,
                            validate: 'email must be entered',
                            keyboardType: TextInputType.emailAddress),
                        SizedBox(
                          height: 25,
                        ),
                        defaultTextFormField(
                          label: 'Password',
                          controller: password,
                          prefixIcon: Icons.lock,
                          validate: 'Password must be entered',
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        defaultTextFormField(
                            label: 'Phone',
                            controller: phone,
                            prefixIcon: Icons.phone,
                            validate: 'Phone must be entered',
                            keyboardType: TextInputType.phone),
                        SizedBox(
                          height: 30,
                        ),
                        if (state is SignUpEmailLoadingState)
                          Center(child: CircularProgressIndicator()),
                        if (state is! SignUpEmailLoadingState)
                          defaultButtonWithRadius(
                            backgroundColor: defaultColor,
                            text: 'Register With Email',
                            press: () {
                              if (formKey.currentState.validate()) {
                                EnterCubit.get(context).registerEmail(
                                  email: email.text,
                                  password: password.text,
                                  name: name.text,
                                  phone: phone.text,
                                );
                              }
                            },
                          ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultButtonWithRadius(
                          backgroundColor: defaultColor,
                          text: 'Register With Phone',
                          press: () {
                            navigatorTo(
                                context: context, goTo: RegisterWithPhone());
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'OR',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              navigatorToAndReplace(
                                context: context,
                                goTo: LogIn(),
                              );
                            },
                            child: Text(
                              'LogIn With Email Or Google',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (5 == 1)
                          defaultButtonWithRadius(
                            text: 'Register With Phone',
                            backgroundColor: defaultColor,
                            press: () {
                              navigatorTo(
                                  context: context, goTo: RegisterWithPhone());
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

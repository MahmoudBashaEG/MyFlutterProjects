import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/app/app.dart';
import 'package:flutter_appp/Modules/login_screen/logincubit.dart';
import 'package:flutter_appp/Modules/login_screen/loginstates.dart';
import 'package:flutter_appp/Modules/register_screen/register.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_appp/Shared/network/end_points.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController userEmail = TextEditingController();
    TextEditingController userPassword = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();

    return BlocProvider(
      create: (context) => LogInCubit(),
      child: BlocConsumer<LogInCubit, LogInState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Login Now to browse out hot offers',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          label: 'Email',
                          controller: userEmail,
                          prefixIcon: Icons.email_rounded,
                          keyboardType: TextInputType.emailAddress,
                          validate: 'email address must not be empty',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          label: 'Password',
                          controller: userPassword,
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: LogInCubit.get(context).isPassword,
                          suffixIcon: LogInCubit.get(context).isPassword
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          validate: 'password must not be empty',
                          suffixIconOnPress: () {
                            LogInCubit.get(context).showPassword();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (state is LogInLoadingState)
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        if (state is! LogInLoadingState)
                          Container(
                            width: double.infinity,
                            child: defaultButton(
                              text: 'Log In',
                              press: () {
                                if (formKey.currentState.validate()) {
                                  LogInCubit.get(context).logIn(
                                    context,
                                    data: {
                                      'email': userEmail.text,
                                      'password': userPassword.text,
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(),
                            ),
                            TextButton(
                              onPressed: () {
                                navigatorTo(
                                  context: context,
                                  goTo: Register(),
                                );
                              },
                              child: Text('Register Now'),
                            )
                          ],
                        )
                      ],
                    ),
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

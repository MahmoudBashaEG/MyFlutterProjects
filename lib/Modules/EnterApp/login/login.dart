import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/Layout/app.dart';
import 'package:socialapp/Modules/EnterApp/login/forgetPassword.dart';
import 'package:socialapp/Modules/EnterApp/register/register.dart';
import 'package:socialapp/Shared/styles/colors.dart';
import '../../../Shared/Components/Components.dart';
import '../EnterCubit.dart';
import '../EnterStates.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController userEmail = TextEditingController();
    TextEditingController userPassword = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey();

    return BlocConsumer<EnterCubit, EnterStates>(
      listener: (context, state) {
        if (state is LogInEmailSuccessState) {
          message(message: 'Succeeded', state: MessageType.Succeed);
          navigatorToAndReplace(context: context, goTo: SocialLayout());
        }
        if (state is LogInEmailErrorState)
          message(message: state.error, state: MessageType.Error);
      },
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
                        style: Theme.of(context).textTheme.bodyText1,
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
                        isPassword: EnterCubit.get(context).isPassword,
                        suffixIcon: EnterCubit.get(context).isPassword
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        validate: 'password must not be empty',
                        suffixIconOnPress: () {
                          EnterCubit.get(context).showPassword();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is LogInEmailLoadingState)
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      if (state is! LogInEmailLoadingState)
                        Container(
                            width: double.infinity,
                            child: defaultButtonWithRadius(
                              text: 'Log In',
                              press: () {
                                if (formKey.currentState.validate()) {
                                  EnterCubit.get(context).login(
                                    email: userEmail.text,
                                    password: userPassword.text,
                                  );
                                }
                              },
                              backgroundColor: defaultColor,
                            )),
                      SizedBox(
                        height: 20,
                      ),
                      if (state is! LogInGoogleLoadingState)
                        defaultButtonWithRadius(
                          text: 'LogIn With Google',
                          backgroundColor: defaultColor,
                          press: () {
                            EnterCubit.get(context).signInWithGoogle();
                          },
                        ),
                      if (state is LogInGoogleLoadingState)
                        Center(child: CircularProgressIndicator()),
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
                              navigatorTo(context: context, goTo: Register());
                            },
                            child: Text('Register Now'),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => ForgetPasswordPobUp(),
                                );
                              },
                              child: Text('Forget Password'))
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_appp/Modules/register_screen/registercubit.dart';
import 'package:flutter_appp/Modules/register_screen/registerstates.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_appp/Shared/network/end_notes.dart';

class Register extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {},
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
                          if (state is RegisterLoadingState)
                            Center(child: CircularProgressIndicator()),
                          if (state is! RegisterLoadingState)
                            Container(
                              width: double.infinity,
                              child: defaultButton(
                                text: 'Register',
                                press: () {
                                  if (formKey.currentState.validate()) {
                                    RegisterCubit.get(context).register(
                                      context,
                                      data: {
                                        'name': name.text,
                                        'phone': password.text,
                                        'email': email.text,
                                        'password': phone.text,
                                        'image': '',
                                      },
                                    );
                                  }
                                },
                              ),
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
      ),
    );
  }
}

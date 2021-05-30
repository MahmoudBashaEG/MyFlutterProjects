import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/Shared/Components/Components.dart';

class ForgetPasswordPobUp extends StatelessWidget {
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Reset Your Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          defaultTextField(
            controller: email,
            label: 'Email',
            suffixIcon: Icons.email,
            prefixIcon: null,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Reset'),
          onPressed: () {
            FirebaseAuth.instance.sendPasswordResetEmail(
              email: email.toString().trim(),
            );
          },
        ),
      ],
    );
  }
}

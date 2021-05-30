import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Shared/Components/Components.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConditionalBuilder(
        condition: SocialCubit.get(context).userData != null,
        builder: (context) => Column(
          children: [],
        ),
        fallback: (context) => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

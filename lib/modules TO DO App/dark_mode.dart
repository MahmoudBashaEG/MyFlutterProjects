import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Shared/Components/Components.dart';
import 'package:flutter_app/layouts/cubit/cubit.dart';
import 'package:flutter_app/layouts/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomCubit, BottomStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BottomCubit.get(context).isDark
                ? Text('Dark Mode')
                : Text('Light Mode'),
          ),
          body: Center(
            child: defaultButton(
              text:
                  BottomCubit.get(context).isDark ? 'Dark Mode' : 'Light Mode',
              color: Colors.blue,
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              press: () {
                BottomCubit.get(context).changeMode();
              },
            ),
          ),
        );
      },
    );
  }
}

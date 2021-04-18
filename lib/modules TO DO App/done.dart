import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Shared/Components/Components.dart';
import 'package:flutter_app/layouts/cubit/cubit.dart';
import 'package:flutter_app/layouts/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Done extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomCubit, BottomStates>(
      listener: (context, state) {
        if (state is BottomInsertDataSuccessState) {
          navigatorBack(context: context);
        }
      },
      builder: (context, state) {
        List list = BottomCubit.get(context).doneTasks;

        return Scaffold(
          body: itemBuilder(list, context),
        );
      },
    );
  }
}

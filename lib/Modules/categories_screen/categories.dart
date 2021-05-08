import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/end_notes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is! GetCategoryDataLoadingState &&
                ShopCubit.get(context).categoryInformation != null,
            builder: (context) => ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => categoryItem(
                  ShopCubit.get(context).categoryInformation.data.data[index]),
              itemCount:
                  ShopCubit.get(context).categoryInformation.data.data.length,
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

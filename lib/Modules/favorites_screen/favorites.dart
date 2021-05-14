import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/styles/colors.dart';
import 'package:flutter_appp/models/favoriteProducts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: ShopCubit.get(context)
                    .favoriteProductsData
                    .favoriteProducts
                    .length >
                0,
            builder: (context) => ConditionalBuilder(
              condition: state is! GetFavoriteLoadingState,
              builder: (context) => ListView.builder(
                itemCount: ShopCubit.get(context)
                    .favoriteProductsData
                    .favoriteProducts
                    .length,
                itemBuilder: (context, index) => favoriteProductItemBuilder(
                  ShopCubit.get(context)
                      .favoriteProductsData
                      .favoriteProducts[index],
                  context,
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            fallback: (context) => Center(
              child: Text(
                'No Data',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              condition: state is! GetFavoriteLoadingState &&
                  state is! UpdateFavoriteSuccessState,
              builder: (context) => ListView.builder(
                itemCount: ShopCubit.get(context)
                    .favoriteProductsData
                    .favoriteProducts
                    .length,
                itemBuilder: (context, index) => favoriteCartProductItemBuilder(
                  context,
                  cubit: ShopCubit.get(context),
                  product: ShopCubit.get(context)
                      .favoriteProductsData
                      .favoriteProducts[index],
                  isFavorite: true,
                  isCart: false,
                ),
              ),
              fallback: (context) => LinearProgressIndicator(),
            ),
            fallback: (context) => Center(
              child: Text(
                ShopCubit.get(context).translation.noFavorites,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}

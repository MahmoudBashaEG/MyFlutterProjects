import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/models/cartModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition:
                ShopCubit.get(context).cartProductsData.cartProducts.length > 0,
            builder: (context) => ConditionalBuilder(
              condition: state is! GetCartLoadingState &&
                  state is! UpdateCartSuccessState,
              builder: (context) => Column(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: 'Total:',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    TextSpan(
                      text:
                          '${ShopCubit.get(context).cartProductsData.cartProducts.reduce((value, element) => ProductData(price: value.price + element.price)).price}',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ])),
                  Expanded(
                    child: ListView.builder(
                      itemCount: ShopCubit.get(context)
                          .cartProductsData
                          .cartProducts
                          .length,
                      itemBuilder: (context, index) =>
                          favoriteCartProductItemBuilder(
                        context,
                        cubit: ShopCubit.get(context),
                        product: ShopCubit.get(context)
                            .cartProductsData
                            .cartProducts[index],
                        isCart: true,
                        isFavorite: false,
                      ),
                    ),
                  )
                ],
              ),
              fallback: (context) => LinearProgressIndicator(),
            ),
            fallback: (context) => Center(
              child: Text(
                ShopCubit.get(context).translation.noCarts,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget {
  const Cart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: lan == 'en' ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(
            body: ConditionalBuilder(
              condition: ShopCubit.get(context).cartProductsData != null &&
                  state is! UpdateCartSuccessState &&
                  state is! GetCartLoadingState,
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (ShopCubit.get(context)
                          .cartProductsData
                          .cartProducts
                          .length >
                      0)
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Total: ',
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                            text:
                                '${ShopCubit.get(context).cartProductsData.total}',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ShopCubit.get(context).cartProductsData.cartProducts.length >
                          0
                      ? Expanded(
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
                      : Center(
                          child: Text(
                            ShopCubit.get(context).translation.noCarts,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                ],
              ),
              fallback: (context) => LinearProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

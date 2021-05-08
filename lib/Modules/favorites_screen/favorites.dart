import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.favoriteData != null,
            builder: (context) => ConditionalBuilder(
              condition: cubit.favoriteData.favoriteProducts.length != 0,
              builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    favoriteItemBuilder(cubit, index),
                itemCount: cubit.favoriteData.favoriteProducts.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 5,
                ),
              ),
              fallback: (context) => Center(child: Text('No Favorites')),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget favoriteItemBuilder(ShopCubit cubit, int index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 110,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                      cubit.favoriteData.favoriteProducts[index].image),
                )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      cubit.favoriteData.favoriteProducts[index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${cubit.favoriteData.favoriteProducts[index].oldPrice}',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${cubit.favoriteData.favoriteProducts[index].oldPrice}',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                            color: Colors.blue,
                            icon: FaIcon(FontAwesomeIcons.heart),
                            onPressed: () {
                              cubit.updateProductFavorite(
                                productId: cubit
                                    .userProfileData.data.products[index].id,
                              );
                            })
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}

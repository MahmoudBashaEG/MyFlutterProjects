import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_appp/models/ProductModel.dart';
import 'package:flutter_appp/models/categoryModel.dart';
import 'package:flutter_appp/models/categoryProductsModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CategoryProduct extends StatelessWidget {
  Category category;
  CategoryProduct({this.category});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: lan == 'en' ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('${category.name}'),
            ),
            body: ConditionalBuilder(
              condition: ShopCubit.get(context).categoryProducts != null,
              builder: (context) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.filter),
                          color: Colors.pink,
                        ),
                        Text(
                          'Filter',
                          style: TextStyle(color: Colors.pink),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.thLarge),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.list),
                        ),
                      ],
                    ),
                    if (ShopCubit.get(context)
                            .categoryProducts
                            .categoryProducts
                            .length >
                        0)
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ListViewCategoryItem(
                          product: ShopCubit.get(context)
                              .categoryProducts
                              .categoryProducts[index],
                        ),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: ShopCubit.get(context)
                            .categoryProducts
                            .categoryProducts
                            .length,
                      ),
                    if (ShopCubit.get(context)
                            .categoryProducts
                            .categoryProducts
                            .length <
                        0)
                      Text(
                        'No Products tat related to this category',
                        style: TextStyle(color: Colors.red),
                      )
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}

class GridViewCategoryProducts extends StatelessWidget {
  GridViewCategoryProducts() : super();
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1 / 2,
      children: [
        ...List.generate(
            ShopCubit.get(context).categoryInformation.categories.length,
            (index) => GridViewCategoryItem())
      ],
    );
  }
}

class GridViewCategoryItem extends StatelessWidget {
  GridViewCategoryItem() : super();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text('hello')],
    );
  }
}

class ListViewCategoryItem extends StatelessWidget {
  ListViewCategoryItem({this.product});
  Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Image(
                image: NetworkImage(
                  product.image,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.name}',
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'From ',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          TextSpan(
                            text: '${product.price}',
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 5,
                          minRating: 1,
                          itemSize: 15,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            size: 1,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text('(1)'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        if (ShopCubit.get(context).inFavorites[product.id])
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            color:
                                ShopCubit.get(context).inFavorites[product.id]
                                    ? Colors.green
                                    : Colors.red,
                            child: Text(
                              'In Favorite',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        SizedBox(
                          width: 5,
                        ),
                        if (ShopCubit.get(context).inCarts[product.id])
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            color: ShopCubit.get(context).inCarts[product.id]
                                ? Colors.green
                                : Colors.red,
                            child: Text(
                              'In Carts',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!ShopCubit.get(context).inCarts[product.id])
                  InkWell(
                    onTap: () {
                      ShopCubit.get(context)
                          .updateProductCart(productId: product.id);
                    },
                    child: Container(
                      height: 33,
                      width: 33,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                if (!ShopCubit.get(context).inFavorites[product.id])
                  IconButton(
                    icon: CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.heart,
                        color: Colors.white,
                        size: 17,
                      ),
                      backgroundColor:
                          ShopCubit.get(context).inFavorites[product.id]
                              ? Colors.red
                              : Colors.grey[300],
                      radius: 15,
                    ),
                    onPressed: () {
                      ShopCubit.get(context)
                          .updateProductFavorite(productId: product.id);
                    },
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

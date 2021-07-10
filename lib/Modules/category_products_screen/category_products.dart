import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsOfCategory extends StatelessWidget {
  ProductsOfCategory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Name of category'),
          ),
          body: ConditionalBuilder(
            condition:
                true || ShopCubit.get(context).productsOfCategory != null,
            builder: (context) => ConditionalBuilder(
              condition: true ||
                  state is! GetCategoryDataLoadingState &&
                      ShopCubit.get(context)
                              .productsOfCategory
                              .favoriteProducts
                              .length >
                          0,
              builder: (context) {
                return Column(
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
                    Expanded(child: GridViewCategoryProducts()),
                  ],
                );
              },
              fallback: (context) =>
                  Center(child: Text('There is no products')),
            ),
            fallback: (context) => Center(child: CupertinoActivityIndicator()),
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
            ShopCubit.get(context).categoryInformation.data.data.length,
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

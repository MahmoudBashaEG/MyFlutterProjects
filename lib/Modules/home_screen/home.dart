import 'package:carousel_pro/carousel_pro.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/end_notes.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_appp/Shared/styles/colors.dart';
import 'package:flutter_appp/models/home_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: state is! GetProfileDataLoadingState &&
                cubit.userProfileData != null &&
                cubit.categoryInformation != null,
            builder: (context) => homeBuilder(cubit, context),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

Widget homeBuilder(ShopCubit cubit, context) => SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            child: Carousel(
                autoplay: true,
                showIndicator: false,
                images: cubit.userProfileData.data.banners
                    .map((e) => NetworkImage(e.image))
                    .toList()),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    itemBuilder: (context, index) => categoryHome(
                        cubit.categoryInformation.data.data[index]),
                    scrollDirection: Axis.horizontal,
                    itemCount: cubit.categoryInformation.data.data.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      width: 4,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Products',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 1 / 1.53,
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    children: List.generate(
                      cubit.userProfileData.data.products.length,
                      (index) => productGridViewBuilder(cubit,
                          cubit.userProfileData.data.products[index], context),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );

Widget productGridViewBuilder(
        ShopCubit cubit, GetHomeProductData product, context) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              width: double.infinity,
              height: 180,
              image: NetworkImage(product.image),
            ),
            if (product.discount != 0)
              Container(
                color: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'Discount ${product.discount}%',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${product.price}',
                      style: TextStyle(color: defaultColor),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (product.oldPrice != null)
                      Text(
                        '${product.oldPrice}',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      icon: CircleAvatar(
                        child: FaIcon(
                          FontAwesomeIcons.heart,
                          color: Colors.white,
                          size: 17,
                        ),
                        backgroundColor:
                            ShopCubit.get(context).favorites[product.id]
                                ? defaultColor
                                : Colors.grey,
                        radius: 25,
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
        ),
      ],
    );

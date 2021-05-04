import 'package:carousel_pro/carousel_pro.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/end_notes.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()
        ..getCategoryData(
          url: CATEGORIES,
        )
        ..getProfileData(
          url: HOME,
          token: allUserData.data.token,
        ),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition: state is! GetProfileDataLoadingState &&
                  cubit.userProfileData != null &&
                  cubit.categoryInformation != null,
              builder: (context) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      child: Carousel(
                          autoplay: true,
                          showIndicator: false,
                          images: cubit.userProfileData.data.banners
                              .map((e) => NetworkImage(e['category']['image']))
                              .toList()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                              itemCount:
                                  cubit.categoryInformation.data.data.length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                width: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}

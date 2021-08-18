import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Modules/category_products_screen/category_products_screen.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is GetCategoryProductsSuccessState)
          navigatorTo(
              context: context,
              goTo: CategoryProduct(
                category: state.category,
              ));
      },
      builder: (context, state) {
        return Directionality(
          textDirection: lan == 'en' ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(
            body: ConditionalBuilder(
              condition: state is! GetCategoryDataLoadingState &&
                  ShopCubit.get(context).categoryInformation != null,
              builder: (context) => ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => categoryItem(
                    context,
                    ShopCubit.get(context)
                        .categoryInformation
                        .categories[index]),
                itemCount: ShopCubit.get(context)
                    .categoryInformation
                    .categories
                    .length,
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}

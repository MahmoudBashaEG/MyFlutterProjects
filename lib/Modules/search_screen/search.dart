import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search extends StatelessWidget {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: FaIcon(FontAwesomeIcons.arrowLeft),
              onPressed: () {
                ShopCubit.get(context).searchResult = null;
                navigatorBack(context: context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                defaultTextField(
                  label: ShopCubit.get(context).translation.search,
                  controller: search,
                  prefixIcon: FontAwesomeIcons.search,
                  onChange: (String value) {
                    print(value == '');
                    ShopCubit.get(context).search(
                      searchInput: search.text,
                      onChangeValue: value,
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: ShopCubit.get(context).searchResult != null,
                    builder: (context) => ConditionalBuilder(
                      condition: state is! SearchLoadingState,
                      builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => searchItemBuilder(
                          ShopCubit.get(context)
                              .searchResult
                              .searchProducts[index],
                          context,
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: ShopCubit.get(context)
                            .searchResult
                            .searchProducts
                            .length,
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    fallback: (context) => Center(
                        child:
                            Text(ShopCubit.get(context).translation.noSearch)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

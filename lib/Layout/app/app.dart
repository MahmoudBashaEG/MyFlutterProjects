import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Modules/drawer_screen/drawer.dart';
import 'package:flutter_appp/Modules/search_screen/search.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class PopMenu {
  String name;
  dynamic value;
  PopMenu({this.name, this.value});
}

class _AppState extends State<App> {
  List<PopMenu> popButtons = [
    PopMenu(
      name: 'ahmed',
      value: 10,
    )
  ];
  @override
  void initState() {
    super.initState();
    ShopCubit.get(context)
      ..getProfileData()
      ..getTranslation(context)
      ..getCategoryData()
      ..getProductFavorite()
      ..getProductCart();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return SafeArea(
                child: ConditionalBuilder(
                  condition: ShopCubit.get(context).translation != null,
                  builder: (context) => Directionality(
                    textDirection:
                        lan == 'en' ? TextDirection.ltr : TextDirection.rtl,
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text('Salla'),
                        actions: [
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.search),
                            onPressed: () {
                              navigatorTo(context: context, goTo: Search());
                            },
                          ),
                        ],
                      ),
                      drawer: DrawerScreen(),
                      body: ShopCubit.get(context)
                          .screens[ShopCubit.get(context).bottomBarIndex],
                      bottomNavigationBar: BottomNavigationBar(
                        backgroundColor: Colors.white,
                        onTap: (index) {
                          ShopCubit.get(context).changeBottomBarIndex(index);
                        },
                        currentIndex: ShopCubit.get(context).bottomBarIndex,
                        items: [
                          BottomNavigationBarItem(
                            icon: FaIcon(FontAwesomeIcons.home),
                            label: ShopCubit.get(context).translation.home,
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(FontAwesomeIcons.th),
                            label:
                                ShopCubit.get(context).translation.categories,
                          ),
                          BottomNavigationBarItem(
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.heart),
                                SizedBox(
                                  width: 10,
                                ),
                                if (ShopCubit.get(context)
                                        .favoriteProductsData !=
                                    null)
                                  Text(
                                    '${ShopCubit.get(context).favoriteProductsData.favoriteProducts.length}',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                              ],
                            ),
                            label: ShopCubit.get(context).translation.favorites,
                          ),
                          BottomNavigationBarItem(
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(FontAwesomeIcons.shoppingCart),
                                SizedBox(
                                  width: 10,
                                ),
                                if (ShopCubit.get(context).cartProductsData !=
                                    null)
                                  Text(
                                    '${ShopCubit.get(context).cartProductsData.cartProducts.length}',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                              ],
                            ),
                            label: ShopCubit.get(context).translation.carts,
                          ),
                          BottomNavigationBarItem(
                            icon: FaIcon(FontAwesomeIcons.cog),
                            label: ShopCubit.get(context).translation.settings,
                          ),
                        ],
                      ),
                    ),
                  ),
                  fallback: (context) => CupertinoActivityIndicator(),
                ),
              );
            });
      },
    );
  }
}

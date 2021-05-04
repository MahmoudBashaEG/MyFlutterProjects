import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Modules/search_screen/search.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
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
              body: ShopCubit.get(context)
                  .screens[ShopCubit.get(context).bottomBarIndex],
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  ShopCubit.get(context).changeBottomBarIndex(index);
                },
                currentIndex: ShopCubit.get(context).bottomBarIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.th),
                    label: 'Categories',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.heart),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.cog),
                    label: 'Settings',
                  ),
                ],
              ),
            );
          }),
    );
  }
}

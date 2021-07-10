import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Layout/cubit/cubit.dart';
import 'package:flutter_appp/Layout/cubit/states.dart';
import 'package:flutter_appp/Shared/Components/Components.dart';
import 'package:flutter_appp/Shared/network/locale/globalUserData.dart';
import 'package:flutter_appp/Shared/network/locale/locale.dart';
import 'package:flutter_appp/models/categoryModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({Key key}) : super(key: key);

  bool isAR = lan == 'ar' ? true : false;
  bool isEN = lan == 'en' ? true : false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).categoryInformation != null,
          builder: (context) => Drawer(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 15),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_forward_ios_outlined),
                      Text(
                        'Login/Register',
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15),
                  child: Text('Category'),
                ),
                ...List.generate(
                  ShopCubit.get(context).categoryInformation.data.data.length,
                  (index) => drawerCategoryItem(
                      context,
                      ShopCubit.get(context)
                          .categoryInformation
                          .data
                          .data[index]),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15),
                  child: Text('Help Info'),
                ),
                ...List.generate(drawerInfo.length,
                    (index) => drawerInfoItem(context, drawerInfo[index])),
                Row(
                  children: [
                    CupertinoSwitchButton(
                      name: 'En',
                      value: isEN,
                      onChanged: (value) {
                        if (value) {
                          CashHelper.setData(key: 'lan', value: 'en')
                              .then((value) {
                            ShopCubit.get(context)
                                .changeLanguage(context, 'en');
                          });
                        }
                      },
                    ),
                    Spacer(),
                    CupertinoSwitchButton(
                      name: 'AR',
                      value: isAR,
                      onChanged: (value) {
                        if (value) {
                          CashHelper.setData(key: 'lan', value: 'ar')
                              .then((value) {
                            ShopCubit.get(context)
                                .changeLanguage(context, 'ar');
                          });
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
          fallback: (context) => CupertinoActivityIndicator(),
        );
      },
    );
  }
}

Widget drawerCategoryItem(context, Category model) => GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(model.image),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                model.name,
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            IconButton(
                onPressed: () {}, icon: Icon(Icons.arrow_forward_outlined)),
          ],
        ),
      ),
    );

class DrawerInfo {
  String name;
  Icon icon;

  DrawerInfo({this.name, this.icon});
}

List<DrawerInfo> drawerInfo = [
  DrawerInfo(name: 'Blog', icon: Icon(Icons.announcement)),
  DrawerInfo(name: 'About', icon: Icon(Icons.home)),
  DrawerInfo(name: 'Contact Us', icon: Icon(Icons.phone)),
  DrawerInfo(name: 'About', icon: Icon(Icons.home)),
  DrawerInfo(name: 'About', icon: Icon(Icons.home)),
];

Widget drawerInfoItem(context, DrawerInfo model) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          model.icon,
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              model.name,
              maxLines: 1,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_forward_outlined)),
        ],
      ),
    );

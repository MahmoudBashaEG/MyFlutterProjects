import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app_api_cloud_db/Shared/Components/Components.dart';
import 'package:news_app_api_cloud_db/layouts/news/news_cubit/cubit.dart';
import 'package:news_app_api_cloud_db/layouts/news/news_cubit/states.dart';
import 'package:news_app_api_cloud_db/modules/search.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              NewsCubit.get(context)
                  .titles[NewsCubit.get(context).currentIndex],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  NewsCubit.get(context).search = [];
                  navigatorTo(context: context, goTo: Search());
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                icon: Icon(Icons.brightness_medium_rounded),
                onPressed: () {
                  NewsCubit.get(context).changeMode();
                },
              )
            ],
          ),
          body: NewsCubit.get(context)
              .screens[NewsCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: NewsCubit.get(context).currentIndex,
            onTap: (index) {
              NewsCubit.get(context).changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.business,
                ),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.sports_basketball,
                ),
                label: 'Sports',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.science,
                ),
                label: 'Economic',
              ),
            ],
          ),
        );
      },
    );
  }
}

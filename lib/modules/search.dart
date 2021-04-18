import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api_cloud_db/Shared/Components/Components.dart';
import 'package:news_app_api_cloud_db/layouts/news/news_cubit/cubit.dart';
import 'package:news_app_api_cloud_db/layouts/news/news_cubit/states.dart';

class Search extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Search'),
            centerTitle: true,
          ),
          body: Column(
            children: [
              input(
                  label: 'Search',
                  controller: searchController,
                  prefixIcon: Icons.search,
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  }),
              Expanded(child: newsSearchBuilder(NewsCubit.get(context).search))
            ],
          ),
        );
      },
    );
  }
}

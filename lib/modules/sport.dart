import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api_cloud_db/Shared/Components/Components.dart';
import 'package:news_app_api_cloud_db/layouts/news/news_cubit/cubit.dart';
import 'package:news_app_api_cloud_db/layouts/news/news_cubit/states.dart';

class Sport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List sports = NewsCubit.get(context).sports;
        return RefreshIndicator(
            onRefresh: () async {
              NewsCubit.get(context).getSports();
            },
            child: newsBuilder(sports));
      },
    );
  }
}

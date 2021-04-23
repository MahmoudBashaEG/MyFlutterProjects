import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_api_cloud_db/Shared/Components/Components.dart';
import 'package:news_app_api_cloud_db/layouts/news/news_cubit/cubit.dart';
import 'package:news_app_api_cloud_db/layouts/news/news_cubit/states.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Dark Mode',
                      style: TextStyle(fontSize: 25),
                    )),
                    CupertinoSwitch(
                      value: NewsCubit.get(context).isDark,
                      onChanged: (value) {
                        NewsCubit.get(context).changeMode();
                      },
                    )
                  ],
                ),
                spaceSizeBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Country',
                      style: TextStyle(fontSize: 25),
                    )),
                    DropdownButton(
                      hint: Text('Countries'),
                      value: NewsCubit.get(context).selectedUser,
                      onChanged: (value) {
                        NewsCubit.get(context).changeCountryName(value);
                        print('change');
                      },
                      items: NewsCubit.get(context).country.map((value) {
                        return DropdownMenuItem<String>(
                          child: Text(value.countryName),
                          value: value.countryCode,
                          onTap: () {
                            NewsCubit.get(context)
                                .changeCountryCode(value.countryCode);
                            print('tap');
                          },
                        );
                      }).toList(),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

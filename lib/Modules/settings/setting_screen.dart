import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Models/userModel.dart';
import 'package:socialapp/Modules/edit_profile/edit_profile.dart';
import 'package:socialapp/Shared/Components/Components.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserData userData = SocialCubit.get(context).userData;
        return Scaffold(
          body: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(userData.cover)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4),
                            )),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                    CircleAvatar(
                      radius: 45,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(userData.photo),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                userData.name,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                userData.bio,
                style: Theme.of(context).textTheme.caption,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          'Posts',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          'Posts',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          'Posts',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          'Posts',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        navigatorTo(
                            context: context, goTo: EditProfileScreen());
                      },
                      child: Text('Edit'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

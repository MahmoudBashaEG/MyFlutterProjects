import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Modules/EnterApp/login/login.dart';
import 'package:socialapp/Modules/Post/post.dart';
import 'package:socialapp/Modules/chat/chat_room.dart';
import 'package:socialapp/Shared/Components/Components.dart';
import 'package:socialapp/Shared/network/remote/Notification.dart';
import 'package:socialapp/Shared/styles/colors.dart';
import 'package:socialapp/Shared/styles/icons_broken.dart';

class SocialLayout extends StatefulWidget {
  const SocialLayout({Key key}) : super(key: key);

  @override
  _SocialLayoutState createState() => _SocialLayoutState();
}

class _SocialLayoutState extends State<SocialLayout> {
  @override
  void initState() {
    super.initState();
    SocialCubit.get(context).getUserData();
    SocialCubit.get(context).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialLogOutSuccessState)
          navigatorToAndReplace(context: context, goTo: LogIn());
        if (state is CreateNewPostState)
          navigatorTo(context: context, goTo: CreatePost());
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: SizedBox(),
            centerTitle: true,
            title: Text(
              cubit.currentIndex > 2
                  ? cubit.titles[cubit.currentIndex - 1]
                  : cubit.titles[cubit.currentIndex],
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  icon: Icon(IconBroken.Notification),
                  onPressed: () {
                    SocialCubit.get(context).logOut();
                  }),
              IconButton(
                icon: Icon(IconBroken.Search),
                onPressed: () {},
              ),
            ],
          ),
          body: cubit.currentIndex > 2
              ? cubit.screens[cubit.currentIndex - 1]
              : cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              SocialCubit.get(context).changeBottomNavIndex(index);
            },
            backgroundColor: Colors.white,
            selectedItemColor: defaultColor,
            unselectedItemColor:
                Theme.of(context).primaryColorLight.withOpacity(.9),
            currentIndex: SocialCubit.get(context).currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.User),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

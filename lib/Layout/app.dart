import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Modules/EnterApp/login/login.dart';
import 'package:socialapp/Modules/home/home_screen.dart';
import 'package:socialapp/Shared/Components/Components.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialLogOutSuccessState)
          navigatorToAndReplace(context: context, goTo: LogIn());
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: SizedBox(),
            centerTitle: true,
            title: Text(
              SocialCubit.get(context)
                  .titles[SocialCubit.get(context).currentIndex],
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              state is SocialGetUserDataLoadingState
                  ? CircularProgressIndicator()
                  : TextButton(
                      onPressed: () {
                        SocialCubit.get(context).logOut();
                      },
                      child: Text(
                        'LogOut',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
            ],
          ),
          body: SocialCubit.get(context)
              .screens[SocialCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              SocialCubit.get(context).changeBottomNavIndex(index);
            },
            backgroundColor: Colors.white,
            selectedItemColor: defaultColor,
            unselectedItemColor:
                Theme.of(context).primaryColorLight.withOpacity(.4),
            currentIndex: SocialCubit.get(context).currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Friends',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

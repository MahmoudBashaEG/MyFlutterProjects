import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Shared/Components/Components.dart';

class ChatRoom extends StatelessWidget {
  @required
  final String name;

  ChatRoom({
    this.name,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: name, centerTitle: true),
          body: Container(
            child: Text('Hello  World'),
          ),
        );
      },
    );
  }
}

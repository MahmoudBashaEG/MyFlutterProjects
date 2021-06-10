import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Models/userModel.dart';
import 'package:socialapp/Modules/chat/chat_room.dart';
import 'package:socialapp/Shared/Components/Components.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).users.length > 0,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  chatItem(context, SocialCubit.get(context).users[index]),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: SocialCubit.get(context).users.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget chatItem(context, UserData userData) {
    return InkWell(
      onTap: () {
        navigatorTo(
            context: context,
            goTo: ChatRoom(
              model: userData,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                userData.photo.toString(),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        userData.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              height: 1.5,
                            ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 17,
                      )
                    ],
                  ),
                  Text(
                    userData.uid,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          height: 1.5,
                        ),
                  ),
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
          ],
        ),
      ),
    );
  }
}

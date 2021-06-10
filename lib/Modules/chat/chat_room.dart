import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Models/messageModel.dart';
import 'package:socialapp/Models/userModel.dart';
import 'package:socialapp/Shared/styles/colors.dart';
import 'package:socialapp/Shared/styles/icons_broken.dart';

class ChatRoom extends StatelessWidget {
  @required
  final UserData model;

  ChatRoom({
    this.model,
  });
  @override
  Widget build(BuildContext context) {
    TextEditingController message = TextEditingController();
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiverId: model.uid);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  titleSpacing: 5,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          model.photo.toString(),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  centerTitle: true,
                ),
                body: ConditionalBuilder(
                  condition: SocialCubit.get(context).messages.length != 0,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              MessageData message =
                                  SocialCubit.get(context).messages[index];
                              if (SocialCubit.get(context).userData.uid ==
                                  message.senderId) {
                                return buildMyMessage(message);
                              } else {
                                return buildMessage(message);
                              }
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                            itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[400],
                            ),
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextField(
                                    controller: message,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Type Your Message Here ..."),
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                              MaterialButton(
                                minWidth: 1,
                                height: 50,
                                onPressed: () {
                                  SocialCubit.get(context).sendMessage(
                                    text: message.text,
                                    time: DateTime.now().toString(),
                                    receiverId: model.uid,
                                    receiverToken: model.mobileToken,
                                  );
                                  message.text = '';
                                },
                                child: Icon(
                                  IconBroken.Send,
                                  color: Colors.white,
                                ),
                                color: defaultColor,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  fallback: (context) => Text('There is no any data'),
                ));
          },
        );
      },
    );
  }

  Widget buildMessage(MessageData messageData) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(7),
            topLeft: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
          color: Colors.grey.withOpacity(.4),
        ),
        child: Text(
          messageData.text,
          style: TextStyle(
            height: 1.6,
          ),
        ),
      ),
    );
  }

  Widget buildMyMessage(MessageData messageData) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(7),
            topLeft: Radius.circular(7),
            bottomLeft: Radius.circular(7),
          ),
          color: defaultColor.withOpacity(.4),
        ),
        child: Text(
          messageData.text,
          style: TextStyle(
            height: 1.6,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Models/userModel.dart';
import 'package:socialapp/Shared/Components/Components.dart';
import 'package:socialapp/Shared/styles/icons_broken.dart';

class CreatePost extends StatelessWidget {
  TextEditingController post = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is PostSuccessState) navigatorBack(context: context);
      },
      builder: (context, state) {
        UserData userDate = SocialCubit.get(context).userData;
        return Scaffold(
            appBar: AppBar(
              title: Text('Post'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  if (state is PostLoadingState) LinearProgressIndicator(),
                  if (state is PostLoadingState)
                    SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(userDate.photo)),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userDate.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
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
                              'Date',
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        height: 1.5,
                                      ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(icon: Icon(Icons.more_horiz), onPressed: () {})
                    ],
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        height: 1.5,
                      ),
                      maxLines: 10000000000000,
                      controller: post,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write Your Post',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (SocialCubit.get(context).postImage != null)
                    Image.file(
                      SocialCubit.get(context).postImage,
                      height: 180,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  if (SocialCubit.get(context).postImage != null)
                    SizedBox(
                      height: 10,
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Profile),
                              Text('Add Photo'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            if (SocialCubit.get(context).postImage != null) {
                              SocialCubit.get(context)
                                  .postWithImage(text: post.text);
                            } else {
                              SocialCubit.get(context)
                                  .postWithText(text: post.text);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Add_User),
                              Text('Post'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}

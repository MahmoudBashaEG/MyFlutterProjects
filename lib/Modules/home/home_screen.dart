import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Models/postModel.dart';
import 'package:socialapp/Shared/Components/Components.dart';
import 'package:socialapp/Shared/styles/colors.dart';
import 'package:socialapp/Shared/styles/icons_broken.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).post == null,
            builder: (context) => Center(
              child: Text(
                'There is No posts',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            fallback: (context) => ConditionalBuilder(
              condition: SocialCubit.get(context).post.length > 0 &&
                  SocialCubit.get(context).postsLike.length > 0 &&
                  SocialCubit.get(context).userData != null,
              builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Card(
                        margin: EdgeInsets.all(8),
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Image.network(
                              'https://image.freepik.com/free-photo/glad-happy-man-yellow-sweater-white-shirt-black-bow-tie-pointing-right-with-his-finger_295783-1509.jpg',
                              height: 200,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Text(
                              'Communicate With Friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => cardItem(
                          context, SocialCubit.get(context).post[index], index),
                      itemCount: SocialCubit.get(context).post.length,
                      separatorBuilder: (context, int index) => SizedBox(
                        height: 15,
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }

  Widget cardItem(context, PostDate postDate, index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8),
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(postDate.profileImage)),
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
                            postDate.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
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
                        postDate.date.toString(),
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
            SizedBox(
              height: 10,
            ),
            myDivider(),
            SizedBox(
              height: 10,
            ),
            if (postDate.text != '')
              Text(
                postDate.text,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            Container(
              width: double.infinity,
              child: Wrap(
                direction: Axis.horizontal,
                children: [
                  Container(
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#SuperHero',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ),
                    height: 35,
                  ),
                  Container(
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#SuperHero',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ),
                    height: 35,
                  ),
                  Container(
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#SuperHero',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ),
                    height: 35,
                  ),
                  Container(
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#SuperHero_Development',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                    ),
                    height: 35,
                  ),
                ],
              ),
            ),
            if (postDate.postImage != '')
              Image.network(
                postDate.postImage,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '100',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          '551',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          IconBroken.Activity,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      SocialCubit.get(context).userData.photo,
                    )),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: defaultTextField(
                    label: null,
                    hint: 'Write Comment',
                    controller: comment,
                    prefixIcon: null,
                    isOutLinedInputBorder: false,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        SocialCubit.get(context)
                            .likePost(SocialCubit.get(context).postId[index]);
                      },
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Like',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            IconBroken.Shield_Done,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Share',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

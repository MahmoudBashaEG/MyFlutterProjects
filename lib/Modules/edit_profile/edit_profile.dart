import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/cubit.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Models/userModel.dart';
import 'package:socialapp/Shared/Components/Components.dart';
import 'package:socialapp/Shared/styles/icons_broken.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController name = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserData userData = SocialCubit.get(context).userData;
        File imageProfile = SocialCubit.get(context).profileImage;
        File coverImage = SocialCubit.get(context).coverImage;
        name.text = userData.name;
        bio.text = userData.bio;
        phone.text = userData.phone;

        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              TextButton(
                onPressed: () {
                  if (form.currentState.validate()) {
                    SocialCubit.get(context).updateUser(
                      name: name.text,
                      bio: bio.text,
                      phone: phone.text,
                    );
                  }
                },
                child: Text('UPDATE'),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: form,
              child: Column(
                children: [
                  if (state is SocialUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialUpdateUserLoadingState)
                    SizedBox(
                      height: 10,
                    ),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: coverImage != null
                                          ? FileImage(coverImage)
                                          : NetworkImage(userData.cover),
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    )),
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: IconButton(
                                  icon: Icon(IconBroken.Camera),
                                  onPressed: () {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: imageProfile != null
                                    ? FileImage(imageProfile)
                                    : NetworkImage(userData.photo),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                icon: Icon(IconBroken.Camera),
                                onPressed: () {
                                  SocialCubit.get(context).getProfileImage();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        defaultTextFormField(
                          label: 'Name',
                          prefixIcon: IconBroken.Profile,
                          controller: name,
                          validate: 'Enter Name',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          label: 'Bio',
                          prefixIcon: IconBroken.Chat,
                          controller: bio,
                          validate: 'Enter Bio',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                          label: 'Phone',
                          prefixIcon: IconBroken.Calling,
                          controller: phone,
                          validate: 'Enter Phone Number',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

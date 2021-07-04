import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/Layout/Cubit/states.dart';
import 'package:socialapp/Models/messageModel.dart';
import 'package:socialapp/Models/postModel.dart';
import 'package:socialapp/Models/userModel.dart';
import 'package:socialapp/Modules/chat/chat_screen.dart';
import 'package:socialapp/Modules/home/home_screen.dart';
import 'package:socialapp/Modules/settings/setting_screen.dart';
import 'package:socialapp/Modules/users/users_screen.dart';
import 'package:socialapp/Shared/network/remote/Notification.dart';
import 'package:socialapp/globalVariable.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<String> titles = [
    'Home',
    'Chats',
    'Users',
    'Settings',
  ];
  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    UserScreen(),
    SettingScreen(),
  ];
  void changeBottomNavIndex(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2)
      emit(CreateNewPostState());
    else {
      currentIndex = index;
      emit(ChangeNavBarIndexState());
    }
  }

  UserData userData;

  void getUserData() {
    emit(SocialGetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(globalUserData.uid)
        .snapshots()
        .listen((event) {
      userData = UserData.fromJson(event.data());
      print(userData.uid);
      emit(SocialGetUserDataSuccessState());
    });
  }

  List<UserData> users;
  void getAllUsers() {
    users = [];
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((el) {
        print(el.data()['uid']);
        print(userData.uid);
        if (el.data()['uid'] != userData.uid) {
          users.add(UserData.fromJson(el.data()));
        }
      });
      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUsersErrorState());
    });
  }

  List<PostDate> post = [];
  List<String> postId = [];
  List<int> postsLike;

  void getPosts() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      post = [];
      postId = [];
      postsLike = [];
      event.docs.forEach((el) {
        postId.add(el.id);
        post.add(PostDate.fromJson(el.data()));
        el.reference.collection('likes').get().then((value) {
          postsLike.add(value.docs.length);
          emit(SocialGetPostsSuccessState());
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    });
  }

  void likePost(String postUid) {
    emit(PostLikeLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postUid)
        .collection('likes')
        .doc(userData.uid)
        .set({'like': true}).then((value) {
      emit(PostLikeSuccessState());
    }).catchError((error) {
      emit(PostLikeErrorState());
    });
  }

  File profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SocialPickProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPickProfileImageErrorState());
    }
  }

  File coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      uploadCoverImage();
      emit(SocialPickCoverImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPickCoverImageErrorState());
    }
  }

  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/profile/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        userData.photo = value;
        emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/cover/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        userData.cover = value;
        emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    @required String name,
    @required String bio,
    @required String phone,
  }) {
    userData.name = name;
    userData.bio = bio;
    userData.phone = phone;
    emit(SocialUpdateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData.uid)
        .update(userData.getMap())
        .then((value) {
      emit(SocialUpdateUserSuccessState());
    }).catchError((error) {
      emit(SocialUpdateUserErrorState());
    });
  }

  File postImage;
  Future getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPickPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPickPostImageErrorState());
    }
  }

  PostDate postDate;

  void postWithImage({
    String text,
  }) {
    emit(PostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('post/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        postDate = PostDate(
          name: userData.name,
          postImage: value,
          uid: userData.uid,
          date: DateTime.now(),
          profileImage: userData.photo,
          text: text,
        );
        postWithText(
          text: text,
          postModel: postDate,
        );
      }).catchError((error) {
        emit(PostErrorState());
      });
    });
  }

  void postWithText({
    String text,
    PostDate postModel,
  }) {
    emit(PostLoadingState());
    postDate = postModel == null
        ? PostDate(
            name: userData.name,
            postImage: '',
            uid: userData.uid,
            date: DateTime.now(),
            profileImage: userData.photo,
            text: text,
          )
        : postModel;

    FirebaseFirestore.instance
        .collection('posts')
        .add(postDate.toMap())
        .then((value) {
      emit(PostSuccessState());
    }).catchError((error) {
      emit(PostErrorState());
    });
  }

  MessageData messageData;

  void sendMessage({
    @required String text,
    @required String time,
    @required String receiverId,
    @required String receiverToken,
  }) {
    messageData = MessageData(
      text: text,
      time: time,
      receiverId: receiverId,
      senderId: userData.uid,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userData.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageData.getMap())
        .then((value) {
      Fcm.sendNotification(
        token: receiverToken,
        message: text,
        senderName: userData.name,
      );

      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userData.uid)
        .collection('messages')
        .add(messageData.getMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageData> messages = [];
  void getMessages({
    @required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageData.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }

  void logOut() {
    emit(SocialLogOutLoadingState());
    FirebaseAuth.instance.signOut().then(
      (value) {
        emit(SocialLogOutSuccessState());
      },
    ).catchError((error) {
      emit(SocialLogOutErrorState());
    });
  }
}

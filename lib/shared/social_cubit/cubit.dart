import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/chat/chat_model.dart';
import 'package:social_app/models/create_post/create_post_model.dart';
import 'package:social_app/models/user_comment/user_comment_model.dart';
import 'package:social_app/models/user_create/user_create_model.dart';
import 'package:social_app/modules/chats/social_chats_screen.dart';
import 'package:social_app/modules/home/social_home_screen.dart';
import 'package:social_app/modules/notifications/social_notifications_screen.dart';
import 'package:social_app/modules/profile/social_profile_screen.dart';
import 'package:social_app/modules/settings/social_settings_screen.dart';
import 'package:social_app/modules/users/social_users_screen.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/social_cubit/states.dart';
import 'dart:ui' as ui;
import 'package:social_app/shared/styles/iconBroken.dart';



  class SocialCubit  extends Cubit<SocialAppStates>
{

  SocialCubit():super(AppInitialState());

  var commentController = TextEditingController();

  IconData commentIcon= IconBroken.Heart;
  bool isLike = false;


  int currentIndex = 0;
  List<Widget>screens=
  [

  HomeScreen(),
  const NotificationsScreen(),
  const UsersScreen(),
  const ChatsScreen(),
  const ProfileScreen(),
  const SettingsScreen(),
];

  static SocialCubit get(context) => BlocProvider.of(context);


  void changeIndex(index)
  {
    if (index==3)
    {
      getAllUsers();
      getChatItems();
    }
    currentIndex= index ;

    emit(AppChangeTabBarItemsState());
  }


  late  var textDirection = ui.TextDirection.ltr;
  void changeLocalToAr (BuildContext context)async
  {
    await context.setLocale(const Locale('ar'));
    textDirection = ui.TextDirection.rtl;
    emit(ChangeLocalToArState());
  }

  void changeLocalToEn (BuildContext context) async
  {
    await context.setLocale(const Locale('en'));
    textDirection = ui.TextDirection.ltr;
    emit(ChangeLocalToEnState());
  }

  UserModel ?userModel;
  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value)
    {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });

  }




  File ? profileImage ;
  ImagePicker? picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker?.pickImage(source: ImageSource.gallery,);

    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }
    else
    {
      print('No Profile image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }




  File ? coverImage ;
  Future<void> getCoverImage() async
  {
    final pickedFile = await picker?.pickImage(source: ImageSource.gallery,);

    if(pickedFile != null)
    {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }
    else
    {
      print('No Cover image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }


  var fireBaseStorage = FirebaseStorage.instance;
  void uploadProfileImage(
      String ?name,
      String? phone,
      String? bio,
      String ?cover,
      )
  {
    fireBaseStorage
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value)
    {
          value.ref.getDownloadURL().then((value)
          {
            emit(SocialUploadProfileImageSuccessState());
            print(value);
            updateUser(name: name.toString(), phone: phone.toString(), bio: bio.toString(),cover: cover,profile: value);
          }).catchError((error)
          {
            emit(SocialGetUploadedProfileImageErrorState());
            print(error.toString());
          });
    })
        .catchError((error)
    {
      emit(SocialUploadProfileImageErrorState());
      print(error.toString());
    });
  }



  void uploadCoverImage(
      String ?name,
      String ?phone,
      String ?bio,
      String ?profile,
      )

  {
    fireBaseStorage
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name.toString(), phone: phone.toString(), bio: bio.toString(),cover: value,profile:profile );
      }).catchError((error)
      {
        emit(SocialGetUploadedCoverImageErrorState());
        print(error.toString());
      });
    })
        .catchError((error)
    {
      emit(SocialUploadCoverImageErrorState());
      print(error.toString());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String ?profile,
    String ?cover,
  })
  {
    emit(SocialUpdateUserLoadingState());

    UserModel model = UserModel(
      name: name,
      email: userModel?.email,
      phone: phone,
      uId: userModel?.uId,
      bio: bio,
      image:profile ??userModel?.image,
      cover:cover?? userModel?.cover,
    );

    FirebaseFirestore.instance.collection('users').doc(userModel?.uId).update(model.toMap()).then((value)
    {
      getUserData();
    }).catchError((error)
    {
      emit(SocialUpdateUserErrorState());
    });
  }


  var  postImage ;

  Future<void> getPostImage() async
  {
    final pickedFile = await picker?.pickImage(source: ImageSource.gallery,);

    if(pickedFile != null)
    {
      postImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }
    else
    {
      print('No Post image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }


  void removeImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }



  void uploadPostImage({
    required String dateTime,
    required String postText,

  })
  {

    emit(SocialCreatePostLoadingState());

    fireBaseStorage
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        createPost(dateTime: dateTime, postText: postText,postImage:value );
        emit(SocialCreatePostSuccessState());
        print(value);
      }).catchError((error)
      {
        emit(SocialCreatePostErrorState());
        print(error.toString());
      });
    }).catchError((error)
    {
      emit(SocialCreatePostErrorState());
      print(error.toString());
    });
  }





  void createPost({
    required String dateTime,
    required String postText,
    String ?postImage,
  })
  {
    emit(SocialCreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel?.name,
      uId: userModel?.uId,
      image:userModel?.image ,
      dateTime: dateTime,
      postImage:postImage??'' ,
      postText: postText,
      postId: 'postText',
      commentsNumbers: 0,
      likesNumbers: 0,
      iLikedThisPost: false,

    );

    FirebaseFirestore.instance.collection('posts')
        .add(model.toMap())
        .then((value)
    {
      newGetPosts();
      emit(SocialCreatePostSuccessState());

    }).catchError((error)
    {
      emit(SocialCreatePostErrorState());
    });
  }


  // List<int> numberOfLikesPerPost = [];
  // List<int> numberOfCommentsPerPost = [];
  // List<PostModel> posts = [];
  // Map<String,bool> fav = {};
  // void getPosts() {
  //   emit(SocialGetPostLoadingState());
  //   FirebaseFirestore.instance.collection('posts').get().then((value)
  //   {
  //     posts= [];
  //     postsIds = [];
  //     numberOfLikesPerPost = [];
  //     numberOfCommentsPerPost = [];
  //
  //     value.docs.forEach((element)
  //     {
  //
  //       element.reference.collection('comments').get().then((commentValue)
  //       {
  //         numberOfCommentsPerPost.add(commentValue.docs.length);
  //       });
  //
  //       element.reference.collection('likes').get().then((likeValue)
  //       {
  //         numberOfLikesPerPost.add(likeValue.docs.length);
  //         postsIds.add(element.id);
  //         posts.add(PostModel.fromJson(element.data()));
  //         bool isLiked = likeValue.docs.any((like) => like.id == userModel?.uId && like.data()['like'] == true);
  //         fav[element.id] = isLiked;
  //
  //
  //
  //         // // Listen for comments in real-time
  //         // element.reference.collection('comments').snapshots().listen((commentValue) {
  //         //   int postIndex = postsIds.indexOf(element.id);
  //         //
  //         //   if (postIndex >= 0)
  //         //   {
  //         //     if (numberOfCommentsPerPost.length <= postIndex)
  //         //     {
  //         //       numberOfCommentsPerPost.add(commentValue.docs.length);
  //         //     }
  //         //     else
  //         //     {
  //         //       numberOfCommentsPerPost[postIndex] = commentValue.docs.length;
  //         //     }
  //         //     emit(SocialGetPostSuccessState());
  //         //   }
  //         // });
  //
  //         emit(SocialGetPostSuccessState());
  //       }).catchError((error)
  //       {
  //         print(error.toString());
  //         emit(SocialGetPostErrorState(error.toString()));
  //       });
  //     });
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(SocialGetPostErrorState(error.toString()));
  //   });
  // }


  List<PostModel>newPosts=[];
  List<String> postsIds = [];


  void newGetPosts() {
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts')
        .snapshots()
        .listen((event) async {
          newPosts=[];
          postsIds = [];
          event.docs.forEach((element) async
      {
        postsIds.add(element.id);
        newPosts.add(PostModel.fromJson(element.data()));

        element.reference.collection('likes').snapshots().listen((event)
        {
           FirebaseFirestore.instance.collection('posts').doc(element.id).update({
            'likesNumbers':event.docs.length,
            'postId':element.id,
          });
        });
        element.reference.collection('comments').snapshots().listen((event) {
          FirebaseFirestore.instance.collection('posts').doc(element.id).update({
            'commentsNumbers':event.docs.length,
            'postId':element.id,
          });
        });
        });
      emit(SocialGetPostSuccessState());
    });
  }



  void newLikePosts(String postId) {
    FirebaseFirestore.instance.collection('posts').doc(postId).get().then((value)
    {
      bool isCurrentlyLiked = value.data()?['iLikedThisPost'] ?? false;

      FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'iLikedThisPost': !isCurrentlyLiked,
      }).then((_)
      {
        if (isCurrentlyLiked)
        {
          value.reference.collection('likes').doc(userModel?.uId).delete().then((_)
          {
            emit(SocialDeleteMySuccessState());
          }).catchError((error) {
            print("Error deleting like: ${error.toString()}");
            emit(SocialPostLikeErrorState(error.toString()));
          });
        }
        else
        {
          value.reference.collection('likes').doc(userModel?.uId).set({'like': true}).then((_) {
            emit(SocialPostLikeSuccessState());
          }).catchError((error) {
            print("Error adding like: ${error.toString()}");
            emit(SocialPostLikeErrorState(error.toString()));
          });
        }
      }).catchError((error)
      {
        print("Error updating like status: ${error.toString()}");
        emit(SocialPostLikeErrorState(error.toString()));
      });
    }).catchError((error)
    {
      print("Error fetching post: ${error.toString()}");
      emit(SocialPostLikeErrorState(error.toString()));
    });
  }



  void commentPosts(String postId, String commentText)
  {
    emit(SocialPostCommentLoadingState());

    CommentModel commentModel = CommentModel(
      name: userModel?.name,
      image:userModel?.image,
      uId: userModel?.uId,
      postId: postId,
      dateTime:DateTime.now().toString(),
      commentText:  commentText,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap()).then((value)
    {
      getComments(postId);
      emit(SocialPostCommentSuccessState());
    }).catchError((error)
    {
      emit(SocialPostCommentErrorState(error.toString()));
    });
  }

  
  List<CommentModel> singlePostComments = [];
  Future <void> getComments(String postId)
  async {

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      singlePostComments = [];
      event.docs.forEach((element)
          {
            singlePostComments.add(CommentModel.fromJson(element.data()));
          });
          emit(SocialGetCommentSuccessState());
    });
  }


  List<UserModel> ? users ;
  void getAllUsers()
  {
    users=[];
    FirebaseFirestore.instance.collection('users').get().then((value)
    {
      value.docs.forEach((element)
      {
        if(element.data()['uId']!=userModel?.uId)
        {
          users?.add(UserModel.fromJson(element.data()));
        }
      });

      emit(SocialGetAllUsersSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialGetAllUsersErrorState());
    });
  }



  void sendMessage({required String? name,required String? image,required String? receiverUid,required String message,required String dateTime,required String date,required String time})
  {
    ChatModel model = ChatModel(
      name: name,
      image: image,
      dateTime: dateTime,
      message: message,
      senderId: userModel!.uId,
      receiverId: receiverUid,
      date: date,
      time: time,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverUid)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    }).catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverUid)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    }).catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });
  }

  List<ChatModel> chatMessages=[];

   void getChatMessages(String receiverUid)
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverUid)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      chatMessages.clear();

      event.docs.forEach((element)
      {
        chatMessages.add(ChatModel.fromJson(element.data()));
      });
      // print('******************************************');
      // print(event.docs.last.data()['message']);
      // print('******************************************');

      emit(SocialGetAllMessagesSuccessState());
    });

FirebaseFirestore.instance
    .collection('users')
    .doc(userModel!.uId)
    .collection('chats')
    .doc(receiverUid)
    .collection('messages')
    .orderBy('dateTime')
    .snapshots()
    .listen((event)
{
  if(event.docs.isNotEmpty)
  {
    FirebaseFirestore.instance.collection('users').doc(receiverUid).update({
      'isTalkToMe':true,
      'lastMessageChat':event.docs.last.data()['message'],
      'dateTime':event.docs.last.data()['dateTime'],
      'date':event.docs.last.data()['date'],
      'time':event.docs.last.data()['time'],
    });
  }else
  {
    FirebaseFirestore.instance.collection('users').doc(receiverUid).update({
      'isTalkToMe':false,
    });
  }
  emit(SocialUserChatItemSuccessState());
});

  }



  List<UserModel> ? usersChatItems = [] ;
  void getChatItems()
  {
    FirebaseFirestore.instance
        .collection('users')
        .orderBy('dateTime',descending: true)
        .snapshots()
        .listen((event)
    {
      usersChatItems!.clear();
      event.docs.forEach((element)
      {
        if(element.data()['isTalkToMe']==true)
        {
          usersChatItems?.add(UserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetChatItemsSuccessState());
    });

  }







}





// new update
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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

  late UserModel  userModel;
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


  // void updateUserData({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // })
  // {
  //   emit(SocialUpdateUserLoadingState());
  //
  //   if(coverImage != null)
  //   {
  //     uploadCoverImage(name: name, phone: phone, bio: bio);
  //
  //   }
  //   if(profileImage != null)
  //   {
  //     uploadProfileImage(name: name, phone: phone, bio: bio);
  //
  //   }
  //   if(coverImage != null && profileImage != null)
  //   {
  //     uploadCoverImage(name: name, phone: phone, bio: bio);
  //     uploadProfileImage(name: name, phone: phone, bio: bio);
  //   }
  //   else
  //   {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }



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
      email: userModel.email,
      phone: phone,
      uId: userModel.uId,
      bio: bio,
      image:profile ??userModel.image,
      cover:cover?? userModel.cover,
    );

    FirebaseFirestore.instance.collection('users').doc(userModel.uId).update(model.toMap()).then((value)
    {
      getUserData();
    }).catchError((error)
    {
      emit(SocialUpdateUserErrorState());
    });
  }


// create post


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
      name: userModel.name,
      uId: userModel.uId,
      image:userModel.image ,
      dateTime: dateTime,
      postImage:postImage??'' ,
      postText: postText,

    );

    FirebaseFirestore.instance.collection('posts')
        .add(model.toMap())
        .then((value)
    {
      getPosts();
      emit(SocialCreatePostSuccessState());

    }).catchError((error)
    {
      emit(SocialCreatePostErrorState());
    });
  }






  // void getPostsssss() //دي بتاعتي انا مش شغالة
  // {
  //   emit(SocialGetPostLoadingState());
  //   FirebaseFirestore.instance.collection('posts').get().then((value)
  //   {
  //     value.docs.forEach((element)
  //     {
  //
  //       element.reference.collection('likes').get().then((value)
  //       {
  //         postLikes.add(value.docs.length);
  //
  //         postsIds.add(element.id);
  //         posts.add(PostModel.fromJson(element.data()));
  //
  //         // Check if the current user liked this post
  //         bool isLiked = value.docs.any((like) => like.id == userModel.uId && like.data()['like'] == true);
  //
  //         // Add to the 'fav' map
  //         fav[element.id] = isLiked;
  //
  //         // normal way
  //         //bool isLiked = value.docs.any((like) {
  //         //   // Check if the document ID matches userModel.uId
  //         //   bool hasMatchingId = like.id == userModel.uId;
  //         //
  //         //   // Check if the 'like' field is set to true
  //         //   bool isLikeTrue = like['like'] == true;
  //         //
  //         //   // Return true only if both conditions are met
  //         //   return hasMatchingId && isLikeTrue;
  //         // });
  //
  //
  //       })
  //       .catchError((error)
  //       {
  //         print(error.toString());
  //         emit(SocialGetPostErrorState(error.toString()));
  //       });
  //       emit(SocialGetPostSuccessState());
  //     });
  //   })
  //       .catchError((error)
  //   {
  //     print(error.toString());
  //     emit(SocialGetPostErrorState(error.toString()));
  //   });
  //
  // }






  // دول عشان اعمل لايك ويسمع في الداتابيز وبعدين اجيب عددهم

  // void likePosts(String postId)
  // {
  //   fav[postId] = !fav[postId]!;
  //   emit(SocialChangePostLikeState());
  //   FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(userModel.uId).set({'like':true})
  //       .then((value)
  //   {
  //     getLikesNum();
  //     emit(SocialPostLikeSuccessState());
  //   }).catchError((error){
  //     print(error.toString());
  //     emit(SocialPostLikeErrorState(error.toString()));
  //   });
  // }





  // void getLikesNum()
  // {
  //   FirebaseFirestore.instance.collection('posts').get().then((value)
  //   {
  //     value.docs.forEach((element)
  //     {
  //
  //       element.reference.collection('likes').get().then((value)
  //       {
  //         postLikes.add(value.docs.length);
  //       }).catchError((error)
  //       {
  //         print(error.toString());
  //         emit(SocialGetLikeNumErrorState());
  //       });
  //       emit(SocialGetLikeNumSuccessState());
  //     });
  //   });
  //
  // }












  List<PostModel> posts = [];
  List<String> postsIds = [];
  List<int> postLikes = [];
  List<Map<String,dynamic>> postComments = [];



  // Get Posts
  // Get each Post Likes
  // Get Posts

  Map<String,bool> fav = {};
  void getPosts() { //دي بتاعت gpt
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value)
    {
      posts= [];
      postsIds = [];
      postLikes = [];
      postComments = [];

      value.docs.forEach((element)
      {
        element.reference.collection('likes').get().then((likeValue)
        {
          postLikes.add(likeValue.docs.length);
          postsIds.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          bool isLiked = likeValue.docs.any((like) => like.id == userModel.uId && like.data()['like'] == true);
          fav[element.id] = isLiked;

          // Fetch comments for this post
          element.reference.collection('comments').get().then((commentValue)
          {
            List<Map<String, dynamic>> comments = [];
            commentValue.docs.forEach((comment)
            {
              comments.add(comment.data());
            });
            postComments.add({'postId': element.id, 'comments': comments});  //,'numberOfComments':comments.length
          }).catchError((error) {
            print("//////////////////////////////////////////////////////////////////");
            print(error.toString());
            print("//////////////////////////////////////////////////////////////////");
            emit(SocialGetPostErrorState(error.toString()));
          });


          emit(SocialGetPostSuccessState());
        }).catchError((error) {
          print("//////////////////////////////////////////////////////////////////");
          print(error.toString());
          print("//////////////////////////////////////////////////////////////////");
          emit(SocialGetPostErrorState(error.toString()));
        });
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetPostErrorState(error.toString()));
    });
  }





  void likePosts(String postId)
  {
    bool isCurrentlyLiked = fav[postId] ?? false;
    fav[postId] = !isCurrentlyLiked; // Toggle the like status locally

    emit(SocialChangePostLikeState());

    FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(userModel.uId)
        .set({'like': !isCurrentlyLiked}) // Toggle the like status in Firestore
        .then((value) {
      if (isCurrentlyLiked)
      {
        // If post was already liked, decrease the local likes count
        postLikes[postsIds.indexOf(postId)]--;
      } else
      {
        // If post was not liked, increase the local likes count
        postLikes[postsIds.indexOf(postId)]++;
      }

      emit(SocialPostLikeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialPostLikeErrorState(error.toString()));
    });
  }



//ده كنت بجرب لماادوس على لايك يتغير والعكس صحيح

// void changeIcon()
// {
//   if(isLike==true)
//   {
//     commentIcon = Icons.heart_broken_sharp;
//     isLike= false;
//     emit(SocialChangeLikeIconSuccessState());
//   }
//   else
//   {
//     commentIcon = IconBroken.Heart;
//     isLike = true;
//     emit(SocialChangeLikeIconSuccessState());
//   }
// }



  void commentPosts(String postId, String commentText)
  {
    emit(SocialPostCommentLoadingState());

    CommentModel commentModel = CommentModel(
      name: userModel.name,
      image:userModel.image,
      uId: userModel.uId,
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

  Future <void> getComments(String postId)
  async {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value)
    {

      List<Map<String, dynamic>> comments = [];
      value.docs.forEach((comment)
      {
        comments.add(comment.data());
        // print('hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        // print(comment.data());
        // print('hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
        // postComments.add({'postId': postId, 'comments': comments});

        int postIndex = postsIds.indexOf(postId);
        if (postIndex != -1)
        {
          postComments[postIndex] = {'postId': postId, 'comments': comments};
        }
      });
      // print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
      // printFullText(postComments.toString());
      // print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
      emit(SocialGetCommentSuccessState());

    }).catchError((error)
    {
      print(error.toString());
      emit(SocialGetCommentErrorState(error.toString()));

    });

  }




  void removeCommentsMap()
  {
    postComments = [];
    emit(SocialRemoveCommentsState());
  }



}





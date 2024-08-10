import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_create/user_create_model.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        ).then((value){
          print(value.user!.email);
          print(value.user!.uid);
          userCreate(
            name: name,
            email: email,
            phone: phone,
            uId: value.user!.uid,
          );
    }).catchError((error) {
      print(error.toString());
      emit(SocialRegisterErrorState(error.toString()));
    });
  }


  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ...',
      image: 'https://upload.wikimedia.org/wikipedia/commons/b/bc/Unknown_person.jpg',
      cover: 'bhmpics.com/downloads/hd-social-backgrounds/3.12.jpg',//https://www.bhmpics.com/downloads/hd-social-backgrounds/36.wp9546909.jpg
    );

    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value)
    {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }






  IconData suffix = Icons.visibility_outlined;

  bool isPassword = true;

  void changeEyeIcon() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangeEyeIconState());
  }
}

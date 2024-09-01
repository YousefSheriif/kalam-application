import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      image: 'https://firebasestorage.googleapis.com/v0/b/social-app-f5d14.appspot.com/o/users%2FUnknown_person.jpg?alt=media&token=74fa539e-4b53-4e6b-a0cc-001ca3369466',
      cover: 'https://firebasestorage.googleapis.com/v0/b/social-app-f5d14.appspot.com/o/users%2F3.12.jpg?alt=media&token=784c9142-b000-4c1a-b175-8c67f547c1c5',//https://www.bhmpics.com/downloads/hd-social-backgrounds/36.wp9546909.jpg
    );

    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value)
    {
      emit(SocialCreateUserSuccessState(uId));
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/shared/styles/iconBroken.dart';
import 'package:social_app/translations/locale_keys.g.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController =TextEditingController();
  var bioController =TextEditingController();
  var phoneController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        dynamic profileImage = SocialCubit.get(context).profileImage;
        dynamic coverImage = SocialCubit.get(context).coverImage;
        dynamic profilePic;
        if (profileImage == null) {
          profilePic = NetworkImage('${userModel?.image}');
        } else {
          profilePic = FileImage(profileImage);
        }

        dynamic coverPic;
        if (coverImage == null) {
          coverPic = NetworkImage('${userModel?.cover}');
        } else {
          coverPic = FileImage(coverImage);
        }

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                navigateBack(context);
              },
              icon: const Icon(

                Icons.arrow_back,
              ),
            ),
            title: Text(
              LocaleKeys.editProfile.tr(),
            ),
            actions: [
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      Icons.save,
                      size: 20.0,
                      color: defaultColor,
                    ),
                    defaultTextButton(
                        Function: ()
                        {
                          SocialCubit.get(context).updateUser(
                            name: nameController.text,
                            phone: phoneController.text,
                            bio: bioController.text,
                          );
                        },
                        text: LocaleKeys.save.tr(),
                        color: defaultColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                onTap: () {},
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is SocialUpdateUserLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 15.0,),
                  SizedBox(
                    height: 270.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 220.0,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(5.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverPic,//NetworkImage('${userModel.cover}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: IconButton(
                                  icon: const CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: defaultColor,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  iconSize: 35.0,
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getCoverImage().then((value)
                                    {
                                      if (SocialCubit.get(context).coverImage!=null)
                                      {
                                        SocialCubit.get(context).uploadCoverImage(userModel.name, userModel.phone, userModel.bio, userModel.image);
                                      }
                                    });

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profilePic,  // profileImage == null ? NetworkImage('${userModel.image}'):FileImage(profileImage),
                              ),
                            ),
                            IconButton(
                              icon: const CircleAvatar(
                                radius: 30.0,
                                backgroundColor: defaultColor,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              iconSize: 35.0,
                              onPressed: ()
                              {
                                SocialCubit.get(context).getProfileImage().then((value)
                                {
                                  if (SocialCubit.get(context).profileImage!=null)
                                  {
                                    SocialCubit.get(context).uploadProfileImage(userModel.name, userModel.phone, userModel.bio, userModel.cover);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  // if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                  //   Row(
                  //   children:
                  //   [
                  //     if(SocialCubit.get(context).profileImage != null )
                  //       Expanded(child: OutlinedButton(onPressed: (){}, child: Text('Upload Profile',style: TextStyle(fontSize: 19.0),))),
                  //     const SizedBox(width: 15.0),
                  //     if(SocialCubit.get(context).coverImage != null )
                  //       Expanded(child: OutlinedButton(onPressed: (){}, child: Text('Upload Cover',style: TextStyle(fontSize: 19.0),)))
                  //
                  //   ],
                  // ),
                  // if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null)
                  //   const SizedBox(
                  //   height: 30.0,
                  // ),
                  defaultTextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    labelText: LocaleKeys.yourName.tr(),
                    prefixIcon: IconBroken.User,
                    prefixColor: defaultColor,
                    validatorString: LocaleKeys.emptyName.tr(),
                    textColor: Theme.of(context).textTheme.bodyText1!.color,
                    labelColor: Theme.of(context).textTheme.bodyText1!.color,
                    borderColor: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  defaultTextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    labelText: LocaleKeys.yourBio.tr(),
                    prefixIcon: IconBroken.Info_Circle,
                    prefixColor:defaultColor,
                    validatorString: LocaleKeys.emptyBio.tr(),
                    textColor: Theme.of(context).textTheme.bodyText1!.color,
                    labelColor: Theme.of(context).textTheme.bodyText1!.color,
                    borderColor: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  defaultTextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    labelText: LocaleKeys.yourPhone.tr(),
                    prefixIcon: IconBroken.Call,
                    prefixColor:defaultColor,
                    validatorString: LocaleKeys.emptyPhone.tr(),
                    textColor: Theme.of(context).textTheme.bodyText1!.color,
                    labelColor: Theme.of(context).textTheme.bodyText1!.color,
                    borderColor: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
//https://img.freepik.com/free-photo/laughing-black-man-glasses-expressing-excitement-emotional-international-student-holding-computer_197531-20167.jpg?w=1060&t=st=1692794285~exp=1692794885~hmac=0d744e7c5fe6ecb77f2e6e8641aae84756dd21baf8b88b21a3ab9ae6f4f280e5
//https://www.bhmpics.com/downloads/hd-social-backgrounds/36.wp9546909.jpg
// 60 640
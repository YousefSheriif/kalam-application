import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/edit_profile/social_edit_profile_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';
import 'package:social_app/shared/styles/iconBroken.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        var userModel = SocialCubit.get(context).userModel;
        return ConditionalBuilder(
          condition:SocialCubit.get(context).userModel != null ,
          builder: (context)
          {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children:
                [
                  SizedBox(
                    height: 270.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children:
                      [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            width: double.infinity,
                            height: 220.0,
                            decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft:Radius.circular(5.0),
                                topRight:Radius.circular(5.0),
                              ),
                              image: DecorationImage(
                                // image: AssetImage('assets/images/pic2.jpg',),
                                image: NetworkImage('${userModel?.cover}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 65.0,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(

                            radius: 60.0,
                            // backgroundImage: AssetImage('assets/images/pic1.jpg',), //NetworkImage('assets/images/pic1.jpg')
                            backgroundImage: NetworkImage(
                              '${userModel?.image}'
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '${userModel?.name}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 23.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Text(
                    '${userModel?.bio}',
                    style: const TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children:
                              [
                                Text(
                                  '324',
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0,),
                                const Text(
                                  'Friends',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,

                                  ),
                                ),

                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children:
                               [
                                Text(
                                  '44',
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8.0,),
                                const Text(
                                  'Posts',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,

                                  ),
                                ),

                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children:
                               [
                                Text(
                                  '12k',
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              const SizedBox(height: 8.0,),
                                const Text(
                                  'Followers',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,

                                  ),
                                ),

                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children:
                              [
                                Text(
                                  '23',
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              const SizedBox(height: 8.0,),
                               const Text(
                                  'Followings',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,

                                  ),
                                ),

                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children:
                    [
                      Expanded(
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          onPressed: (){},
                          child: const Text(
                            'Add Photo',
                            style: TextStyle(fontSize: 18.0,),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15.0,),
                      OutlinedButton(
                        onPressed: ()
                        {
                          navigateTo(context, EditProfileScreen());
                        },
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                            const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child:const Icon(IconBroken.Edit_Square,),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          fallback: (context)
          {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}

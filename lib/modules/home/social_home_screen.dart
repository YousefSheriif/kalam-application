// new update
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/new_comments_screen/new_comments_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';
import 'package:social_app/shared/styles/iconBroken.dart';
import 'package:social_app/translations/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  var commentController = TextEditingController();
  // var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        if (state is SocialGetPostLoadingState) {
          return const Center(child: CircularProgressIndicator());

        } else
        {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // SizedBox(
                //   height: 50.0,
                //   child: IconButton(
                //     onPressed: () {
                //       ModeCubit.get(context).changeAppMode();
                //     },
                //     icon: Icon(
                //       Icons.brightness_4_outlined,
                //       color: Theme.of(context).textTheme.bodyText1!.color,
                //     ),
                //   ),
                // ),
                // IconButton(
                //   onPressed: () {
                //     navigateTo(context, const TestScreen());
                //   },
                //   icon: const Icon(
                //     Icons.arrow_forward,
                //   ),
                // ),
                // const SizedBox(
                //   height: 30.0,
                // ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Theme.of(context).textTheme.bodyText2!.color,
                  elevation: 8.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 23.0,
                              backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel.image}',
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  navigateTo(
                                    context,
                                    NewPostScreen(),
                                  );
                                },
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: Text(
                                        LocaleKeys.whatOnMind.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3!
                                            .copyWith(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Icon(
                                      IconBroken.Image,
                                      color: Colors.blue[700],
                                      size: 25.0,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      LocaleKeys.image.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 1,
                                      height: 35.0,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(width: 18.0),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.tag,
                                      color: Colors.red,
                                      size: 27.0,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      LocaleKeys.tags.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 1,
                                      height: 35.0,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(width: 18.0),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  const Icon(
                                    IconBroken.Document,
                                    color: Colors.green,
                                    size: 25.0,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    LocaleKeys.docs.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ConditionalBuilder(
                  condition: SocialCubit.get(context).posts.isNotEmpty,
                  builder: (BuildContext context) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index)
                      {
                        return buildPostItem(SocialCubit.get(context).posts[index], context, index);
                      },
                      separatorBuilder: (context, index)
                      {
                        return const SizedBox(
                          height: 10.0,
                        );
                      },
                      itemCount: SocialCubit.get(context).posts.length,
                    );
                  },
                  fallback: (BuildContext context) {
                    return Column(
                      children:  [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical:250.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Text(
                                  LocaleKeys.emptyPosts.tr(),
                                  style:const TextStyle(color: Colors.red,fontSize: 24.0,fontWeight: FontWeight.bold),
                                ),
                                const Icon(Icons.face_outlined,size: 35.0,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildPostItem( model, context, index)
  {
    Color backgroundColor;

    final postsCubit = SocialCubit.get(context);

    if (postsCubit != null && postsCubit.fav.containsKey(postsCubit.postsIds[index])) {
      if (postsCubit.fav[postsCubit.postsIds[index]] == true) {
        backgroundColor = Colors.red;
      } else {
        backgroundColor = Colors.grey;
      }
    } else {
      backgroundColor = Colors.grey; // Default color if the post ID is not present or value is null
    }
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Theme.of(context).textTheme.bodyText2!.color,
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                    '${model.image}',
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                    ),
                          ),
                          const SizedBox(
                            width: 7.0,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 25.0,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20.0,),
            Text(
              '${model.postText}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //     top: 5.0,
            //     bottom: 2.0,
            //   ),
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 7.0,
            //           ),
            //           child: SizedBox(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               child: const Text(
            //                 '#software',
            //                 style: TextStyle(
            //                   fontSize: 17.0,
            //                   color: Colors.blue,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(
            //             end: 7.0,
            //           ),
            //           child: SizedBox(
            //             height: 25.0,
            //             child: MaterialButton(
            //               onPressed: () {},
            //               padding: EdgeInsets.zero,
            //               minWidth: 1.0,
            //               child: const Text(
            //                 '#software_development',
            //                 style: TextStyle(
            //                   fontSize: 17.0,
            //                   color: Colors.blue,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15.0,),
                child: Container(
                  width: double.infinity,
                  height: 220.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    image: DecorationImage(
                        image: NetworkImage(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                              size: 18.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).postLikes[index]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.red,
                              size: 18.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                             '120',// SocialCubit.get(context).postComments[index]['comments'].length,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            Text(
                              LocaleKeys.comments.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      onTap: ()
                      {
                        print(SocialCubit.get(context).postComments[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel.image}',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          LocaleKeys.writeComment.tr(),
                          style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    onTap: ()
                    {





                      // List<Map<String, dynamic>> comments = SocialCubit.get(context).postComments.where((comment) => comment['postId'] == SocialCubit.get(context).postsIds[index]).toList();
                      // print(comments);
                      // if(comments[0]['comments'].length>0)
                      // {
                      //   print(comments[0]['comments'].length);
                      //   print(comments[0]['comments'][0]);
                      //   print(comments[0]['comments'][1]);
                      //   print(comments[0]['comments'][1]['name']);
                      //
                      // }
                      // navigateTo(context, NewCommentsScreen(index,commentController));




                      SocialCubit.get(context).getComments(SocialCubit.get(context).postsIds[index]).then((value)
                      {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => NewCommentsScreen(postIndex: index),
                        //   ),
                        // );

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder:(context)
                            {
                              return  NewCommentsScreen(postIndex: index);
                            },
                          ),
                              (Route<dynamic> route) => false,
                        );

                      });



                      // showBottomSheet(
                      //     context: context,
                      //     builder: (value)
                      //     {
                      //       return Container(
                      //         width: double.infinity,
                      //         height: double.infinity,
                      //         color: Colors.grey[200],
                      //         child: Stack(
                      //           children:
                      //           [
                      //             if(SocialCubit.get(context).postComments[index]['comments'].length>0)
                      //               ListView.separated(
                      //               itemBuilder: (context, commentIndex)
                      //               {
                      //                 return Padding(
                      //                   padding: const EdgeInsets.all(9.0),
                      //                   child: Container(
                      //                     padding: const EdgeInsets.all(12.0),
                      //                     color: Colors.white,
                      //                     child: Row(
                      //                       children: [
                      //                         CircleAvatar(
                      //                           radius: 20.0,
                      //                           backgroundImage: NetworkImage(
                      //                             '${SocialCubit.get(context).postComments[index]['comments'][commentIndex]['image']}',
                      //                           ),
                      //                         ),
                      //                         const SizedBox(
                      //                           width: 20,
                      //                         ),
                      //                         Expanded(
                      //                           child: Column(
                      //                             crossAxisAlignment:
                      //                             CrossAxisAlignment.start,
                      //                             children: [
                      //                               Row(
                      //                                 children: [
                      //                                   Text(
                      //                                     '${SocialCubit.get(context).postComments[index]['comments'][commentIndex]['name']}',
                      //                                     style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17.0, fontWeight: FontWeight.bold,height: 1.4,
                      //                                     ),
                      //                                   ),
                      //                                   const SizedBox(
                      //                                     width: 7.0,
                      //                                   ),
                      //                                   const Icon(
                      //                                     Icons.check_circle,
                      //                                     color: Colors.blue,
                      //                                     size: 14.0,
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                               const SizedBox(
                      //                                 height: 5.0,
                      //                               ),
                      //                               Text(
                      //                                 '${SocialCubit.get(context).postComments[index]['comments'][commentIndex]['commentText']}',
                      //                                 style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500,color: Colors.black, height: 1.4,),
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 );
                      //               },
                      //               separatorBuilder: (context, commentIndex)
                      //               {
                      //                 return const SizedBox(height: 1.0,);
                      //               },
                      //               itemCount: SocialCubit.get(context).postComments[index]['comments'].length,
                      //               // physics: const NeverScrollableScrollPhysics(),
                      //               shrinkWrap: true,
                      //             ),
                      //
                      //             Column(
                      //               children: [
                      //                 Container(
                      //                   width: double.infinity,
                      //                   height: 20.0,
                      //                   color: Colors.grey[100],
                      //                   child: const Icon(Icons.menu,size: 20.0,color: Colors.grey,),
                      //                 ),
                      //                 const Spacer(),
                      //                 Container(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   color: Colors.grey[100],
                      //                   child: TextFormField(
                      //                     controller: commentController,
                      //                     validator: (val) {
                      //                       if (val!.isEmpty) {
                      //                         return "can't put empty comment!";
                      //                       }
                      //                       return null;
                      //                     },
                      //                     decoration: InputDecoration(
                      //                       prefixIcon: IconButton(
                      //                         onPressed: ()
                      //                         {
                      //                           SocialCubit.get(context).commentPosts(SocialCubit.get(context).postsIds[index], commentController.text);
                      //                         },
                      //                         icon: const Icon(
                      //                           Icons.arrow_circle_left_rounded,
                      //                           size: 35.0,
                      //                           color: Colors.blueAccent,
                      //                         ),
                      //                       ),
                      //                       hintText: 'write a comment..',
                      //                       hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      //                         fontSize: 16.0,
                      //                         fontWeight: FontWeight.w400,
                      //                       ),
                      //                       border: OutlineInputBorder(
                      //                         borderRadius:
                      //                         BorderRadius.circular(30.0),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     });











                    },
                  ),
                  const Spacer(),
                  InkWell(
                    child: SizedBox(
                      height: 40.0,
                      child: Row(
                        children: [
                           CircleAvatar(
                            backgroundColor:backgroundColor,
                            radius: 12.0,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            LocaleKeys.love.tr(),
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      // print(SocialCubit.get(context).postsIds[index]);
                      // SocialCubit.get(context).changeIcon();
                      SocialCubit.get(context).likePosts(SocialCubit.get(context).postsIds[index]);
                      // print('yousefyousefyousefyousefyousefyousefyousefyousefyousefyousefyousef');
                      // SocialCubit.get(context).getLikesNum();
                    },
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

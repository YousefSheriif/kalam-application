import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/shared/app_mode_cubit/mode_cubit.dart';
import 'package:social_app/shared/app_mode_cubit/mode_states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';
import 'package:social_app/shared/styles/iconBroken.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Theme.of(context).textTheme.bodyText2!.color,
              elevation: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 8.0,),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children:
                  [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage('assets/images/pic1.jpg',), //NetworkImage('assets/images/pic1.jpg')
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children:  [
                                  Text(
                                    'امن دولة',
                                    style: Theme.of(context).textTheme.bodyText1!.copyWith
                                      (
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7.0,
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size: 20.0,
                                  ),
                                ],
                              ),
                              const Text(
                                'August 11, 2023 at 12:32 pm',
                                style: TextStyle(
                                  fontSize: 15.0,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0,),
                      child: Container(
                        width: double.infinity,
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero\'s De Finibus Bonorum et Malorum for use in a type specimen book.',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith
                        (
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        bottom: 2.0,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.only(end: 7.0,),
                              child: SizedBox(
                                height: 25.0,
                                child: MaterialButton(
                                  onPressed: (){},
                                  padding: EdgeInsets.zero,
                                  minWidth: 1.0,
                                  child: const Text(
                                    '#software',
                                    style: TextStyle(fontSize: 17.0, color: Colors.blue,),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(end: 7.0,),
                              child: SizedBox(
                                height: 25.0,
                                child: MaterialButton(
                                  onPressed: (){},
                                  padding: EdgeInsets.zero,
                                  minWidth: 1.0,
                                  child: const Text(
                                    '#software_development',
                                    style: TextStyle(fontSize: 17.0, color: Colors.blue,),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0,),
                    Container(
                      width: double.infinity,
                      height: 220.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5,),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/pic1.jpg',),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children:
                        [
                          Expanded(
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children:
                                  [
                                    Icon(IconBroken.Heart,color: Colors.red,size: 20.0,),
                                    SizedBox(width: 5.0,),
                                    Text(
                                      '120',
                                      style:Theme.of(context).textTheme.bodyText2!.copyWith(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: (){},
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:
                                  [
                                    Icon(IconBroken.Chat,color: Colors.red,size: 20.0,),
                                    SizedBox(width: 5.0,),
                                    Text(
                                      '120 comments',
                                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: (){},
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
                        children:
                        [
                          InkWell(
                            child: Row(
                              children:
                              const [
                                CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: AssetImage('assets/images/pic1.jpg'),//NetworkImage('assets/images/pic1.jpg')
                                ),
                                SizedBox(width: 10,),
                                Text('Write a comment ...',style:TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500,color: Colors.grey),),

                              ],
                            ),
                            onTap: (){},
                          ),
                          const Spacer(),
                          InkWell(
                            child: SizedBox(
                              height: 40.0,
                              child: Row(
                                children:
                                [
                                  Icon(IconBroken.Heart,color: Colors.red,),
                                  SizedBox(width: 5.0,),
                                  Text(
                                    'Like',
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){},

                          ),
                          const Spacer(),
                          InkWell(
                            child: SizedBox(
                              height: 40.0,
                              child: Row(
                                children:
                                [
                                  Icon(IconBroken.Chat,color: Colors.red,),
                                  SizedBox(width: 5.0,),
                                  Text(
                                    'comments',
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){},

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}


// String? profilePicURL;
//
//   void uploadProfilePic(
//     String? name,
//     String? phone,
//     String? bio,
//     String? email,
//     String? coverImage,
//   ) {
//     firebase_storage.FirebaseStorage.instance
//         .ref()
//         .child(Uri.file(profileImage!.path).pathSegments.last)
//         .putFile(profileImage!)
//         .then((value) {
//       value.ref.getDownloadURL().then((value) {
//         updateUserData(
//             name: name,
//             phone: phone,
//             bio: bio,
//             coverImage: coverImage,
//             profileImage: value);
//         emit(UploadProfilePicSuccessState());
//       }).catchError((error) {
//         print(error.toString());
//         emit(UploadProfilePicErrorState());
//       });
//       emit(UploadProfilePicSuccessState());
//     }).catchError((error) {
//       print(error.toString());
//       emit(UploadProfilePicErrorState());
//     });
//   }








          // body: SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.all(20),
          //     child: Column(
          //       children:
          //       [
          //
          //         Row(
          //           children:
          //           [
          //             CircleAvatar(
          //                 radius: 25,
          //                 backgroundImage:NetworkImage('${userModel!.profilePic}')
          //             ),
          //             SizedBox(width: 15,),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text('${userModel.name}',style: TextStyle(fontSize: 15,color: SocialCubit.get(context).textColor),),
          //                 SizedBox(height: 5,),
          //                 Text(LocaleKeys.public.tr(),style: TextStyle(color: Colors.grey),)
          //               ],
          //             ),
          //           ],
          //         ),
          //         SizedBox(height: 12,),
          //         TextFormField(
          //           controller: postTextController,
          //           maxLines: 10,
          //           textCapitalization: TextCapitalization.sentences,
          //           autocorrect: true,
          //           decoration: InputDecoration(
          //             hintText: LocaleKeys.whatOnYourMind.tr(),
          //             hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
          //             border: InputBorder.none,
          //             contentPadding: EdgeInsets.zero,
          //
          //           ),
          //         ),
          //         if(SocialCubit.get(context).postImage != null)
          //           Stack(
          //             alignment: AlignmentDirectional.topEnd,
          //             children: [
          //               Container(
          //                 width: double.infinity,
          //                 decoration: BoxDecoration(
          //                     color: SocialCubit.get(context).backgroundColor,
          //                     borderRadius: BorderRadius.circular(15)),
          //                 clipBehavior: Clip.antiAliasWithSaveLayer,
          //                 child:Image.file(postPic,fit: BoxFit.cover,width: double.infinity),
          //                 alignment: AlignmentDirectional.topCenter,
          //               ),
          //               Padding(
          //                 padding: const EdgeInsetsDirectional.only(top: 10,end: 10),
          //                 child: CircleAvatar(
          //                   backgroundColor: Colors.grey[300],
          //                   child: IconButton(
          //                       onPressed: (){
          //                         SocialCubit.get(context).popPostImage();
          //                       },
          //                       icon: Icon(Icons.close)),
          //                 ),
          //               )
          //             ],
          //           ),
          //         if(isEdit && postModel!.postImage != null)
          //           Stack(
          //             alignment: AlignmentDirectional.topEnd,
          //             children: [
          //               Container(
          //                 width: double.infinity,
          //                 decoration: BoxDecoration(
          //                     color: SocialCubit.get(context).backgroundColor,
          //                     borderRadius: BorderRadius.circular(15)),
          //                 clipBehavior: Clip.antiAliasWithSaveLayer,
          //                 child:Image.network(postModel!.postImage!,fit: BoxFit.cover,width: double.infinity),
          //                 alignment: AlignmentDirectional.topCenter,
          //               ),
          //               Padding(
          //                 padding: const EdgeInsetsDirectional.only(top: 10,end: 10),
          //                 child: CircleAvatar(
          //                   backgroundColor: Colors.grey[300],
          //                   child: IconButton(
          //                       onPressed: (){
          //                         postModel!.postImage = null;
          //                         SocialCubit.get(context).popPostImage();
          //                       },
          //                       icon: Icon(Icons.close)),
          //                 ),
          //               )
          //             ],
          //           ),
          //       ],
          //     ),
          //   ),
          // ),
          // bottomSheet: Container(
          //   color: SocialCubit.get(context).backgroundColor.withOpacity(1),
          //   child: Row(
          //     children:
          //     [
          //       SizedBox(width: 5,),
          //       Expanded(
          //         child: TextButton(
          //             onPressed: (){
          //               SocialCubit.get(context).getPostImage();
          //             },
          //             child: Row(
          //               children:
          //               [
          //                 Icon(IconBroken.Image),
          //                 SizedBox(width: 5,),
          //                 Text(LocaleKeys.image.tr(),style: TextStyle(color: Colors.grey)),
          //               ],
          //             )
          //         ),
          //       ),
          //       Container(height: 30,width: 1,color: Colors.grey[300],),
          //       SizedBox(width: 5,),
          //       Expanded(
          //         child: TextButton(
          //             onPressed: (){},
          //             child: Row(
          //               children:
          //               [
          //                 Icon(Icons.tag,color: Colors.red,),
          //                 SizedBox(width: 5,),
          //                 Text(LocaleKeys.tags.tr(),style: TextStyle(color: Colors.grey),),
          //               ],
          //             )
          //         ),
          //       ),
          //       Container(height: 30,width: 1,color: Colors.grey[300],),
          //       SizedBox(width: 5,),
          //       Expanded(
          //         child: TextButton(
          //             onPressed: (){},
          //             child: Row(
          //               children:
          //               [
          //                 Icon(IconBroken.Document,color: Colors.green,),
          //                 SizedBox(width: 5,),
          //                 Text(LocaleKeys.docs.tr(),style: TextStyle(color: Colors.grey)),
          //               ],
          //             )
          //         ),
          //       ),
          //     ],
          //   ),
          // ),





// بديل لل bottomsheet في صفحة new_post_screen
//  بتتحط بعد ال text form field  = بما تفكر الان
// const Spacer(),
// Row(
//   children: [
//     Expanded(
//       child: InkWell(
//         onTap: () {},
//         child: Row(
//           children:  [
//             Icon(
//               IconBroken.Image,
//               color: Colors.blue[700],
//               size: 25.0,
//             ),
//             const SizedBox(
//               width: 5.0,
//             ),
//             Text(
//               'Image',
//               style:Theme.of(context).textTheme.headline3!.copyWith(fontSize: 18.0,),
//             ),
//             const Spacer(),
//             Container(
//               width: 1,
//               height: 35.0,
//               color:Colors.grey[400],
//             ),
//             const SizedBox(width: 18.0),
//           ],
//         ),
//       ),
//     ),
//     Expanded(
//       child: InkWell(
//         onTap: () {},
//         child: Row(
//           children:  [
//             const Icon(
//               Icons.tag,
//               color: Colors.red,
//               size: 27.0,
//             ),
//             const SizedBox(
//               width: 5.0,
//             ),
//             Text(
//               'Tags',
//               style:Theme.of(context).textTheme.headline3!.copyWith(fontSize: 18.0,),
//             ),
//             const Spacer(),
//             Container(
//               width: 1,
//               height: 35.0,
//               color:Colors.grey[400],
//             ),
//             const SizedBox(width: 18.0),
//           ],
//         ),
//       ),
//     ),
//     InkWell(
//       onTap: () {},
//       child: Row(
//         children:  [
//           const Icon(
//             IconBroken.Document,
//             color: Colors.green,
//             size: 25.0,
//           ),
//           const SizedBox(
//             width: 5.0,
//           ),
//           Text(
//             'Docs',
//             style:Theme.of(context).textTheme.headline3!.copyWith(fontSize: 18.0,),
//           ),
//         ],
//       ),
//     ),
//   ],
// ),

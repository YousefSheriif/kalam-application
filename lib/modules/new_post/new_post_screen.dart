// new update
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/modules/Social_layout/social_layout_screen.dart';
import 'package:social_app/modules/home/social_home_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/shared/styles/iconBroken.dart';
import 'package:social_app/translations/locale_keys.g.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  var postTextController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialAppStates>(
      listener:(context,state)
      {
        if (state is SocialCreatePostSuccessState)
        {
          navigateAndFinish(context, SocialLayoutScreen());
          SocialCubit.get(context).currentIndex = 0;
        }
      } ,
      builder:(context,state)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.createPost.tr(),
              style:Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(icon: const Icon(Icons.arrow_back_ios),
              onPressed: ()
              {
                Navigator.pop(context);
              },
            ),
            actions: [
              defaultTextButton(
                Function: ()
                {
                  if(formKey.currentState!.validate())
                  {
                    var now = DateTime.now();
                    var formattedDate = DateFormat('d MMM yyyy \'at\' h:mm a','en_US').format(now);

                    // print(now);
                    if(SocialCubit.get(context).postImage==null)
                    {
                      SocialCubit.get(context).createPost(dateTime: formattedDate.toString(), postText: postTextController.text,);
                    }
                    else
                    {
                      SocialCubit.get(context).uploadPostImage(dateTime: formattedDate.toString(), postText: postTextController.text,);
                    }
                  }
                },
                text: LocaleKeys.post.tr(),
                color: defaultColor,fontWeight: FontWeight.bold,fontSize: 22.0,),
              const SizedBox(width: 20.0,),
            ],
          ),
          body:  Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  const LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22.0,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel?.image}',
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
                                  '${SocialCubit.get(context).userModel?.name}',
                                  style:
                                  Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 21.0,
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
                                  size: 17.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Form(
                    key:formKey ,
                    child: TextFormField(
                      controller:postTextController ,

                      validator: (val)
                      {
                        if(val!.isEmpty){
                          return'sorry, you have not write any thing yet..';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText:LocaleKeys.whatOnMind.tr(),
                        border: InputBorder.none,
                        hintStyle:Theme.of(context).textTheme.headline3!.copyWith(fontSize: 18.0, fontWeight: FontWeight.bold, height: 1.4,),
                      ),
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage!=null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 260.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage),      //NetworkImage('${userModel.cover}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: IconButton(
                        icon:  CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.red[900],
                          child:const Icon(
                            Icons.close,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        iconSize: 35.0,
                        onPressed: ()
                        {
                          SocialCubit.get(context).removeImage();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
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
          ),
        );
      } ,
    );
  }
}

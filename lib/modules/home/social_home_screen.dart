import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/create_post/create_post_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        if (state is SocialGetPostLoadingState)
        {
          return const Center(child: CircularProgressIndicator());
        } else
        {
          if(SocialCubit.get(context).userModel==null)
          {
           return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: Theme.of(context).textTheme.bodyText2!.color,
                  elevation: 8.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 21.0,
                              backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel?.image}',
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
                          height: 7.0,
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
                                      size: 22.0,
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
                                        fontSize: 14.0,
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
                                      size: 22.0,
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
                                        fontSize: 14.0,
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
                                    size: 22.0,
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
                                      fontSize: 14.0,
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
                  condition: SocialCubit.get(context).newPosts.isNotEmpty,
                  builder: (BuildContext context) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index)
                      {
                        return buildPostItem(SocialCubit.get(context).newPosts[index], context, index);
                      },
                      separatorBuilder: (context, index)
                      {
                        return const SizedBox(
                          height: 10.0,
                        );
                      },
                      itemCount: SocialCubit.get(context).newPosts.length,
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

  Widget buildPostItem( PostModel model, context, index)
  {
    bool? liked = model.iLikedThisPost;
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
                  radius: 23.0,
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
                                      fontSize: 17.5,
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
                            size: 13.0,
                          ),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style: const TextStyle(
                          fontSize: 13.0,
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
                              '${model.likesNumbers}',
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
                      onTap: ()
                      {
                        // print(SocialCubit.get(context).postsIds);
                        // print(SocialCubit.get(context).numberOfLikesPerPost);
                      },
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
                             '${model.commentsNumbers}',
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
                        // print(SocialCubit.get(context).numberOfCommentsPerPost);
                        // print(SocialCubit.get(context).numberOfCommentsPerPost[index]);
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
                            '${SocialCubit.get(context).userModel?.image}',
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

                      SocialCubit.get(context).getComments(SocialCubit.get(context).postsIds[index]).then((value)
                      {
                        navigateTo(context, NewCommentsScreen(postIndex: index));
                      });
                    },
                  ),
                  const Spacer(),
                  InkWell(
                    child: SizedBox(
                      height: 40.0,
                      child: Row(
                        children: [
                            CircleAvatar(
                            backgroundColor:liked!?Colors.red:Colors.grey,
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
                    onTap: ()
                    {
                      SocialCubit.get(context).newLikePosts(SocialCubit.get(context).postsIds[index]);
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

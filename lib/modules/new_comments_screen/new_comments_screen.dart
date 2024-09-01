// new screen
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_comment/user_comment_model.dart';
import 'package:social_app/modules/Social_layout/social_layout_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';
import 'package:social_app/translations/locale_keys.g.dart';

class NewCommentsScreen extends StatelessWidget {
  final int postIndex;
  final TextEditingController commentController = TextEditingController();

  NewCommentsScreen({required this.postIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.allComments.tr(),
        ),
      ),
      body: BlocConsumer<SocialCubit, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                Expanded(
                  child: SocialCubit.get(context).singlePostComments.isNotEmpty
                      ? ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    itemBuilder: (context, commentIndex) {
                      return buildCommentItem(SocialCubit.get(context).singlePostComments[commentIndex],context);
                    },
                    separatorBuilder: (context, commentIndex)
                    {
                      return const SizedBox(height: 10.0,);
                    },
                    itemCount:  SocialCubit.get(context).singlePostComments.length,
                  )
                      : Center(
                    child: Text(
                      LocaleKeys.noCommentYet.tr(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: commentController,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.emptyComment.tr();
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: LocaleKeys.writeComment.tr(),
                            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).commentPosts(SocialCubit.get(context).postsIds[postIndex], commentController.text);
                          commentController.clear();
                        },
                        icon: const Icon(
                          Icons.send_rounded,
                          size: 35.0,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  Widget buildCommentItem(CommentModel model, context)
  {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(
              '${model.image}',
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${model.name}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                      size: 14.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${model.commentText}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

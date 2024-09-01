import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_create/user_create_model.dart';
import 'package:social_app/modules/chat_messages/chat_messages_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return  BlocConsumer<SocialCubit,SocialAppStates>(
      listener: (context, state){},
      builder: (context, state)
      {
        return ConditionalBuilder(
          condition:SocialCubit.get(context).users!.isNotEmpty,
          builder: (context)
          {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                titleSpacing: 16.0,
                elevation: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 21.0,
                      // backgroundColor: Colors.black,
                      backgroundImage: NetworkImage('${SocialCubit.get(context).userModel?.image}'),
                    ),
                    const SizedBox(width: 6.0,),
                    const Text(
                      'Chats',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    icon:const CircleAvatar(
                      radius: 22.5,
                      backgroundColor: Colors.black,
                      child:Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 21.0,
                      ),
                    ),
                    onPressed: (){},
                  ),
                  const SizedBox(
                    width: 7.0,
                  ),
                  IconButton(
                    icon:const CircleAvatar(
                      radius: 22.5,
                      backgroundColor: Colors.black,
                      child:Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 21.0,
                      ),

                    ),
                    onPressed: (){},
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.all(4.0,),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 7.0,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.0
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        height: 100.0,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context , index )
                          {
                            return buildStoryItem(SocialCubit.get(context).users![index], context);
                          },
                          separatorBuilder: (context ,index )
                          {
                            return const SizedBox(width: 18.0,);
                          },
                          itemCount: SocialCubit.get(context).users!.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context , index )
                        {
                          return buildChatItem(context) ;

                        },
                        separatorBuilder: (context ,index)
                        {
                          return const SizedBox(height: 15.0,);
                        },
                        itemCount: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ) ;
          },
          fallback: (context)=>const Center(child: CircularProgressIndicator()),
        ) ;
      },
    );
  }

  Widget buildStoryItem(UserModel model, context)
  {
    return  InkWell(
      onTap: ()
      {
        navigateTo(context, ChatMessagesScreen(model));
      },
      child: SizedBox(
        width: 50.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children:[
                CircleAvatar(
                  radius: 28.5,
                  backgroundColor: Colors.black,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                const CircleAvatar(
                  radius: 8.5,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 7.0,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            Text(
              '${model.name}',
              style: const TextStyle(
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ) ;
  }

  Widget buildChatItem(context)
  {
    return  InkWell(
      onTap: ()
      {
         // navigateTo(context, ChatMessagesScreen());
      },
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25.5,
            backgroundColor: Colors.black,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Yousef sherif mohamed',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 7.0,),
                Row(
                  children: const [
                    Expanded(
                      child:Text(
                        'Hello my name is yousef and welcome back with flutter ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0),
                      child: CircleAvatar(radius: 4.0,backgroundColor: Colors.black,),
                    ),
                    Text(
                      '11:48 am',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ) ;
  }

}

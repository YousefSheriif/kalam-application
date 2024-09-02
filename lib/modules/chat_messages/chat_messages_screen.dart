import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_create/user_create_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';
import 'package:social_app/translations/locale_keys.g.dart';

class ChatMessagesScreen extends StatelessWidget
{
  UserModel ?otherUser;
   ChatMessagesScreen(this.otherUser, {Key? key}) : super(key: key);
   var chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context)
      {
        SocialCubit.get(context).getChatMessages(otherUser!.uId.toString());
        // print('******************************************');
        // print(SocialCubit.get(context).chatMessages);
        // //SocialCubit.get(context).chatMessages.isNotEmpty
        // print('******************************************');

        return BlocConsumer<SocialCubit, SocialAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.0,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${otherUser!.image}'),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      '${otherUser!.name}',
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index)
                        {
                          var message = SocialCubit.get(context).chatMessages[index];
                          if(message.senderId==SocialCubit.get(context).userModel!.uId)
                          {
                            return buildMyMessage(SocialCubit.get(context).chatMessages[index],context);
                          }
                          else
                          {
                            return buildFriendMessage(SocialCubit.get(context).chatMessages[index]);
                          }
                        },
                        separatorBuilder: (context, index)
                        {
                          return const SizedBox(height: 15.0,);
                        },
                        itemCount:SocialCubit.get(context).chatMessages.length,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[500]!,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsetsDirectional.only(start: 15.0),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller:chatController,
                              validator: (val) {
                                if (val!.isEmpty)
                                {
                                  return LocaleKeys.emptyMessage.tr();
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: LocaleKeys.writeYourMessageHere.tr(),
                              ),
                            ),
                          ),
                          Container(
                            height: 55.0,
                            width: 50.0,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: ()
                              {
                                // SocialCubit.get(context).changeLocalToEn(context);
                                var fullDate = DateTime.now();
                                var formattedDate = DateFormat('d MMM yyyy \'at\' h:mm a','en_US').format(fullDate);
                                var date = DateFormat('d MMM yyyy','en_US').format(fullDate);
                                var time = DateFormat('h:mm a','en_US').format(fullDate);

                                if(chatController.text!=''||chatController.text.isNotEmpty)
                                {
                                  SocialCubit.get(context).sendMessage(name: otherUser!.name,image: otherUser!.image,receiverUid: otherUser!.uId, message:chatController.text , dateTime: formattedDate.toString(),date:date,time: time );
                                  chatController.clear();
                                }
                                else
                                {
                                  showToast(message: 'write a right message', state: ToastStates.ERROR);
                                }
                              },
                              minWidth: 1.0,
                              child: const Icon(
                                Icons.send_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(onPressed: ()
                          {
                            var date = DateTime.now();
                            var formattedDate = DateFormat('d MMM yyyy','en_US').format(date);
                            var formattedTime = DateFormat('h:mm a','en_US').format(date);

                            print(formattedDate);
                            print(formattedTime);
                          }, icon: Icon(Icons.add),),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }



  Widget buildMyMessage(model,context)
  {
    return Align(
      alignment:AlignmentDirectional.centerEnd,
      child: Container(
        width: 350,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  color:Colors.blue,
                  borderRadius:BorderRadiusDirectional.only(
                    topStart: Radius.circular(12.0),
                    bottomStart:  Radius.circular(12.0),
                    bottomEnd:   Radius.circular(12.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 8.0),
                child: Text(
                  "${model.message}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            CircleAvatar(
              radius: 19.0,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 17.0,
                backgroundImage: NetworkImage('${SocialCubit.get(context).userModel!.image}'),//AssetImage('assets/images/pic1.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildFriendMessage(model)
  {
    return Align(
      alignment:AlignmentDirectional.centerStart,
      child: Container(
        width: 350,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 19.0,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 17.0,
                backgroundImage: NetworkImage('${otherUser!.image}')//AssetImage('assets/images/pic1.jpg'),
              ),
            ),
            const SizedBox(width: 10.0,),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color:Colors.blue.withOpacity(0.14),
                  borderRadius:const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(12.0),
                    bottomStart: Radius.circular(12.0),
                    bottomEnd:  Radius.circular(12.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 8.0),
                child: Text(
                  "${model.message}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

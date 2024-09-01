import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_create/user_create_model.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';
import 'package:social_app/translations/locale_keys.g.dart';

class ChatMessagesScreen extends StatelessWidget
{
  UserModel otherUser;
   ChatMessagesScreen(this.otherUser, {Key? key}) : super(key: key);
   var chatController = TextEditingController();
   var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: NetworkImage('${otherUser.image}'),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  '${otherUser.name}',
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index)
                      {
                        return buildFriendMessage();
                      },
                      separatorBuilder: (context, index)
                      {
                        return const SizedBox(height: 15.0,);
                      },
                      itemCount:10,
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
                            onPressed: () {
                              // SocialCubit.get(context).changeLocalToEn(context);

                              if(formKey.currentState!.validate())
                              {
                                SocialCubit.get(context).sendMessage(receiverUid: otherUser.uId, message:chatController.text , dateTime: DateTime.now().toString());
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

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }



  Widget buildMyMessage()
  {
    return Align(
      alignment:AlignmentDirectional.centerEnd,
      child: Container(
        width: 300.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
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
                    horizontal: 10.0, vertical: 6.0),
                child: const Text(
                  "message text text text text text text text text text text text text text text text text text text text text text",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0,),
            const CircleAvatar(
              radius: 19.0,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 17.0,
                backgroundImage: AssetImage('assets/images/pic1.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildFriendMessage()
  {
    return Align(
      alignment:AlignmentDirectional.centerStart,
      child: Container(
        width: 300.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 19.0,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 17.0,
                backgroundImage: AssetImage('assets/images/pic1.jpg'),
              ),
            ),
            const SizedBox(width: 10.0,),
            Expanded(
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
                    horizontal: 10.0, vertical: 6.0),
                child: const Text(
                  "message text text text text text text text text text text text text text text text text text text text text text",
                  style: TextStyle(
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

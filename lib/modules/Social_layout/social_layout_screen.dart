import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/chats/social_chats_screen.dart';
import 'package:social_app/modules/notifications/social_notifications_screen.dart';
import 'package:social_app/modules/search/social_search_screen.dart';
import 'package:social_app/shared/app_mode_cubit/mode_cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/shared/styles/iconBroken.dart';



class SocialLayoutScreen extends StatefulWidget {
  const SocialLayoutScreen({Key? key}) : super(key: key);

  @override
  State<SocialLayoutScreen> createState() => _SocialLayoutScreenState();
}

class _SocialLayoutScreenState extends State<SocialLayoutScreen> with SingleTickerProviderStateMixin {
  TabController ? tabController ;

  @override
  void initState()
  {
    tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: 0,
      animationDuration:const Duration(milliseconds: 750,),
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context)
  {
    var cubit = SocialCubit.get(context) ;
    return BlocConsumer<SocialCubit,SocialAppStates>(
      listener: (context,state)
      {},
      builder: (context,state)
      {
        return Scaffold(
          appBar:
          AppBar(
            elevation: 8,
            automaticallyImplyLeading: false,
            toolbarHeight :tabController!.index==0? null:0.0,
            title:tabController!.index==0 ?const Text(
              'Kalam ',
              style: TextStyle(letterSpacing:3.1,wordSpacing: 5.0,fontSize: 30.0),
            ): null,
            actions:tabController!.index==0? [
              IconButton(onPressed: ()
              {
                signOut(context);
                SocialCubit.get(context).currentIndex = 0;
              },
                icon: Icon(Icons.login_sharp,color: Theme.of(context).textTheme.bodyText1!.color,),
              ),
              IconButton(onPressed: ()
              {
                ModeCubit.get(context).changeAppMode();
              },
                icon: Icon(Icons.brightness_4_outlined,color: Theme.of(context).textTheme.bodyText1!.color,),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: PopupMenuButton(
                    onSelected: (value)
                    {
                      if (value == 'Arabic')
                      {
                        SocialCubit.get(context).changeLocalToAr(context);
                      } else
                      {
                        SocialCubit.get(context).changeLocalToEn(context);
                      }
                    },
                    color: Theme.of(context).textTheme.bodyText2!.color,
                    icon: Icon(
                      Icons.language,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    itemBuilder: (context) =>
                    [
                      PopupMenuItem(
                        value: 'Arabic',
                        child: Text(
                          'عربي',
                          style: TextStyle(
                            color:
                            Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'English',
                        child: Text(
                          'English',
                          style: TextStyle(
                            color:
                            Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              IconButton(
                  onPressed:()
              {
                navigateTo(context, const SearchScreen());
              },
                  icon: const Icon(IconBroken.Search)),
            ]:null,
            bottom:  TabBar(

              controller: tabController,
              labelColor: Colors.purple,
              indicatorColor: defaultColor,
              unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color,
              onTap: (index)
              {
                SocialCubit.get(context).changeIndex(index);
              },
              tabs:  [
                const Tab(icon: Icon(IconBroken.Home,),),
                const Tab(icon: Icon(IconBroken.Notification,),),
                const Tab(icon: Icon(IconBroken.User,),),
                const Tab(icon: Icon(IconBroken.Chat,),),
                CircleAvatar(radius: 12.0,backgroundColor:tabController!.index==4? Theme.of(context).textTheme.headline4!.color :Theme.of(context).textTheme.bodyText1!.color,child: Tab(icon: Icon(Icons.person,color: Theme.of(context).textTheme.bodyText2!.color,),),),
                const Tab(icon: Icon(Icons.menu,),),
              ],
            ),
          ),






          body: TabBarView(
            physics: const RangeMaintainingScrollPhysics(),
            controller: tabController,
            children: cubit.screens,

          ),
        ) ;
      },
    );
  }
}

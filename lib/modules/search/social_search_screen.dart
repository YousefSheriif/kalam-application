import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/social_cubit/states.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialAppStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text('Search',style: Theme.of(context).textTheme.bodyText1,)),
        );
      },
    );
  }
}

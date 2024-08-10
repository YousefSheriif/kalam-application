import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Social_layout/social_layout_screen.dart';
import 'package:social_app/modules/home/social_home_screen.dart';
import 'package:social_app/modules/login/new_login_screen.dart';
import 'package:social_app/modules/login/shop_login_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/on_boarding/liquid_on_boarding_screen.dart';
import 'package:social_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:social_app/shared/app_mode_cubit/mode_cubit.dart';
import 'package:social_app/shared/app_mode_cubit/mode_states.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/social_cubit/bloc_observer.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:social_app/translations/codegen_loader.g.dart';



void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  darkCopy = CacheHelper.getData(key: 'isDark');


  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  uId = CacheHelper.getData(key: 'uId');



  Widget startWidget;

  if (onBoarding != null)
  {
    if (uId != null)
    {
      startWidget = const SocialLayoutScreen();
    }
    else
    {
      startWidget = SocialLoginNewScreen();
    }
  }
  else
  {
    startWidget = const liquidOnBoarding();
  }

  runApp(EasyLocalization(
    supportedLocales: const
    [
      Locale('en'),
      Locale('ar'),
    ],
    path: 'assets/translations/',
    fallbackLocale: const Locale('en'),
    assetLoader: const CodegenLoader(),
    child: MyApp(
      isDark: darkCopy,
      startWidget: startWidget,
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.isDark, required this.startWidget});

  bool? isDark;
  Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context)
            {
              return ModeCubit()..changeAppMode(fromShared: isDark);
            }
        ),
        BlocProvider(
            create: (BuildContext context)
            {
              return SocialCubit()..getUserData()..getPosts();
            }
        ),
      ],
      child: BlocConsumer<ModeCubit, ModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ModeCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home:  startWidget,
          );
        },
      ),
    );
  }
}

// to arabic commands:

// flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations"
// flutter pub run easy_localization:generate -S "assets/translations/" -O "lib/translations" -o "locale_keys.g.dart" -f keys

// to add a package
// flutter pub add firebase_core

// flutter clean
// flutter pub get

// Firebase Mail
// yousef@gmail.com
// 123456
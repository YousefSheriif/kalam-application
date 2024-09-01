import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/Social_layout/social_layout_screen.dart';
import 'package:social_app/modules/login/login_cubit/cubit.dart';
import 'package:social_app/modules/login/login_cubit/states.dart';
import 'package:social_app/modules/register/register_cubit/cubit.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';
import 'package:social_app/modules/register/shop_register_screen.dart';
import 'package:social_app/shared/app_mode_cubit/mode_cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constant.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/translations/locale_keys.g.dart';

class SocialRegisterNewScreen extends StatelessWidget {
  SocialRegisterNewScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return SocialRegisterCubit();
      },
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state)
        {
          if(state is SocialCreateUserSuccessState)
            {
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value)
              {
                uId = state.uId;
                SocialCubit.get(context).getUserData();   // verrrrrrrrrrrry importaaaaaaaaant
                navigateAndFinish(context, const SocialLayoutScreen());
              });
              // SocialCubit.get(context).getUserData();   // verrrrrrrrrrrry importaaaaaaaaant
              navigateAndFinish(context, const SocialLayoutScreen(),);
            }
            else if(state is SocialCreateUserErrorState)
            {
              showToast(message: state.error, state: ToastStates.ERROR);
            }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              actions: [
                IconButton(onPressed: ()
                {
                  ModeCubit.get(context).changeAppMode();
                },
                  icon: const Icon(Icons.brightness_4_outlined,color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'Arabic') {
                          SocialCubit.get(context).changeLocalToAr(context);
                        } else {
                          SocialCubit.get(context).changeLocalToEn(context);
                        }
                      },
                      color: Theme.of(context).textTheme.bodyText2!.color,
                      icon: Icon(
                        Icons.language,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      itemBuilder: (context) => [
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
                    ),
                ),
              ],
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 60.0,
                              ),
                              Text(
                                LocaleKeys.register.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                LocaleKeys.registerEnjoy.tr(),
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          height: 600,
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            color: Theme.of(context).textTheme.bodyText2!.color,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0),
                            ),
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30.0,
                                ),
                                defaultTextFormField(
                                  errorColor: Colors.red,
                                  controller: nameController,
                                  keyboardType: TextInputType.text,
                                  labelText: LocaleKeys.userName.tr(),
                                  prefixIcon: Icons.perm_identity,
                                  validatorString:
                                      LocaleKeys.userNameError.tr(),
                                  borderColor: defaultColor,
                                  labelColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  prefixColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                defaultTextFormField(
                                  errorColor: Colors.red,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  labelText: LocaleKeys.emailAddress.tr(),
                                  prefixIcon: Icons.email_rounded,
                                  validatorString:
                                  LocaleKeys.emailAddressError.tr(),
                                  borderColor: defaultColor,
                                  labelColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  prefixColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                defaultTextFormField(
                                  errorColor: Colors.red,
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  labelText: LocaleKeys.phone.tr(),
                                  prefixIcon: Icons.phone,
                                  validatorString:
                                  LocaleKeys.phoneError.tr(),
                                  borderColor: defaultColor,
                                  labelColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  prefixColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                defaultTextFormField(
                                  borderColor: defaultColor,
                                  labelColor: Theme.of(context).textTheme.bodyText1!.color,
                                  textColor: Theme.of(context).textTheme.bodyText1!.color,
                                  prefixColor: Theme.of(context).textTheme.bodyText1!.color,
                                  errorColor: Colors.blue[700],
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  labelText: LocaleKeys.password.tr(),
                                  prefixIcon: Icons.lock_outline_rounded,
                                  suffixOnPressed: () {
                                    SocialRegisterCubit.get(context)
                                        .changeEyeIcon();
                                  },
                                  isPassword:
                                      SocialRegisterCubit.get(context).isPassword,
                                  validatorString:
                                      LocaleKeys.passwordError.tr(),
                                  suffixIcon:
                                      SocialRegisterCubit.get(context).suffix,
                                  suffixColor:
                                      !SocialRegisterCubit.get(context).isPassword
                                          ? defaultColor
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),

                                ConditionalBuilder(
                                  condition: state is! SocialRegisterLoadingState,
                                  builder: (BuildContext context) {
                                    return defaultButton(
                                      color: defaultColor,
                                      width: double.infinity,
                                      text: LocaleKeys.signUp.tr(),
                                      textSize: 28.0,
                                      Function: () {
                                        if(formKey.currentState!.validate())
                                        {
                                          SocialRegisterCubit.get(context).userRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text,

                                          );
                                        }
                                      },
                                    );
                                  },
                                  fallback: (BuildContext context) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                                const SizedBox(
                                  height: 40.0,
                                ),


                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      LocaleKeys.haveAccount.tr(),
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    defaultTextButton(
                                      Function: ()
                                      {
                                        navigateTo(context, SocialRegisterScreen());
                                      },
                                      text: LocaleKeys.signIn.tr(),
                                      fontWeight: FontWeight.bold,
                                      color: defaultColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
}

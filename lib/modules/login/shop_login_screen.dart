import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/login/login_cubit/cubit.dart';
import 'package:social_app/modules/login/login_cubit/states.dart';
import 'package:social_app/modules/register/shop_register_screen.dart';
import 'package:social_app/shared/app_mode_cubit/mode_cubit.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/social_cubit/cubit.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/translations/locale_keys.g.dart';


class SociaLoginScreen extends StatelessWidget
{
  SociaLoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)
      {
        return SocialLoginCubit();
      },

      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context ,state)
        {},
        builder: (context ,state)
        {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: PopupMenuButton(
                      onSelected: (value)
                      {
                        if(value == 'Arabic') {
                          SocialCubit.get(context).changeLocalToAr(context);
                        } else {
                          SocialCubit.get(context).changeLocalToEn(context);
                        }
                      } ,
                      color: Theme.of(context).textTheme.bodyText2!.color,
                      icon: Icon(Icons.language,color: Theme.of(context).textTheme.bodyText1!.color,),
                      itemBuilder: (context) =>  [
                         PopupMenuItem(
                          value: 'Arabic',
                          child: Text('عربي',style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),),),
                         PopupMenuItem(
                          value: 'English',
                          child: Text('English',style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)),),
                      ],
                    )
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Center(
                          child: Text(
                            LocaleKeys.sign.tr(),
                            style:Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 40.0,fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Text(
                            LocaleKeys.enjoy.tr(),
                            style:const TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          errorColor: Colors.red,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'Email Address',
                          prefixIcon: Icons.email_rounded,
                          validatorString: 'email address must not be empty',
                          borderColor: defaultColor,
                          labelColor: Theme.of(context).textTheme.bodyText1!.color,
                          textColor: Theme.of(context).textTheme.bodyText1!.color,
                          prefixColor: Theme.of(context).textTheme.bodyText1!.color,

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
                          labelText: 'Password',
                          prefixIcon: Icons.lock_outline_rounded,
                          suffixOnPressed: ()
                          {
                            SocialLoginCubit.get(context).changeEyeIcon();
                          },
                          isPassword: SocialLoginCubit.get(context).isPassword,
                          validatorString: 'password must not be empty',
                          suffixIcon:SocialLoginCubit.get(context).suffix ,
                          suffixColor:!SocialLoginCubit.get(context).isPassword? defaultColor:Theme.of(context).textTheme.bodyText1!.color ,

                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (BuildContext context)
                          {
                              return defaultButton(
                              color:defaultColor,
                              text: 'Sign In',
                              Function: ()
                              {
                                // if(formKey.currentState!.validate())
                                // {
                                //   SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                // }

                              },
                            );
                            },
                          fallback: (BuildContext context)
                          {
                            return const Center(child: CircularProgressIndicator());
                          },

                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Text(
                              'Don\'t have an account ?',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 17.0,fontWeight: FontWeight.w400),
                              //  style: TextStyle(fontSize: 17.0,color: Colors.white),
                            ),
                            defaultTextButton(
                              Function: ()
                              {
                                navigateTo(context, SocialRegisterScreen());
                              },
                              text: 'SignUp Now',
                              color: defaultColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

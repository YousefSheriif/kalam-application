import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/register_cubit/cubit.dart';
import 'package:social_app/modules/register/register_cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/color.dart';


class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
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
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Center(
                        child: Text(
                          'Create Your Account',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                       Center(
                        child: Text(
                          'Enjoy with your friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize:22.0,
                            fontWeight: FontWeight.bold,
                              color: Colors.grey,
                          ),
                        ),
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
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        labelText: 'User Name',
                        prefixIcon: Icons.perm_identity,
                        validatorString: 'Name must not be empty',
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email Address',
                        prefixIcon: Icons.email_outlined,
                        validatorString: 'email address must not be empty',
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
                          SocialRegisterCubit.get(context).changeEyeIcon();
                        },
                        isPassword: SocialRegisterCubit.get(context).isPassword,
                        validatorString: 'password must not be empty',
                        suffixIcon: SocialRegisterCubit.get(context).suffix,
                        suffixColor: !SocialRegisterCubit.get(context).isPassword ? defaultColor : Theme.of(context).textTheme.bodyText1!.color,
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
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        labelText: 'Phone Number',
                        prefixIcon: Icons.phone,
                        validatorString: 'Phone must not be empty',
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState,
                        builder: (BuildContext context) {
                          return defaultButton(
                            color: defaultColor,
                            text: 'Sign Up',
                            textSize: 20,
                            Function: ()
                            {
                              // if (formKey.currentState!.validate()) {
                              //   SocialRegisterCubit.get(context).userRegister(
                              //     name:nameController.text ,
                              //     email: emailController.text,
                              //     password: passwordController.text,
                              //     phone: phoneController.text,
                              //
                              //   );
                              // }
                            },
                          );
                        },
                        fallback: (BuildContext context) {
                          return const Center(child: CircularProgressIndicator(color: defaultColor,));
                        },
                      ),
                    ],
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

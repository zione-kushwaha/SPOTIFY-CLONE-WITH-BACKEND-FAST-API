import 'package:day6/core/themes/app_pallete.dart';
import 'package:day6/core/widget/loader.dart';
import 'package:day6/core/widget/utils.dart';
import 'package:day6/features/auth/repositories/auth_remote_repository.dart';
import 'package:day6/features/auth/view/widgets/auth_gradient.dart';
import 'package:day6/features/auth/view/widgets/custom_field.dart';
import 'package:day6/features/auth/view_model/auth_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fpdart;

import 'login_page.dart';

class SignupPage extends ConsumerStatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider)?.isLoading == true;

    ref.listen(authViewmodelProvider, (_, next) {
      next?.when(
          data: (data) {
            showSnackbar(context, 'User Created successfully');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          error: (e, s) {
            showSnackbar(context, e.toString());
          },
          loading: () {});
    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sign Up .',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      CustomField(
                        controller: nameController,
                        name: 'Name',
                      ),
                      SizedBox(height: 20),
                      CustomField(
                        controller: emailController,
                        name: 'Email',
                      ),
                      SizedBox(height: 20),
                      CustomField(
                        controller: passwordController,
                        isObscure: true,
                        name: 'Password',
                      ),
                      SizedBox(height: 20),
                      AuthGradient(
                          name: 'Signup',
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              await ref
                                  .read(authViewmodelProvider.notifier)
                                  .signupUser(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                            }
                          }),
                      SizedBox(height: 20),
                      RichText(
                          text: TextSpan(
                        text: 'Already have an account?  ',
                        style: TextStyle(
                            color: Pallete.whiteColor,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(color: Pallete.gradient2),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

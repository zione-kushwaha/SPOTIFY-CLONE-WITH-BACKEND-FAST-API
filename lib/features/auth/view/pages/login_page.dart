import 'package:day6/core/themes/app_pallete.dart';
import 'package:day6/core/widget/loader.dart';
import 'package:day6/core/widget/utils.dart';
import 'package:day6/features/auth/view/widgets/auth_gradient.dart';
import 'package:day6/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fpdart;

import '../../repositories/auth_remote_repository.dart';
import '../../view_model/auth_viewModel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formkey.currentState!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewmodelProvider)?.isLoading == true;

    ref.listen(authViewmodelProvider, (_, next) {
      next?.when(
          data: (data) {
            showSnackbar(context, 'User Login successfully');
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          error: (e, s) {
            showSnackbar(context, e.toString());
          },
          loading: () {});
    });

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Loader()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sign In .',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold)),
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
                        name: 'Login',
                        onPressed: () async {
                          final res = await AuthRemoteRepository().loginUser(
                              emailController.text, passwordController.text);

                          final val = switch (res) {
                            fpdart.Left(value: final l) => l,
                            fpdart.Right(value: final r) => r
                          };
                          print(val);
                        }),
                    SizedBox(height: 20),
                    RichText(
                        text: TextSpan(
                      text: "Don't have an account?  ",
                      style: TextStyle(
                          color: Pallete.whiteColor,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: 'Signup',
                          style: TextStyle(color: Pallete.gradient2),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
    );
  }
}

import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/features/signup/widget/check_button.dart';
import 'package:book_library/features/signup/widget/sign_field.dart';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();

  bool _validate = false;
  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      appBar: AppBar(
        backgroundColor: AppColors.bg1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.huge),
        child: Column(
          children: [
            const Text(
              "Sign up",
              style: TextStyle(
                  fontSize: AppFontSize.medlarge, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Username",
                style: TextStyle(),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SignField(
                    controller: _userNameController,
                    lable: "Username",
                    lableStyle: TextStyle(color: _validate ? Colors.red : null),
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                        return 'Please enter the username';
                      }
                      setState(() {
                        _validate = false;
                      });
                      return null;
                    },
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  SignField(
                      controller: _userNameController,
                      lable: "Email address",
                      lableStyle:
                          TextStyle(color: _validate ? Colors.red : null),
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            _validate = true;
                          });
                          return 'Please enter the username';
                        }
                        setState(() {
                          _validate = false;
                        });
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  SignField(
                    controller: _userNameController,
                    lable: "Password",
                    lableStyle: TextStyle(color: _validate ? Colors.red : null),
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                        return 'Please enter the username';
                      } else if (value.length <= 8) {
                        setState(() {
                          _validate = true;
                        });
                        return 'Password must be 8 characters or more';
                      }
                      setState(() {
                        _validate = false;
                      });
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            CheckButton(
              title: 'Sign up',
              onTap: () {
                _formKey.currentState?.validate() ?? false;
              },
            )
          ],
        ),
      ),
    );
  }
}

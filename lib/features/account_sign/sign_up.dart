import 'package:book_library/common/src/constants/colors.dart';
import 'package:book_library/common/src/constants/fonts.dart';
import 'package:book_library/common/src/constants/padding.dart';
import 'package:book_library/features/account_sign/widget/check_button.dart';
import 'package:book_library/features/account_sign/widget/sign_field.dart';

import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _validate = false;
  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  var _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            SizedBox(
              height: MediaQuery.of(context).size.height > 750 ? 30 : 10,
            ),
            const CircleAvatar(
              maxRadius: 45,
              child: Text('data'),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height > 750 ? 30 : 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white54,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Username",
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(
                          Icons.mail,
                          color: Colors.white54,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Email address",
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SignField(
                      controller: _emailController,
                      lable: "Email address",
                      lableStyle:
                          TextStyle(color: _validate ? Colors.red : null),
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            _validate = true;
                          });
                          return 'Please enter Email address';
                        }
                        setState(() {
                          _validate = false;
                        });
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock,
                          color: Colors.white54,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SignField(
                    controller: _passwordController,
                    lable: "Password",
                    lableStyle: TextStyle(color: _validate ? Colors.red : null),
                    validator: (value) {
                      if (value!.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                        return 'Please enter the Password';
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
            SizedBox(
              height: MediaQuery.of(context).size.height > 750 ? 50 : 25,
            ),
            CheckButton(
              title: _isLogin ? 'Login' : 'SignUp',
              onTap: () {
                _formKey.currentState?.validate() ?? false;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_isLogin
                    ? 'I already have an account'
                    : 'Create an account'),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    _isLogin ? 'Login' : 'SignUp',
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

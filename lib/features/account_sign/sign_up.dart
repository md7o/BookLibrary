// import 'dart:io';

// import 'package:book_library/common/src/constants/colors.dart';
// import 'package:book_library/common/src/constants/fonts.dart';
// import 'package:book_library/common/src/constants/padding.dart';
// import 'package:book_library/common/src/widgets/user_image_picker.dart';
// import 'package:book_library/features/account_sign/widget/check_button.dart';
// import 'package:book_library/features/account_sign/widget/sign_field.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// final _firebase = FirebaseAuth.instance;

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   final _formKey = GlobalKey<FormState>();

//   bool _showPassword = false;
//   late FocusNode _focusNode;

//   var _isLogin = true;

//   var _entredUsername = '';
//   var _entredEmail = '';
//   var _entredPassword = '';
//   File? _selectedImage;
//   var isAuthenticating = false;

//   void _submit() async {
//     final isValid = _formKey.currentState!.validate();

//     if (!isValid || (!_isLogin && _selectedImage == null)) {
//       return;
//     }

//     _formKey.currentState!.save();
//     try {
//       setState(() {
//         isAuthenticating = true;
//       });
//       if (_isLogin) {
//         final userCredentials = await _firebase.signInWithEmailAndPassword(
//             email: _entredEmail, password: _entredPassword);
//       } else {
//         final userCredentials = await _firebase.createUserWithEmailAndPassword(
//             email: _entredEmail, password: _entredPassword);

//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('user_images')
//             .child('${userCredentials.user!.uid}.jpg');

//         await storageRef.putFile(_selectedImage!);
//         final imageUrl = await storageRef.getDownloadURL();

//         // Generate a unique ID for the new user
//         final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
//         // Add user data to Firestore with the new unique ID
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userCredentials.user!.uid)
//             .set({
//           'uid': currentUserUid,
//           'username': _entredUsername,
//           'email': _entredEmail,
//           'image_url': imageUrl,
//           // Add other user data as needed
//         });
//       }
//     } on FirebaseAuthException catch (error) {
//       if (error.code == 'email-already-in-use') {}
//       ScaffoldMessenger.of(context).clearSnackBars();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(error.message ?? 'The Email or Password is incorrect.'),
//         ),
//       );
//       isAuthenticating = false;
//     } on FirebaseException catch (error) {
//       print('Firebase Exception: $error');
//       // Handle Firestore errors here
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: AppColors.bg1,
//       appBar: AppBar(
//         backgroundColor: AppColors.bg1,
//         centerTitle: true,
//         title: Text(
//           _isLogin ? "Login" : "SignUp",
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: AppPadding.huge),
//             child: Column(
//               children: [
//                 const SizedBox(height: 10),
//                 if (!_isLogin)
//                   UserImagePicker(
//                     onPickImage: (pickerImage) {
//                       _selectedImage = pickerImage;
//                     },
//                   ),
//                 const SizedBox(height: 15),
//                 if (!_isLogin)
//                   const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Username",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: AppFontSize.medium),
//                     ),
//                   ),
//                 const SizedBox(height: 10),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       if (!_isLogin)
//                         SignField(
//                           lable: "Username",
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please enter the username';
//                             }

//                             return null;
//                           },
//                           keyboardType: TextInputType.name,
//                           onSaved: (value) {
//                             _entredUsername = value!;
//                           },
//                           obscureText: false,
//                         ),
//                       const SizedBox(height: 15),
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Email",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: AppFontSize.medium),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SignField(
//                         lable: "Email address",
//                         validator: (value) {
//                           if (value == null ||
//                               value.trim().isEmpty ||
//                               !value.contains('@')) {
//                             return 'Please enter the username';
//                           }

//                           return null;
//                         },
//                         keyboardType: TextInputType.emailAddress,
//                         onSaved: (value) {
//                           _entredEmail = value!;
//                         },
//                         obscureText: false,
//                       ),
//                       const SizedBox(height: 15),
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Password",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: AppFontSize.medium),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       SignField(
//                         lable: "Password",
//                         validator: (value) {
//                           if (value == null || value.trim().length < 6) {
//                             return 'Password must be at least 6 characters long.';
//                           }

//                           return null;
//                         },
//                         onSaved: (value) {
//                           _entredPassword = value!;
//                         },
//                         obscureText: !_showPassword,
//                         suffixIcon: _showPassword
//                             ? const Icon(Icons.visibility_off)
//                             : const Icon(Icons.visibility),
//                         onTap: () {
//                           setState(() {
//                             _showPassword = !_showPassword;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 if (isAuthenticating) const CircularProgressIndicator(),
//                 if (!isAuthenticating)
//                   CheckButton(
//                     title: _isLogin ? "Login" : "SignUp",
//                     onTap: _submit,
//                   ),
//                 if (!isAuthenticating)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(_isLogin
//                           ? 'Create an account'
//                           : 'I already have an account'),
//                       TextButton(
//                         onPressed: () {
//                           setState(
//                             () {
//                               _isLogin = !_isLogin;
//                             },
//                           );
//                         },
//                         style: TextButton.styleFrom(
//                           padding: EdgeInsets.zero,
//                         ),
//                         child: Text(
//                           _isLogin ? "SignUp" : "Login",
//                           style: const TextStyle(
//                             color: Color(0xFFBFBFFF),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17,
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

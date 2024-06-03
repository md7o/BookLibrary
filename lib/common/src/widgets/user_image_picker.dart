// import 'dart:io';

// import 'package:book_library/common/src/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class UserImagePicker extends StatefulWidget {
//   const UserImagePicker({super.key, required this.onPickImage});

//   final void Function(File pickerImage) onPickImage;

//   @override
//   State<UserImagePicker> createState() => _UserImagePickerState();
// }

// class _UserImagePickerState extends State<UserImagePicker> {
//   File? _pickerImageFile;

//   void _pickImage() async {
//     final pickerImage = await ImagePicker().pickImage(
//         source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

//     if (pickerImage == null) {
//       return;
//     }

//     setState(() {
//       _pickerImageFile = File(pickerImage.path);
//     });

//     widget.onPickImage(_pickerImageFile!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           backgroundColor: AppColors.bg2,
//           maxRadius: 40,
//           foregroundImage:
//               _pickerImageFile != null ? FileImage(_pickerImageFile!) : null,
//         ),
//         TextButton.icon(
//           onPressed: _pickImage,
//           icon: const Icon(
//             Icons.image,
//             color: Color(0xFFB7B7FF),
//           ),
//           label: const Text(
//             'Add Image',
//             style: TextStyle(
//               color: Color(0xFFB7B7FF),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

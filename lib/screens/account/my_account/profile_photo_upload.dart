import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/app/constants/colors.dart';
import 'package:recipe_app/app/serivces/add_service.dart';

class ProfilePic extends StatefulWidget {
  final void Function(String) onImageSelected;
  const ProfilePic({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  RecipeService addrecipe = RecipeService();
  String? imageUrl;
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.baseColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(60),
      ),
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 60,
            // Placeholder avatar when no image is selected
            backgroundImage:
                pickedImage != null ? FileImage(pickedImage!) : null,
            child: pickedImage == null && imageUrl == null
                ? const Icon(
                    Icons.person,
                    size: 80,
                    color: AppColor.baseColor,
                  )
                : null,
          ),
          if (pickedImage == null && imageUrl != null)
            const Positioned.fill(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          Positioned(
            bottom: -10,
            right: -10,
            child: IconButton(
              icon: const Icon(
                Icons.camera_alt,
                size: 30.0,
                color: Colors.black,
              ),
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();

                XFile? file = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 1920,
                  imageQuality: 80,
                );

                // Check if image is selected
                if (file == null) return;

                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();

                Reference referenceRoot = FirebaseStorage.instance.ref();
                Reference referenceDirImages = referenceRoot.child('Images');
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                try {
                  await referenceImageToUpload.putFile(File(file.path));
                  String imageUrl =
                      await referenceImageToUpload.getDownloadURL();
                  setState(() {
                    pickedImage = File(file.path);
                    this.imageUrl = imageUrl;
                  });
                  widget.onImageSelected(imageUrl);
                } catch (error) {
                  print('Error uploading image: $error');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

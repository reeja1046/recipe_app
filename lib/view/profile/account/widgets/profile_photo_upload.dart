import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/core/constants/colors.dart';

class ProfilePic extends StatefulWidget {
  final void Function(String) onImageSelected;
  String currentImage;
  ProfilePic(
      {Key? key, required this.onImageSelected, required this.currentImage})
      : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String? imageUrl;
  File? pickedImage;
  bool isSelectingImage = false;

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
            backgroundImage: widget.currentImage.isNotEmpty
                ? NetworkImage(widget.currentImage) // Load image from URL
                : null, // If currentImage is empty, don't set backgroundImage
            child: widget.currentImage.isEmpty
                ? const Icon(
                    Icons.person,
                    size: 80,
                    color: AppColor.baseColor,
                  )
                : null, // If currentImage is not empty, don't set child
          ),
          if (isSelectingImage)
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
                setState(() {
                  isSelectingImage = true;
                });
                ImagePicker imagePicker = ImagePicker();

                XFile? file = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  maxWidth: 1920,
                  imageQuality: 80,
                );
                setState(() {
                  isSelectingImage = false;
                });
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
                    this.imageUrl = imageUrl; // Update imageUrl here
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

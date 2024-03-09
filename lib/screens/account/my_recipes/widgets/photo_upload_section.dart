import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/app/serivces/add_service.dart';

class PhotoUploadSection extends StatefulWidget {
   final void Function(String) onImageSelected;
  const PhotoUploadSection({Key? key,required this.onImageSelected}) : super(key: key);

  @override
  State<PhotoUploadSection> createState() => _PhotoUploadSectionState();
}

class _PhotoUploadSectionState extends State<PhotoUploadSection> {
  RecipeService addrecipe = RecipeService();
  String imageUrl = '';
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Upload Photos',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          IconButton(
            icon: const Icon(
              Icons.photo_library,
              size: 40.0,
              color: Colors.grey,
            ),
            onPressed: () async {
              ImagePicker imagePicker = ImagePicker();

              XFile? file =
                  await imagePicker.pickImage(source: ImageSource.gallery);

              if (file == null) return;

              String uniqueFileName =
                  DateTime.now().millisecondsSinceEpoch.toString();

              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages = referenceRoot.child('images');
              Reference referenceImageToUpload =
                  referenceDirImages.child(uniqueFileName);

              try {
                await referenceImageToUpload.putFile(File(file.path));
                imageUrl = await referenceImageToUpload.getDownloadURL();
                _pickedImage = File(file.path);
               widget.onImageSelected(imageUrl);
                setState(() {});
              } catch (error) {
                print('Error uploading image: $error');
              }
            },
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Click here to upload photos',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16.0),
          _pickedImage != null
              ? Image.file(
                  _pickedImage!,
                  height: 100.0,
                  width: 100.0,
                  fit: BoxFit.cover,
                )
              : Container(),
        ],
      ),
    );
  }
}

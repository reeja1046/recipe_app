import 'package:flutter/material.dart';

class PhotoUploadSection extends StatelessWidget {
  const PhotoUploadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Upload Photos',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          Icon(
            Icons.photo_library,
            size: 40.0,
            color: Colors.grey,
          ),
          SizedBox(height: 8.0),
          Text(
            'Click here to upload photos',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

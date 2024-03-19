import 'package:flutter/material.dart';

Widget accountListTile(text, icon, navigate, context) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: ListTile(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => navigate));
      },
      title: Text(
        text,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
      leading: Icon(icon),
      trailing: IconButton(
        icon: const Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    ),
  );
}
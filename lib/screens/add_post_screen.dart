import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(onPressed: (){}, icon: Icon(Icons.file_upload_outlined, size: 36,)),
    );
  }
}
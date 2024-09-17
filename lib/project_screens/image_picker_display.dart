// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerDisplay extends StatefulWidget {
  static const id = 'image_picker_display';

  @override
  State<ImagePickerDisplay> createState() => _ImagePickerDisplayState();
}

class _ImagePickerDisplayState extends State<ImagePickerDisplay> {

  File? _image;
  ImagePicker? imagePicker;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }


  Future<void> captureImageFromCamera() async{
    XFile? pickedFile = await imagePicker?.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future<void> chooseImageFromGallery() async{
    XFile? pickedFile = await imagePicker?.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Camera')),
        leading: Icon(Icons.keyboard_backspace_sharp),
        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.lightBlue[400],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: 100.0,
                    minWidth: 100.0,
                  ),
                  child: _image!=null
                      ? Image.file(_image!)
                      : Icon(Icons.image, size: 200.0)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        chooseImageFromGallery();
                      },
                      child: Text('Choose'),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        captureImageFromCamera();
                      },
                      child: Text('Capture'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

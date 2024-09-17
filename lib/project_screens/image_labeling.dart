// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kawaii_vision/screens/Welcome/components/styles.dart';

class ImageLabeling extends StatefulWidget {
  static const id = 'image_labeling';

  ImageLabeling({Key? key}) : super(key: key);
  @override
  _ImageLabelingState createState() => _ImageLabelingState();
}

class _ImageLabelingState extends State<ImageLabeling> {
  //TODO declare state(static/live image labeling) toggle
  bool _showImageLabeling = true;

  //TODO declare ImageLabeler for static
  late ImageLabeler imageLabeler1;
  //TODO declare ImageLabeler for live
  late ImageLabeler imageLabeler2;

  // ImagePicker library
  late ImagePicker imagePicker;
  File? _image;
  CameraImage? img;
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isBusy = false;
  String result = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
    //TODO initialize labeler
    imageLabeler1 = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.5));
    //TODO initialize live labeler
    imageLabeler2 = ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.5));
  }


  Future<void> initializeCamera() async {
    // Initialize camera controller
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.high);
    await _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream((image) {
        // isBusy is false means it currently not in use
        if(!isBusy){
          // make it true and set img
          isBusy = true;
          img = image;
          doLiveImageLabeling();
        }
      });
    });
  }


  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      result = '';
      _image = File(pickedFile!.path);
      doImageLabeling();
    });
  }

  _imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      result = '';
      _image = File(pickedFile!.path);
      doImageLabeling();
    });
  }


  //TODO image labeling code here
  doImageLabeling() async {
    if (_image != null) {
      // Convert the image file to InputImage
      final inputImage = InputImage.fromFilePath(_image!.path);
      // Empty after every label
      result = '';

      // Update the UI with the detected labels
      try {
        // Get the labels by processing the image
        List<ImageLabel> labels = await imageLabeler1.processImage(inputImage);

        // Update the result on the UI
        setState(() {
          result = labels.isNotEmpty
              ? labels
                  .map((label) =>
                      '${label.label}: ${(label.confidence * 100).toStringAsFixed(2)}%')
                  .join('\n')
              : 'No labels detected';
        });
      } catch (e) {
        setState(() {
          result = 'Error occurred while labeling: $e';
        });
      }
    }
  }

  //TODO Live image labeling code
  doLiveImageLabeling() async {
    if (img == null) return;
    result = '';
    // Calculate bytesPerRow for the YUV format
    // This is an example calculation. You may need to adjust this based on your camera's image format.
    final bytesPerRow = img!.planes[0].bytesPerRow;

    // Create metadata
    final inputImageMetadata = InputImageMetadata(
      size: Size(img!.width.toDouble(), img!.height.toDouble()),
      rotation: InputImageRotation.rotation0deg,
      format: InputImageFormat.yuv_420_888, // Adjust according to your camera's format
      bytesPerRow: bytesPerRow,
    );

    // Convert the image bytes
    final inputImage = InputImage.fromBytes(
      bytes: img!.planes[0].bytes,
      metadata: inputImageMetadata,
    );


    try {
      List<ImageLabel> labels = await imageLabeler2.processImage(inputImage);

      setState(() {
        result = labels.isNotEmpty
            ? labels
            .map((label) =>
        '${label.label}: ${(label.confidence * 100).toStringAsFixed(2)}%')
            .join('\n')
            : 'No labels detected';
        isBusy = false; // Allow the next frame to be processed
      });
    } catch (e) {
      setState(() {
        result = 'Error occurred while labeling: $e';
        isBusy = false; // Allow the next frame to be processed
      });
    }
  }

  void stopCamera() async {
    if (_controller != null) {
      await _controller!.stopImageStream();
      _controller!.dispose();
      setState(() {
        _controller = null;
        isBusy = false;
        result = 'Camera stopped';
      });
    }
  }

  void toggleCamera() {
    if (_controller == null) {
    } else {
      stopCamera();
    }
  }

  @override
  void dispose() {
    imageLabeler1.close();
    imageLabeler2.close();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              _showImageLabeling ? 'Static Image Labeling' : 'Live Image Labeling',
            style: Styles.navBarTitle,
          )),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.pop(
                  context); // This will take the user back to the previous screen
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.info_outline_rounded,
                size: 30,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Instructions',
                          style: Styles.headerLarge.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        content: SizedBox(
                          width: double
                              .maxFinite, // Ensure the container uses the available width
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _showImageLabeling ?
                                '• Tap the Camera icon to select an image from the gallery.\n'
                                '• Long press the Camera icon to capture an image using the Camera.'
                                :
                                '• Tap the Video icon to start Live Image Labeling.\n',
                                style: Styles.textDefault.copyWith(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Close'),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
          elevation: 10,
          shadowColor: Colors.black,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.lightBlueAccent.shade700, Colors.cyan.shade200],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            toggleCamera();
            setState(() {
              _showImageLabeling = !_showImageLabeling;
            });
          },
          child: Icon(Icons.swap_horizontal_circle),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/imageLabelBackground.jpg'), fit: BoxFit.fill),
          ),
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  // Image Labeling View
                  Visibility(
                    visible: _showImageLabeling,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 60),
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Image.asset(
                                  'assets/images/imageLabelFrame.png',
                                  height: 300,
                                  width: 200,
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  onPressed: _imgFromGallery,
                                  onLongPress: _imgFromCamera,
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.transparent),
                                    elevation: WidgetStateProperty.all(0),
                                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: _image != null
                                        ? Image.file(
                                            _image!,
                                            width: 180,
                                            height: 280,
                                            fit: BoxFit.fill,
                                          )
                                        : SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: Icon(
                                              Icons.camera_alt,
                                              size: 40,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            result,
                            textAlign: TextAlign.center,
                            style: Styles.headerLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Live Image Labeling View
                  Visibility(
                    visible: !_showImageLabeling,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: 400,
                                  width: 360,
                                  child: Image.asset('assets/images/videoLabelFrame.jpg'),
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(Colors.transparent),
                                    elevation: WidgetStateProperty.all(0),
                                    padding: WidgetStateProperty.all(EdgeInsets.zero),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 100),
                                    height: 195,
                                    width: 350,
                                    child: _controller == null
                                        ? SizedBox(
                                            width: 40,
                                            height: 50,
                                            child: Icon(
                                              Icons.videocam,
                                              size: 40,
                                              color: Colors.grey[400],
                                            ),
                                          )
                                        : AspectRatio(
                                            aspectRatio: _controller!.value.aspectRatio,
                                            child: CameraPreview(_controller!),
                                          ),
                                  ),
                                  onPressed: () {
                                    initializeCamera();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: SingleChildScrollView(
                            child: Text(
                              result,
                              style: Styles.headerLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

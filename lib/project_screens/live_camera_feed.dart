// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class LiveCameraFeed extends StatefulWidget {
  static const id = 'live_camera_feed';

  @override
  State<LiveCameraFeed> createState() => _LiveCameraFeedState();
}

class _LiveCameraFeedState extends State<LiveCameraFeed> {
  late CameraController controller;
  List<CameraDescription> _cameras = [];

  @override
  void initState() {
    super.initState();
    _initializeCameras().then((_) {
      if (_cameras.isNotEmpty) {
        controller = CameraController(_cameras[0], ResolutionPreset.max);

        controller.initialize().then((_) {
          if (!mounted) return;
          controller.startImageStream((image) {
            // Handle image frames here
          });
          setState(() {});
        }).catchError((e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                // Handle access errors here
                break;
              default:
                // Handle other errors here
                break;
            }
          }
        });
      }
    });
  }

  Future<void> _initializeCameras() async {
    try {
      _cameras = await availableCameras();
      setState(() {
        // Ensure the UI updates once cameras are initialized
      });
    } catch (e) {
      print("Error initializing cameras: $e");
      setState(() {
        _cameras = [];
      });
    }
  }

  @override
  void dispose() {
    if (controller.value.isInitialized) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cameras.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while initializing
          : controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CameraPreview(controller),
                )
              : Center(
                  child:
                      CircularProgressIndicator()), // Show loading indicator while initializing the controller
    );
  }
}

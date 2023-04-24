import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cgpt/main.dart';

class Camera extends StatelessWidget {
  double speed;
  Camera({required this.speed});
  @override
  Widget build(BuildContext context) {
    return CameraAccess(speed2: speed);
  }
}

class CameraAccess extends StatefulWidget {
  double speed2;
  CameraAccess({required this.speed2});
  @override
  State<StatefulWidget> createState() {
    return new CameraAccessState(speed3: speed2);
  }
}

class CameraAccessState extends State<CameraAccess> {
  double speed3;
  CameraAccessState({required this.speed3});
  File? cameraFile;

  Future<void> selectFromCamera() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      // maxHeight: 50.0,
      // maxWidth: 50.0,
    );

    if (pickedFile != null) {
      setState(() {
        cameraFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (speed3 == 20) {
        selectFromCamera();
      }
    });

    return Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new TextButton(
            child: new Text('Cam'),
            onPressed: selectFromCamera,
          ),
        ],
      ),
    );
  }
}

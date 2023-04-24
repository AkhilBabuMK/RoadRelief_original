import 'dart:async';
import 'package:cgpt/camera/camera.dart';
import 'package:cgpt/location/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speedometer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Speedometer(),
    );
  }
}

class Speedometer extends StatefulWidget {
  @override
  _SpeedometerState createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> {
  //double _speed = 0.0;
  double _speed = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Request location permission
    _checkLocationPermission();

    // Start the timer to update the position periodically
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updatePosition();
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Cancel the timer to stop updating the position
    _timer?.cancel();
  }

  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }
  }

  Future<void> _updatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      //_speed = 20;
      _speed = position.speed ?? 0.0;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text(
          'RoadRelief',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'SPEED : ${_speed.toStringAsFixed(1)} kmph',
              style: TextStyle(fontSize: 32.0),
            ),
          ),
          Location(),
          Camera(
            speed: _speed,
          ),
        ],
      ),
    );
  }
}

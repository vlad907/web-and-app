import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationApp extends StatefulWidget {
  @override
  _LocationAppState createState() => _LocationAppState();
}

class _LocationAppState extends State<LocationApp> {
  String _location = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    _initLocationService();
  }

  Future<void> _initLocationService() async {

    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        _location =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Live Location Tracker'),
        ),
        body: Center(
          child: Text(
            _location,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(LocationApp());
}

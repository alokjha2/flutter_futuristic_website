import 'package:flutter/material.dart';
import 'package:flutter_earth_globe/flutter_earth_globe.dart';
import 'package:flutter_earth_globe/flutter_earth_globe_controller.dart';
import 'package:flutter_earth_globe/globe_coordinates.dart';
import 'package:flutter_earth_globe/point.dart';
import 'package:flutter_earth_globe/point_connection.dart';
import 'package:flutter_earth_globe/point_connection_style.dart';

class GlobeController {
  late FlutterEarthGlobeController _controller;

  GlobeController() {
    _controller = FlutterEarthGlobeController(
      isRotating: true,
      rotationSpeed: 0.05,
      isBackgroundFollowingSphereRotation: true,
      background: Image.asset('assets/images/2k_stars.jpg').image,
      surface: Image.asset('assets/images/2k_earth-night.jpg').image,
    );
  }

  // Adds points and customized connections between them
  void addPointsAndConnections() {
    // Define points
    final points = [
      Point(
        id: '1',
        coordinates: const GlobeCoordinates(51.5072, 0.1276), // London
        label: 'London',
        isLabelVisible: true,
        style: const PointStyle(color: Colors.red, size: 6),
      ),
      Point(
        id: '2',
        coordinates: const GlobeCoordinates(40.7128, -74.0060), // New York
        label: 'New York',
        isLabelVisible: true,
        style: const PointStyle(color: Colors.green, size: 6),
      ),
    ];

    // Add points to the globe
    for (var point in points) {
      _controller.addPoint(point);
    }

    // Create a customized connection
    final connection = PointConnection(
      id: 'london_to_ny',
      start: points[0].coordinates, // London
      end: points[1].coordinates,   // New York
      label: 'Flight Path',
      labelOffset: const Offset(10, 10),
      isLabelVisible: true,
      labelTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
      curveScale: 2.0, // Adjust the curve's arch height
      style: const PointConnectionStyle(
        color: Colors.blue,
      ),
      isMoving: true, // Animate the connection
      onTap: () {
        print('Connection tapped!');
      },
      onHover: () {
        print('Hovering over the connection!');
      },
    );

    // Add the connection with animation
    _controller.addPointConnection(
      connection,
      animateDraw: true, // Enable animation for drawing
      animateDrawDuration: const Duration(seconds: 2),
    );
  }

  // Builds the FlutterEarthGlobe widget
  Widget buildGlobe() {
    return FlutterEarthGlobe(
      controller: _controller,
      radius: 120,
    );
  }
}

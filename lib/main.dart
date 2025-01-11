import 'package:flutter/material.dart';
import 'package:flutter_futuristic_website/components/animations/globe_animation/globe.dart';
// import 'globe_controller.dart';  // Import the globe controller

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GlobeController _globeController;

  @override
  void initState() {
    super.initState();

    // Initialize the globe controller
    _globeController = GlobeController();

    // Add points and connections after the globe initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _globeController.addPointsAndConnections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Customized Connections on Globe'),
        ),
        body: SafeArea(
          child: _globeController.buildGlobe(),
        ),
      ),
    );
  }
}

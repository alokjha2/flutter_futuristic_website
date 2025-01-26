import 'package:flutter/material.dart';
import 'package:flutter_futuristic_website/components/animations/code_snippet/code.dart';
import 'package:flutter_futuristic_website/components/animations/custom_cursor/custom_cursor_with_tool_tip.dart';
// import 'package:flutter_futuristic_website/components/animations/custom_cursor/cursor.dart';
// import 'package:flutter_futuristic_website/components/animations/custom_cursor/custom_cursor.dart';
import 'package:flutter_futuristic_website/components/animations/full_screen_mode/full_screen.dart';
import 'package:flutter_futuristic_website/components/animations/globe_animation/globe.dart';
import 'package:flutter_futuristic_website/components/animations/scroll_progress_animation/scroll.dart';
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

    _globeController = GlobeController();


    WidgetsBinding.instance.addPostFrameCallback((_) {
      _globeController.addPointsAndConnections();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: 
          CustomCursorContainer() 
          ),
          // FullScreenIcon()
          // ScrollProgressIndicator(),
          // CodeSnippetComponent(), 
          //  _globeController.buildGlobe(), 

      ),
    );
  }
}


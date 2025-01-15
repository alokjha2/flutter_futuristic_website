import 'package:flutter/material.dart';

class CustomCursorContainer extends StatefulWidget {
  const CustomCursorContainer({Key? key}) : super(key: key);

  @override
  State<CustomCursorContainer> createState() => _CustomCursorContainerState();
}

class _CustomCursorContainerState extends State<CustomCursorContainer> {
  Offset position = Offset.zero;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none, // Hide the default cursor
      onHover: (event) {
        setState(() {
          position = event.localPosition;
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: Stack(
        children: [
          // Main container
          Container(
            width: 300,
            height: 300,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Move mouse here!',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Custom animated cursor
          if (isHovered)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 5), // Smooth animation
              left: position.dx - 25, // Center horizontally
              top: position.dy - 25,  // Center vertically
              child: Transform.rotate(
                angle: -0.5, // Adjust this value to tilt the image (in radians)
                child: Image.asset(
                  'assets/images/cursor.png', // Use your image here
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          // Custom "You" container (optional)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 5), // Smooth animation
            left: position.dx + 30, // Center horizontally
            top: position.dy + 30,  // Center vertically
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Center(
                child: Text(
                  "You",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomCursorContainer extends StatefulWidget {
  const CustomCursorContainer({Key? key}) : super(key: key);

  @override
  State<CustomCursorContainer> createState() => _CustomCursorContainerState();
}

class _CustomCursorContainerState extends State<CustomCursorContainer> {
  Offset position = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          // Offset the position to center the cursor around the mouse
          position = Offset(
            event.localPosition.dx - 25, // Half of container width
            event.localPosition.dy - 25, // Half of container height
          );
        });
      },
      child: Stack(
        children: [
          // Your main content
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
          // Custom cursor
          Positioned(
            left: position.dx + 50,
            top: position.dy + 30,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(0), // Remove for perfect rectangle
                border: Border.all(color: Colors.white, width: 2), // Optional border
              ),
              child: const Center(
                child: Text(
                  "You",
                  style: TextStyle(
                    fontSize: 4,
                    color: Colors.white,
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
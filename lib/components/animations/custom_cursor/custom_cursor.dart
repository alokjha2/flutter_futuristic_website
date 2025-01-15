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
          position = event.localPosition;
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
          Transform.translate(
            offset: position,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
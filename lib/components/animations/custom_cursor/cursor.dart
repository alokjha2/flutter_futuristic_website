import 'package:flutter/material.dart';

class CustomCursorContainer extends StatelessWidget {
  const CustomCursorContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.wait,  // Try different cursors here
        child: Container(
          width: 300,
          height: 300,
          color: Colors.blue,
          child: const Center(
            child: Text(
              'Hover over me!',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
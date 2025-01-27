import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

// https://21st.dev/aceternity/moving-border/default

class MovingBorderButton extends StatefulWidget {
  final String text;
  final double borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const MovingBorderButton({
    Key? key,
    required this.text,
    this.borderRadius = 28.0, // 1.75rem equivalent
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.blue,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  _MovingBorderButtonState createState() => _MovingBorderButtonState();
}

class _MovingBorderButtonState extends State<MovingBorderButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MovingBorderPainter(
        animation: _controller,
        borderRadius: widget.borderRadius,
        borderColor: widget.borderColor,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.borderRadius,
          vertical: widget.borderRadius / 2,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _MovingBorderPainter extends CustomPainter {
  final Animation<double> animation;
  final double borderRadius;
  final Color borderColor;

  _MovingBorderPainter({
    required this.animation,
    required this.borderRadius,
    required this.borderColor,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // Create an RRect and convert it to a Path
    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );
    final path = Path()..addRRect(rect);

    // Compute path metrics
    final pathMetrics = path.computeMetrics().first;
    final pathLength = pathMetrics.length;

    // Animation progress and trail details
    final progress = animation.value;
    final startingPoint = (progress * pathLength) % pathLength;
    final trailLength = pathLength / 3; // Length of the moving line

    // Draw the fading trail
    for (double i = 0; i < trailLength; i++) {
      final opacity = 1.0 - (i / trailLength);
      paint.color = borderColor.withOpacity(opacity);

      final currentDistance = (startingPoint + i) % pathLength;
      final tangent = pathMetrics.getTangentForOffset(currentDistance);

      if (tangent != null) {
        canvas.drawPoints(
          PointMode.points,
          [tangent.position],
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_MovingBorderPainter oldDelegate) => true;
}


// Example usage
class MovingBorderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MovingBorderButton(
      text: "Borders are cool",
      borderColor: Colors.blue,
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  }
}
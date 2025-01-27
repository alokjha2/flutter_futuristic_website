// import 'dart:ui';

// import 'package:flutter/material.dart';

// import 'package:flutter/material.dart';

// class ZPathAnimation extends StatefulWidget {
//   final Color lineColor;
//   final double strokeWidth;
//   final Duration duration;

//   const ZPathAnimation({
//     Key? key,
//     this.lineColor = Colors.blue,
//     this.strokeWidth = 2.0,
//     this.duration = const Duration(seconds: 2),
//   }) : super(key: key);

//   @override
//   State<ZPathAnimation> createState() => _ZPathAnimationState();
// }

// class _ZPathAnimationState extends State<ZPathAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: widget.duration,
//     );

//     _animation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(_controller);

//     // Make the animation repeat
//     _controller.repeat();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: ZPathPainter(
//             progress: _animation.value,
//             lineColor: widget.lineColor,
//             strokeWidth: widget.strokeWidth,
//           ),
//           size: const Size(300, 200), // Adjust size as needed
//         );
//       },
//     );
//   }
// }

// class ZPathPainter extends CustomPainter {
//   final double progress;
//   final Color lineColor;
//   final double strokeWidth;

//   ZPathPainter({
//     required this.progress,
//     required this.lineColor,
//     required this.strokeWidth,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = lineColor
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke;

//     final path = Path();
    
//     // Define the Z path points
//     final startPoint = Offset(size.width * 0.2, size.height * 0.2);
//     final topRight = Offset(size.width * 0.8, size.height * 0.2);
//     final bottomLeft = Offset(size.width * 0.2, size.height * 0.8);
//     final endPoint = Offset(size.width * 0.8, size.height * 0.8);

//     // Create the complete path
//     path.moveTo(startPoint.dx, startPoint.dy);
//     path.lineTo(topRight.dx, topRight.dy);
//     path.lineTo(bottomLeft.dx, bottomLeft.dy);
//     path.lineTo(endPoint.dx, endPoint.dy);

//     // Get path metrics
//     final PathMetrics pathMetrics = path.computeMetrics();
//     final PathMetric pathMetric = pathMetrics.first;

//     // Extract the path segment based on progress
//     final Path extractedPath = Path();
//     extractedPath.addPath(
//       path,
//       Offset.zero,
//       matrix4: Matrix4.identity().storage,
//     );

//     // Calculate the length to draw
//     final double length = pathMetric.length * progress;
    
//     // Create a path that contains only the segment we want to draw
//     final Path animatedPath = Path();
//     bool firstPoint = true;
    
//     pathMetrics.forEach((PathMetric metric) {
//       if (length <= 0) return;
      
//       var extractedSegment = metric.extractPath(0, length);
//       if (firstPoint) {
//         animatedPath.addPath(extractedSegment, Offset.zero);
//         firstPoint = false;
//       } else {
//         animatedPath.addPath(extractedSegment, Offset.zero);
//       }
//     });

//     canvas.drawPath(animatedPath, paint);
//   }

//   @override
//   bool shouldRepaint(ZPathPainter oldDelegate) {
//     return oldDelegate.progress != progress ||
//         oldDelegate.lineColor != lineColor ||
//         oldDelegate.strokeWidth != strokeWidth;
//   }
// }

// // Example usage widget
// class AnimationDemo extends StatelessWidget {
//   const AnimationDemo({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: ZPathAnimation(
//           lineColor: Colors.blue,
//           strokeWidth: 30.0,
//           duration: Duration(seconds: 30),
//         ),
//       ),
//     );
//   }
// }
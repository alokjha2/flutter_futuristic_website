import 'package:flutter/material.dart';
import 'dart:math' as math;

class InteractiveWaves extends StatefulWidget {
  final int lineCount;
  final Color lineColor;
  final double frequency;
  final double amplitude;

  const InteractiveWaves({
    Key? key,
    this.lineCount = 60,
    this.lineColor = Colors.black12,
    this.frequency = 0.5,
    this.amplitude = 25.0,
  }) : super(key: key);

  @override
  State<InteractiveWaves> createState() => _InteractiveWavesState();
}

class _InteractiveWavesState extends State<InteractiveWaves>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset? _mousePosition;
  final List<double> _wavePhases = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Initialize wave phases
    for (int i = 0; i < widget.lineCount; i++) {
      _wavePhases.add(0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateWavePhases(Offset? position, Size size) {
    if (position == null) return;

    for (int i = 0; i < widget.lineCount; i++) {
      double normalizedY = i / widget.lineCount;
      double distanceFromMouse =
          (normalizedY - (position.dy / size.height)).abs();
      double influence = math.exp(-distanceFromMouse * 5);
      _wavePhases[i] = influence * widget.amplitude * 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.localPosition;
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: WavesPainter(
              lineCount: widget.lineCount,
              lineColor: widget.lineColor,
              frequency: widget.frequency,
              amplitude: widget.amplitude,
              time: _controller.value,
              mousePosition: _mousePosition,
              wavePhases: _wavePhases,
            ),
            size: const Size(double.infinity, double.infinity),
          );
        },
      ),
    );
  }
}

class WavesPainter extends CustomPainter {
  final int lineCount;
  final Color lineColor;
  final double frequency;
  final double amplitude;
  final double time;
  final Offset? mousePosition;
  final List<double> wavePhases;

  WavesPainter({
    required this.lineCount,
    required this.lineColor,
    required this.frequency,
    required this.amplitude,
    required this.time,
    required this.mousePosition,
    required this.wavePhases,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < lineCount; i++) {
      final path = Path();
      double normalizedY = i / lineCount;
      double yPos = normalizedY * size.height;
      
      path.moveTo(0, yPos);
      
      for (double x = 0; x < size.width; x++) {
        double normalizedX = x / size.width;
        double phase = wavePhases[i];
        
        // Calculate wave effect
        double baseWave = math.sin(normalizedX * math.pi * frequency + time * 2 * math.pi);
        double mouseWave = 0.0;
        
        if (mousePosition != null) {
          double distanceFromMouse = ((x - mousePosition!.dx) / size.width).abs();
          mouseWave = math.exp(-distanceFromMouse * 10) * phase;
        }
        
        double y = yPos + baseWave * amplitude + mouseWave;
        path.lineTo(x, y);
      }
      
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(WavesPainter oldDelegate) {
    return oldDelegate.time != time ||
        oldDelegate.mousePosition != mousePosition;
  }
}

// Example usage
class WavesDemo extends StatelessWidget {
  const WavesDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Interactive Waves',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Move your mouse to interact with the waves',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 400,
              child: InteractiveWaves(),
            ),
          ],
        ),
      ),
    );
  }
}
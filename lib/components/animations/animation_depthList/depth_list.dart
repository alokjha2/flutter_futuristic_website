// https://21st.dev/DavidHDev/tilted-scroll/default

import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedDepthList extends StatefulWidget {
  final List<String> items;
  final Duration duration;
  final double itemHeight;
  final double itemSpacing;
  final double rotationAngle;

  const AnimatedDepthList({
    Key? key,
    required this.items,
    this.duration = const Duration(seconds: 20),
    this.itemHeight = 60.0,
    this.itemSpacing = 20.0,
    this.rotationAngle = -0.2,
  }) : super(key: key);

  @override
  State<AnimatedDepthList> createState() => _AnimatedDepthListState();
}

class _AnimatedDepthListState extends State<AnimatedDepthList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ClipRect(
          child: Container(
            height: widget.itemHeight * 3, // Show 3 items at a time
            child: Stack(
              children: List.generate(widget.items.length, (index) {
                // Calculate the animated position
                double progress = _controller.value;
                double totalHeight = widget.itemHeight * widget.items.length;
                double position = (index * widget.itemHeight - progress * totalHeight) % totalHeight;
                
                // Calculate opacity and scale based on position
                double normalizedPosition = position / totalHeight;
                double opacity = math.sin(normalizedPosition * math.pi);
                double scale = 0.8 + (0.2 * opacity);
                
                // Calculate Z translation for depth effect
                double zTranslation = 100 * (1 - opacity);

                return Positioned(
                  top: position,
                  left: 0,
                  right: 0,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001) // perspective
                      ..rotateX(widget.rotationAngle * opacity)
                      ..translate(0.0, 0.0, zTranslation),
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: opacity.clamp(0.0, 1.0),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          height: widget.itemHeight,
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: widget.itemSpacing / 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5 * opacity),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  widget.items[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

// Example usage
class DepthListDemo extends StatelessWidget {
  const DepthListDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Feature One',
      'Feature Two',
      'Feature Three',
      'Feature Four',
      'Feature Five',
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          height: 400,
          width: 400,
          child: Center(
            child: AnimatedDepthList(
              items: items,
              itemHeight: 60,
              itemSpacing: 20,
              duration: const Duration(seconds: 20),
            ),
          ),
        ),
      ),
    );
  }
}
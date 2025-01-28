import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MeteorEffect extends StatefulWidget {
  final int numberOfMeteors;
  
  const MeteorEffect({
    Key? key,
    this.numberOfMeteors = 20,
  }) : super(key: key);

  @override
  State<MeteorEffect> createState() => _MeteorEffectState();
}

class _MeteorEffectState extends State<MeteorEffect> {
  late List<Meteor> meteors;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    meteors = List.generate(
      widget.numberOfMeteors,
      (index) => _createMeteor(),
    );
    _startMeteorAnimation();
  }

  Meteor _createMeteor() {
    return Meteor(
      left: random.nextDouble() * 400,
      top: random.nextDouble() * -100,
      size: random.nextDouble() * 2 + 1,
      speed: random.nextDouble() * 2 + 1,
    );
  }

  void _startMeteorAnimation() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        for (var i = 0; i < meteors.length; i++) {
          meteors[i].top += meteors[i].speed;
          meteors[i].left -= meteors[i].speed;

          if (meteors[i].top > MediaQuery.of(context).size.height ||
              meteors[i].left < -20) {
            meteors[i] = _createMeteor();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...meteors.map((meteor) {
          return Positioned(
            left: meteor.left,
            top: meteor.top,
            child: Transform.rotate(
              angle: -pi / 4,
              child: Container(
                width: meteor.size,
                height: 20,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.8),
                      Colors.white.withOpacity(0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class Meteor {
  double left;
  double top;
  final double size;
  final double speed;

  Meteor({
    required this.left,
    required this.top,
    required this.size,
    required this.speed,
  });
}

class MeteorCard extends StatelessWidget {
  const MeteorCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320,
        height: 360,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            // Background gradient blur
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue[500]!.withOpacity(0.2),
                      Colors.teal[500]!.withOpacity(0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey[500]!,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_outward,
                      size: 12,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Meteors because they're cool",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "I don't know what to write so I'll just paste something cool here. One more sentence because lorem ipsum is just unacceptable. Won't ChatGPT the shit out of this.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[500]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Explore',
                      style: TextStyle(color: Colors.grey[300]),
                    ),
                  ),
                ],
              ),
            ),
            // Meteor effect overlay
            const MeteorEffect(),
          ],
        ),
      ),
    );
  }
}
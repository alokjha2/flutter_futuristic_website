import 'package:flutter/material.dart';
import 'dart:math' as math;

// https://21st.dev/danielpetho/gravity/default

class FallingComponent extends StatefulWidget {
  final String text;
  final Color color;

  const FallingComponent({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  _FallingComponentState createState() => _FallingComponentState();
}

class _FallingComponentState extends State<FallingComponent> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;
  Offset _position = Offset.zero;
  Offset? _dragPosition;
  bool _isAnimationInitialized = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize only the controller in initState
    _controller = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    if (!_isAnimationInitialized) {

      _animation = Tween<double>(
        begin: 100.0,
        end: MediaQuery.of(context).size.height - 100,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceOut,
      ));

      // Start the falling animation after a brief delay
      Future.delayed(Duration(milliseconds: math.Random().nextInt(500)), () {
        if (mounted) {
          _controller.forward();
        }
      });

      _isAnimationInitialized = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_animation == null) return Container();

    return AnimatedBuilder(
      animation: _animation!,
      builder: (context, child) {
        return Positioned(
          left: _dragPosition?.dx ?? math.Random().nextDouble() * (MediaQuery.of(context).size.width - 100),
          top: _dragPosition?.dy ?? _animation!.value,
          child: Draggable(
            feedback: _buildComponent(),
            childWhenDragging: Container(),
            onDragEnd: (details) {
              setState(() {
                _dragPosition = details.offset;
              });
            },
            child: _buildComponent(),
          ),
        );
      },
    );
  }

  Widget _buildComponent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FallingComponentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Stack(
          children: [
            FallingComponent(text: "React", color: Colors.blue),
            FallingComponent(text: "TypeScript", color: Colors.purple),
            FallingComponent(text: "Motion", color: Colors.teal),
            FallingComponent(text: "Matter.js", color: Colors.amber),
            FallingComponent(text: "Tailwind", color: Colors.red),
            FallingComponent(text: "Drei", color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
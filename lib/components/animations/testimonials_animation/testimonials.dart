import 'package:flutter/material.dart';
import 'dart:async';

// https://21st.dev/aceternity/animated-testimonials/default

// add text animation like animated kit one 

// Data model for testimonials
class Testimonial {
  final String quote;
  final String name;
  final String designation;
  final String imagePath;

  Testimonial({
    required this.quote,
    required this.name,
    required this.designation,
    required this.imagePath,
  });
}

class AnimatedTestimonials extends StatefulWidget {
  final List<Testimonial> testimonials;
  final Duration switchDuration;
  final Duration animationDuration;

  const AnimatedTestimonials({
    Key? key,
    required this.testimonials,
    this.switchDuration = const Duration(seconds: 5),
    this.animationDuration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _AnimatedTestimonialsState createState() => _AnimatedTestimonialsState();
}

class _AnimatedTestimonialsState extends State<AnimatedTestimonials> {
  late Timer _timer;
  int _currentIndex = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.switchDuration, (timer) {
      _nextTestimonial();
    });
  }

  void _nextTestimonial() {
    if (!mounted || _isAnimating) return;
    
    setState(() {
      _isAnimating = true;
      _currentIndex = (_currentIndex + 1) % widget.testimonials.length;
    });

    Future.delayed(widget.animationDuration, () {
      if (mounted) {
        setState(() {
          _isAnimating = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 400,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            // Testimonial Card
            AnimatedSwitcher(
              duration: widget.animationDuration,
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _buildTestimonialCard(
                widget.testimonials[_currentIndex],
                key: ValueKey<int>(_currentIndex),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Pagination Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.testimonials.length,
                (index) => _buildPaginationDot(index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(Testimonial testimonial, {Key? key}) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Quote
          Text(
            testimonial.quote,
            style: const TextStyle(
              fontSize: 18,
              height: 1.6,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 24),
          
          // Profile Image
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(testimonial.imagePath),
          ),
          
          const SizedBox(height: 16),
          
          // Name
          Text(
            testimonial.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          
          const SizedBox(height: 4),
          
          // Designation
          Text(
            testimonial.designation,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 8,
        width: _currentIndex == index ? 24 : 8,
        decoration: BoxDecoration(
          color: _currentIndex == index
              ? Theme.of(context).primaryColor
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

// Example usage
class TestimonialsDemo extends StatelessWidget {
  final List<Testimonial> testimonials = [
    Testimonial(
      quote: "The attention to detail and innovative features have completely transformed our workflow. This is exactly what we've been looking for.",
      name: "Sarah Chen",
      designation: "Product Manager at TechFlow",
      imagePath: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=3560&auto=format&fit=crop",
    ),
    Testimonial(
      quote: "Implementation was seamless and the results exceeded our expectations. The platform's flexibility is remarkable.",
      name: "Michael Rodriguez",
      designation: "CTO at InnovateSphere",
      imagePath: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=3540&auto=format&fit=crop",
    ),
    // Add other testimonials here...
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedTestimonials(testimonials: testimonials);
  }
}
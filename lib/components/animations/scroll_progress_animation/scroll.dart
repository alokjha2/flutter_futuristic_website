import 'package:flutter/material.dart';

class ScrollProgressIndicator extends StatefulWidget {
  @override
  _ScrollProgressIndicatorState createState() => _ScrollProgressIndicatorState();
}

class _ScrollProgressIndicatorState extends State<ScrollProgressIndicator> {
  final ScrollController _scrollController = ScrollController();
  double _scrollProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateScrollProgress);
  }

  void _updateScrollProgress() {
    if (_scrollController.hasClients) {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScrollOffset = _scrollController.offset;
      final progress = (currentScrollOffset / maxScrollExtent).clamp(0.0, 1.0);
      setState(() {
        _scrollProgress = progress;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateScrollProgress);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scroll Progress Indicator")),
      body: Column(
        children: [
          // Progress Indicator
          LinearProgressIndicator(value: _scrollProgress),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 50,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Item $index"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

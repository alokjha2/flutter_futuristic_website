import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:html' as html;

class FullScreenIcon extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.fullscreen),
      onPressed: () {
        _enterFullScreen();
      },
    );
  }

  void _enterFullScreen() {
    final html.Document document = html.window.document;

    if (document.documentElement != null) {
      document.documentElement?.requestFullscreen();
    }
  }
}

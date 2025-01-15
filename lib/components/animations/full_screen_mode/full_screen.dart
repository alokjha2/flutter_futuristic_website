import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:html/parser.dart';

class FullScreenIcon extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // Listen for the "Esc" key to exit full-screen mode
    useEffect(() {
      html.window.onKeyDown.listen((event) {
        if (event.keyCode == 27) {  // Escape key
          _exitFullScreen();
        }
      });
      return () {};
    }, []);

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

  void _exitFullScreen() {
    if (html.document.fullscreenElement != null) {
      html.document.exitFullscreen();
    }
  }
}

import 'package:flutter/material.dart';

class KeyboardKey extends StatefulWidget {
  final String keyLabel;
  final double width;
  final double height;
  final VoidCallback? onPressed;

  const KeyboardKey({
    Key? key,
    required this.keyLabel,
    this.width = 50,
    this.height = 50,
    this.onPressed,
  }) : super(key: key);

  @override
  State<KeyboardKey> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),
        onTap: widget.onPressed,
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isPressed
                ? Colors.grey[800]
                : isHovered
                    ? Colors.grey[900]
                    : Colors.black,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey[800]!,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: isPressed ? const Offset(0, 1) : const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.keyLabel,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MacKeyboard extends StatelessWidget {
  const MacKeyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Function key row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KeyboardKey(keyLabel: 'esc'),
              ...List.generate(12, (index) => KeyboardKey(keyLabel: 'F${index + 1}')),
            ],
          ),
          // Number row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KeyboardKey(keyLabel: '`'),
              ...List.generate(10, (index) => KeyboardKey(keyLabel: '${(index + 1) % 10}')),
              KeyboardKey(keyLabel: '-'),
              KeyboardKey(keyLabel: '='),
              KeyboardKey(keyLabel: 'delete', width: 80),
            ],
          ),
          // QWERTY row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KeyboardKey(keyLabel: 'tab', width: 80),
              ...['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', '[', ']', '\\']
                  .map((key) => KeyboardKey(keyLabel: key))
                  .toList(),
            ],
          ),
          // Home row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KeyboardKey(keyLabel: 'caps lock', width: 90),
              ...['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ';', '\'']
                  .map((key) => KeyboardKey(keyLabel: key))
                  .toList(),
              KeyboardKey(keyLabel: 'return', width: 90),
            ],
          ),
          // Shift row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KeyboardKey(keyLabel: 'shift', width: 110),
              ...['Z', 'X', 'C', 'V', 'B', 'N', 'M', ',', '.', '/']
                  .map((key) => KeyboardKey(keyLabel: key))
                  .toList(),
              KeyboardKey(keyLabel: 'shift', width: 110),
            ],
          ),
          // Bottom row
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              KeyboardKey(keyLabel: 'fn', width: 50),
              KeyboardKey(keyLabel: 'control', width: 65),
              KeyboardKey(keyLabel: 'option', width: 65),
              KeyboardKey(keyLabel: 'command', width: 75),
              KeyboardKey(keyLabel: ' ', width: 250),
              KeyboardKey(keyLabel: 'command', width: 75),
              KeyboardKey(keyLabel: 'option', width: 65),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KeyboardKey(keyLabel: '←', width: 50),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      KeyboardKey(keyLabel: '↑', width: 50, height: 25),
                      KeyboardKey(keyLabel: '↓', width: 50, height: 25),
                    ],
                  ),
                  KeyboardKey(keyLabel: '→', width: 50),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
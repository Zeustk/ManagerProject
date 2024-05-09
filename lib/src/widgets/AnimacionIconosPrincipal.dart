import 'package:flutter/material.dart';

class BlinkingIcon extends StatefulWidget {
  final IconData iconData;
  final Color color;

  BlinkingIcon({required this.iconData, required this.color});

  @override
  _BlinkingIconState createState() => _BlinkingIconState();
}

class _BlinkingIconState extends State<BlinkingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );
    _controller.repeat(
        period: Duration(milliseconds: 4000)); // Repetir la animación
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Icon(
            widget.iconData,
            color: widget.color,
            size: 35,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

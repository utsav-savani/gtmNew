import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class OnHoverButton extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  const OnHoverButton({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<OnHoverButton> createState() => _OnHoverButtonState();
}

class _OnHoverButtonState extends State<OnHoverButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity();
    final transform = isHovered ? hoveredTransform : Matrix4.identity();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => onEntered(true),
      onExit: (event) => onEntered(false),
      child: AnimatedContainer(
        curve: Sprung.overDamped,
        duration: const Duration(milliseconds: 200),
        transform: transform,
        child: widget.builder(isHovered),
      ),
    );
  }

  onEntered(bool isHovered) => setState(() {
        this.isHovered = isHovered;
      });
}

import 'package:flutter/material.dart';

/// Entrance animation widget that fades and slides its child upward smoothly.
class AnimateInEffect extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset;

  const AnimateInEffect({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.offset = 50.0,
  });

  @override
  State<AnimateInEffect> createState() => _AnimateInEffectState();
}

class _AnimateInEffectState extends State<AnimateInEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: Offset(0, widget.offset),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
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
        return Transform.translate(
          offset: _slide.value,
          child: Opacity(
            opacity: _opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class BoucingWidget extends StatefulWidget {
  BoucingWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(microseconds: 300),
    this.onPress,
    this.boucingScale = 1.0,
  }) : super(key: key);
  final Widget child;
  final Duration duration;
  final VoidCallback? onPress;
  final double boucingScale;
  @override
  _BoucingWidgetState createState() => _BoucingWidgetState();
}

class _BoucingWidgetState extends State<BoucingWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late double _scale;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 0.1,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - (_controller.value * widget.boucingScale);
    return GestureDetector(
      onTapUp: _onTapUp,
      onTapDown: _onTapDown,
      onTapCancel: _onTapCanel,
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }

  _onTapDown(TapDownDetails details) {
    _controller.forward();
  }
  _onTapCanel() {
    _controller.reverse();
  }

  _onTapUp(TapUpDetails details) {
    _controller.reverse();
    if (widget.onPress != null) {
      widget.onPress!();
    }
  }
}

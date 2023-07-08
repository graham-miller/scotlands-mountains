import 'package:flutter/material.dart';

class OpenCloseButton extends StatefulWidget {
  final Function onOpen;
  final Function onClose;

  const OpenCloseButton(
      {super.key, required this.onOpen, required this.onClose});

  @override
  State<OpenCloseButton> createState() => _OpenCloseButtonState();
}

class _OpenCloseButtonState extends State<OpenCloseButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: _animation.value == 0,
          child: Opacity(
            opacity: 1 - _animation.value,
            child: FloatingActionButton(
              onPressed: () {
                _controller.reverse();
                widget.onClose();
              },
              child: const Icon(Icons.close),
            ),
          ),
        ),
        Visibility(
          visible: _animation.value == 1,
          child: Opacity(
            opacity: _animation.value,
            child: FloatingActionButton(
              onPressed: () {
                _controller.forward();
                widget.onOpen();
              },
              child: const Icon(Icons.settings),
            ),
          ),
        ),
      ],
    );
  }
}

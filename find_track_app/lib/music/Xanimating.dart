import 'package:flutter/material.dart';

class Animating extends StatefulWidget {
  final double? radius;
  final Color? color;

  const Animating({super.key, required this.radius, required this.color});

  @override
  State<Animating> createState() => _AnimatingState();
}

class _AnimatingState extends State<Animating> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> curve;

  @override
  void initState() {
    super.initState();
    controller =  AnimationController(
      vsync: this, 
      lowerBound: 0.3,
      duration: Duration(milliseconds: 3000)
    );
    curve = CurvedAnimation(
      parent: controller, 
      curve: Curves.fastLinearToSlowEaseIn
    );
    controller.stop();
  }

  @override
  dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: curve,
      builder: (context, child) {
        return Container(
          width: controller.value * widget.radius!,
          height: controller.value * widget.radius!,
          decoration: BoxDecoration(
            color: widget.color!.withOpacity(1 - controller.value), 
            shape: BoxShape.circle
          ),
        );
      },
    );
  }

}
import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({super.key});

  @override
  _AnimatedContainerWidgetState createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  bool _isScaled = false;

  void _toggleScale() {
    setState(() {
      _isScaled = !_isScaled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleScale,
      child: AnimatedContainer(
          width: 102,
          height: 130,
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()..scale(_isScaled ? 1.2 : 1.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: const Border(
                  bottom: BorderSide(color: Colors.white),
                  right: BorderSide(color: Colors.white),
                  left: BorderSide(color: Colors.white),
                  top: BorderSide(color: Colors.white))),
          child: const Column(
            children: [
              Image(image: AssetImage("assets/images/admin.png")),
              Text("Power")
            ],
          )),
    );
  }
}

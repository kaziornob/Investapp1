import 'package:flutter/material.dart';

class AuroRabbitGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          panEnabled: false,
          maxScale: 3.0,
          minScale: 0.5,
          child: Container(
            child: Image.asset("assets/auro_rabbit_big.png"),
          ),
        ),
      ),
    );
  }
}

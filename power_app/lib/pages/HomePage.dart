import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Container(width: 200, height: 200, color: Colors.blue),
              Container(width: 200, height: 200, color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print('home page dispose');
    super.dispose();
  }
}

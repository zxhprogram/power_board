import 'package:flutter/material.dart';

class RadioPage extends StatefulWidget {
  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Container(width: 200, height: 200, color: Colors.grey),
              Container(width: 200, height: 200, color: Colors.lightBlue),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print('radio page dispose');
    super.dispose();
  }
}

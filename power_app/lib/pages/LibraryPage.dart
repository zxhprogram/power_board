import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Container(width: 200, height: 200, color: Colors.yellow),
              Container(width: 200, height: 200, color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print('library page dispose');
    super.dispose();
  }
}

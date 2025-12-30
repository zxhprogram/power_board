import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Container(width: 200, height: 200, color: Colors.pink),
              Container(width: 200, height: 200, color: Colors.cyan),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print('explore page dispose');
    super.dispose();
  }
}

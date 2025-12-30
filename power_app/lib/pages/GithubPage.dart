import 'package:flutter/material.dart';

class GithubPage extends StatefulWidget {
  @override
  State<GithubPage> createState() => _GithubPageState();
}

class _GithubPageState extends State<GithubPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Container(width: 200, height: 200, color: Colors.red),
              Container(width: 200, height: 200, color: Colors.pink),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    print('github page dispose');
    super.dispose();
  }
}

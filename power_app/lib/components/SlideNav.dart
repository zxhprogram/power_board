import 'package:flutter/material.dart' hide NavigationRail;
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SlideNav extends StatefulWidget {
  const SlideNav({super.key, required this.title, required double this.width});

  final String title;
  final double width;

  @override
  State<SlideNav> createState() => _SlideNavState();
}

class _SlideNavState extends State<SlideNav> {
  int selected = 0;

  void _handleIndexChanged(int index) {
    setState(() {
      selected = index;
    });
    switch (selected) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/explore');
        break;
      case 2:
        context.go('/library');
        break;
      case 3:
        context.go('/radio');
        break;
      case 4:
        context.go('/github');
        break;
      default:
        print('no match router');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.width);
    return Builder(
      builder: (context) {
        print(MediaQuery.of(context).size);
        return SizedBox(
          width: widget.width,
          child: OutlinedContainer(
            child: widget.width > 100
                ? WideSlideBar(
                    selected: selected,
                    callback: _handleIndexChanged,
                  )
                : NarrowSlideBar(
                    selected: selected,
                    callback: _handleIndexChanged,
                  ),
          ),
        );
      },
    );
  }
}

NavigationBarItem buildButton(String label, IconData icon) {
  return NavigationItem(label: Text(label), child: Icon(icon));
}

class NarrowSlideBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> callback;

  const NarrowSlideBar({
    super.key,
    required this.selected,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      alignment: .start,
      index: selected,
      onSelected: callback,
      children: [
        buildButton('Home', BootstrapIcons.house),
        buildButton('Explore', BootstrapIcons.compass),
        buildButton('Library', BootstrapIcons.musicNoteList),
        buildButton('Radio', BootstrapIcons.broadcast),
        buildButton('Github', BootstrapIcons.github),
      ],
    );
  }
}

class WideSlideBar extends StatelessWidget {
  final int selected;
  final ValueChanged<int> callback;

  const WideSlideBar({
    super.key,
    required this.selected,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationSidebar(
      index: selected,
      onSelected: callback,
      children: [
        buildButton('Home', BootstrapIcons.house),
        buildButton('Explore', BootstrapIcons.compass),
        buildButton('Library', BootstrapIcons.musicNoteList),
        buildButton('Radio', BootstrapIcons.broadcast),
        buildButton('Github', BootstrapIcons.github),
      ],
    );
  }
}

import 'package:flutter/material.dart' hide NavigationRail;
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
      index: selected,
      onSelected: callback,
      children: [
        buildButton('Home', BootstrapIcons.house),
        buildButton('Explore', BootstrapIcons.compass),
        buildButton('Library', BootstrapIcons.musicNoteList),
        const NavigationDivider(),
        const NavigationLabel(child: Text('Settings')),
        buildButton('Profile', BootstrapIcons.person),
        buildButton('App', BootstrapIcons.appIndicator),
        const NavigationDivider(),
        const NavigationGap(12),
        const NavigationWidget(child: FlutterLogo()),
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
        const NavigationLabel(child: Text('Discovery')),
        buildButton('Listen Now', BootstrapIcons.playCircle),
        buildButton('Browse', BootstrapIcons.grid),
        buildButton('Radio', BootstrapIcons.broadcast),
        const NavigationGap(24),
        const NavigationDivider(),
        const NavigationLabel(child: Text('Library')),
        buildButton('Playlist', BootstrapIcons.musicNoteList),
        buildButton('Songs', BootstrapIcons.musicNote),
        buildButton('For You', BootstrapIcons.person),
        buildButton('Artists', BootstrapIcons.mic),
        buildButton('Albums', BootstrapIcons.record2),
        const NavigationGap(24),
        const NavigationDivider(),
        const NavigationLabel(child: Text('Playlists')),
        buildButton('Recently Added', BootstrapIcons.musicNoteList),
        buildButton('Recently Played', BootstrapIcons.musicNoteList),
        buildButton('Top Songs', BootstrapIcons.musicNoteList),
        buildButton('Top Albums', BootstrapIcons.musicNoteList),
        buildButton('Top Artists', BootstrapIcons.musicNoteList),
        buildButton(
          'Logic Discography With Some Spice',
          BootstrapIcons.musicNoteList,
        ),
        buildButton('Bedtime Beats', BootstrapIcons.musicNoteList),
        buildButton('Feeling Happy', BootstrapIcons.musicNoteList),
        buildButton('I miss Y2K Pop', BootstrapIcons.musicNoteList),
        buildButton('Runtober', BootstrapIcons.musicNoteList),
      ],
    );
  }
}

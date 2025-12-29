import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorSchemes.lightRose, radius: 0),
      home: HomeFrame(),
    );
  }
}

class HomeFrame extends StatefulWidget {
  @override
  State<HomeFrame> createState() => _HomeFrameState();
}

class _HomeFrameState extends State<HomeFrame> {
  double width = 400;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(height: 50, color: Colors.red),
        Expanded(
          child: ResizablePanel.horizontal(
            children: [
              ResizablePane(
                initialSize: width,
                child: SlideNav(title: 'title', width: width),
                onSizeChange: (w) {
                  setState(() {
                    width = w;
                  });
                },
              ),
              ResizablePane(
                initialSize: MediaQuery.of(context).size.width - width,
                child: ContentZone(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContentZone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}

class SlideNav extends StatefulWidget {
  const SlideNav({super.key, required this.title, required double this.width});

  final String title;
  final double width;

  @override
  State<SlideNav> createState() => _SlideNavState();
}

class _SlideNavState extends State<SlideNav> {
  int selected = 0;

  NavigationBarItem buildButton(String label, IconData icon) {
    return NavigationItem(label: Text(label), child: Icon(icon));
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
                ? NavigationSidebar(
                    index: selected,
                    onSelected: (index) {
                      setState(() {
                        selected = index;
                      });
                    },
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
                      buildButton(
                        'Recently Added',
                        BootstrapIcons.musicNoteList,
                      ),
                      buildButton(
                        'Recently Played',
                        BootstrapIcons.musicNoteList,
                      ),
                      buildButton('Top Songs', BootstrapIcons.musicNoteList),
                      buildButton('Top Albums', BootstrapIcons.musicNoteList),
                      buildButton('Top Artists', BootstrapIcons.musicNoteList),
                      buildButton(
                        'Logic Discography With Some Spice',
                        BootstrapIcons.musicNoteList,
                      ),
                      buildButton(
                        'Bedtime Beats',
                        BootstrapIcons.musicNoteList,
                      ),
                      buildButton(
                        'Feeling Happy',
                        BootstrapIcons.musicNoteList,
                      ),
                      buildButton(
                        'I miss Y2K Pop',
                        BootstrapIcons.musicNoteList,
                      ),
                      buildButton('Runtober', BootstrapIcons.musicNoteList),
                    ],
                  )
                : NavigationRail(
                    index: selected,
                    onSelected: (index) {
                      setState(() {
                        selected = index;
                      });
                    },
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
                  ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:power_app/components/SlideNav.dart';
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
      debugShowCheckedModeBanner: false,
      home: HomeFrame(),
    );
  }
}

class HomeFrame extends StatefulWidget {
  @override
  State<HomeFrame> createState() => _HomeFrameState();
}

class _HomeFrameState extends State<HomeFrame> {
  double width = 200;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.white,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/imgs/power-logo.png'),
                    Text(
                      'Power App',
                      style: TextStyle(color: Colors.blue),
                    ).h3.semiBold.italic,
                  ],
                ),
                Row(
                  children: [
                    OutlineButton(
                      onPressed: () {},
                      trailing: const Icon(
                        Icons.search,
                      ).iconSmall().iconMutedForeground(),
                      child: Row(
                        spacing: 16,
                        children: [
                          const Text(
                            'Search documentation...',
                          ).muted().normal(),
                          const KeyboardDisplay.fromActivator(
                            activator: SingleActivator(
                              LogicalKeyboardKey.keyF,
                              control: true,
                            ),
                          ).xSmall.withOpacity(0.8),
                        ],
                      ),
                    ),

                    GhostButton(
                      density: ButtonDensity.icon,
                      onPressed: () {},
                      child: FaIcon(
                        FontAwesomeIcons.github,
                        color: theme.colorScheme.secondaryForeground,
                      ).iconLarge(),
                    ),

                    GhostButton(
                      density: ButtonDensity.icon,
                      onPressed: () {},
                      child: ColorFiltered(
                        // turns into white
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.secondaryForeground,
                          BlendMode.srcIn,
                        ),
                        child: FlutterLogo(size: 24 * theme.scaling),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
    return Container(color: Colors.white);
  }
}

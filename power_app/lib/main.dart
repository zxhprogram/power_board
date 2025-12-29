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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.white,
          height: 50,
          child: Row(
            children: [
              Image.asset('assets/imgs/power-logo.png'),
              Text(
                'Power App',
                style: TextStyle(color: Colors.blue),
              ).h3.semiBold.italic,
            ],
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

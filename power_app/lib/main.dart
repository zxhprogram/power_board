import 'package:go_router/go_router.dart';
import 'package:power_app/components/Heade.dart';
import 'package:power_app/components/SlideNav.dart';
import 'package:power_app/pages/ExplorePage.dart';
import 'package:power_app/pages/GithubPage.dart';
import 'package:power_app/pages/HomePage.dart';
import 'package:power_app/pages/LibraryPage.dart';
import 'package:power_app/pages/RadioPage.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorSchemes.lightRose, radius: 0),
    );
  }
}

class MyObserver extends NavigatorObserver {
  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    print(
      'didChangeTop -> topRoute = $topRoute, previousTopRoute = $previousTopRoute',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didPop -> route = $route, previousTopRoute = $previousRoute');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didPush -> route = $route, previousTopRoute = $previousRoute');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('didRemove -> route = $route, previousTopRoute = $previousRoute');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    print('didReplace -> newRoute = $newRoute, oldRoute = $oldRoute');
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    print(
      'didStartUserGesture -> route = $route, previousRoute = $previousRoute',
    );
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  observers: [MyObserver()],
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeFrame(child: child);
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => HomePage()),
        GoRoute(path: '/explore', builder: (context, state) => ExplorePage()),
        GoRoute(path: '/library', builder: (context, state) => LibraryPage()),
        GoRoute(path: '/radio', builder: (context, state) => RadioPage()),
        GoRoute(path: '/github', builder: (context, state) => GithubPage()),
      ],
    ),
  ],
);

class HomeFrame extends StatefulWidget {
  final Widget child;

  HomeFrame({required this.child});

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
        Header(),
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
                child: widget.child,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kybele_gen2/providers/kybele_providers.dart';
import 'package:kybele_gen2/screens/home.dart';
import 'package:kybele_gen2/screens/record.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:core';


final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  // TODO: Upgrade this to StatefulShellRoute upon GitHub merge of go_router #2650
  initialLocation: '/simulator',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Framework(child: child);
      },
      routes: [
        GoRoute(
          name: 'simulator',
          path: '/simulator',
          builder: (context, state) {
            return const RecordPages();
          }
        ),
        GoRoute(
          name: 'resources',
          path: '/resources',
          builder: (context, state) {
            return HomePage();
          }
        )
      ]
    )
  ],
);


Future<void> main() async {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
            ChangeNotifierProvider<TimerProvider>(create: (_) => TimerProvider()),
            ChangeNotifierProvider<RecordProvider>(create: (_) => RecordProvider()),
        ],
        child: MaterialApp.router(
            title: 'Flutter Demo',
            theme: ThemeData(
              useMaterial3: true,
              textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme),
            ),
            routerConfig: _router,
          ),
        );
  }
}


class NavButton extends StatefulWidget {

  final String label;
  final IconData icon;
  final int index;
  final int selectedIndex;
  final Function(int) onTabClick;
  final bool isSim;

  const NavButton({
    required this.label,
    required this.icon,
    required this.index,
    required this.selectedIndex,
    required this.onTabClick,
    this.isSim = false,
    super.key,
  });

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {

  bool get _isPressed => (widget.index == widget.selectedIndex);

  Widget linearProgressBackground() {

    if (!widget.isSim) {
      return Container();
    }

    return Consumer<TimerProvider>(
          builder: (context, provider, widget) {
            if (_isPressed && !provider.buttonsStart) {
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: const Color(0xff7266d7),
              );
            }

            if (!provider.buttonsStart) {
              return LinearProgressIndicator(
                value: provider.fetchProgressBarPosition(),
                minHeight: double.maxFinite,
                backgroundColor: const Color(0xff7266D7),
                color: const Color(0xff564baf),
              );
            }

            return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Colors.transparent
            );
          }
      );
  }


  Widget iconPlaceholder() {

    final Color _color = Colors.white;
    final IconData _icon = widget.icon;

    if (!widget.isSim && _isPressed) {
      return Icon(_icon, size: 26, color: const Color(0xff7266D7));
    }

    if (!widget.isSim && !_isPressed) {
      return Icon(_icon, size: 26, color: const Color(0xffaaaaaaa));
    }

    return Consumer<TimerProvider>(
            builder: (context, provider, widget) {

              if (_isPressed && !provider.buttonsStart) {
                return Text(
                  "Active",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: _color,
                  ),
                );
              }

              if (_isPressed && provider.buttonsStart) {
                return Icon(_icon, size: 20, color: const Color(0xff564baf));
              }

              if (!_isPressed && provider.buttonsStart) {
                return Icon(_icon, size: 20, color: const Color(0xffaaaaaaa));
              }

              if (provider.milliseconds < 6000000) {
                return Text(
                  provider.fetchTime(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                );
              }

              return Text(
                "Active",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              );
            }
          );
  }

  Widget textPlaceholder() {

    final String label = widget.label;
    final bool isSim = widget.isSim;

    return Consumer<TimerProvider>(
        builder: (context, provider, widget) {

          if (isSim && !provider.buttonsStart) {
            return Text(label, style: const TextStyle(color: Colors.white, fontSize: 12));
          }

          if (_isPressed) {
            return Text(label, style: const TextStyle(color: Color(0xff564baf), fontSize: 12));
          }

          return Text(label, style: TextStyle(color: Color(0xffaaaaaa), fontSize: 12));
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        setState((){
          context.go(tabs[widget.index]);
        });
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.33,
          height: double.maxFinite,
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              linearProgressBackground(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: iconPlaceholder(),
                      ),
                    ),
                    textPlaceholder(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const tabs = [
  '/simulator',
  '/resources',
];

class BottomNavBar2 extends StatefulWidget {
  const BottomNavBar2({Key? key}) : super(key: key);

  @override
  State<BottomNavBar2> createState() => _BottomNavBar2State();
}

class _BottomNavBar2State extends State<BottomNavBar2> {

  int get _selectedIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
    tabs.indexWhere((t) => location.startsWith(t));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  void _onTabClick(BuildContext context, int index) {
    if (index != _selectedIndex) {
      context.go(tabs[index]);
    }
    else if (index == _selectedIndex) {
      context.go(tabs[_selectedIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.fromLTRB(0,10,0,20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xfff1f1f1), width: 1),),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavButton(
            label: 'Simulation',
            icon: Icons.play_arrow_rounded,
            index: 0,
            selectedIndex: _selectedIndex,
            isSim: true,
            onTabClick: (index) => _onTabClick(context, index),
          ),
          NavButton(
            label: 'Resources',
            icon: Icons.home_repair_service_rounded,
            index: 1,
            selectedIndex: _selectedIndex,
            isSim: false,
            onTabClick: (index) => _onTabClick(context, index),
          ),
        ]
      ),
    );
  }
}


class Framework extends StatelessWidget {
  final Widget child;

  const Framework({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7266D7),
      bottomNavigationBar: const BottomNavBar2(),
      body: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kybele_gen2/provider/dbprovider.dart';
import 'package:provider/provider.dart';
import 'package:kybele_gen2/models/event.dart';


class RecordScreen extends StatefulWidget {
  const RecordScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {

  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<DBProvider>(context);

    return SafeArea(child: Column(
          children: [
            Container(
                child: Consumer<DBProvider>(
                  builder: (BuildContext context, provider, widget) {
                    if (provider.events.isEmpty) {
                      return Center(child: Text("DB is empty :("));
                    } else {
                      return Text(provider.events[provider.events.length - 1].toMap().toString());
                    }
                  },
                )
            ),
          ],
        ),
    );


  }
}

class RecordRoutes {
  static const String record_root = "/record/";
}

class RecordRouter extends StatelessWidget {

  static final GlobalKey<NavigatorState> recordKey = GlobalKey();

  Map<String, WidgetBuilder> _recordRouteBuilders(BuildContext context) {
    return {
      RecordRoutes.record_root: (context) => RecordScreen(),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _recordRouteBuilders(context);

    return Navigator(
      key: recordKey,
      initialRoute: RecordRoutes.record_root,

      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context)
        );
      },
    );
  }
}
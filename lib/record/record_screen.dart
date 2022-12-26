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

  Widget tealContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          // teal
          colors: [
            Color(0xff005660),
            Color(0xff007475),
            Color(0xff008081),
            Color(0xff229389),
            Color(0xff34A798),
            Color(0xff57C3AD),
          ],
          // sunset
          // colors: [Color(0xff7d2c4c), Color(0xffac3d63), Color(0xffca4a67), Color(0xffe55a59),],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<DBProvider>(context);

    double side = (MediaQuery.of(context).size.width - 60) / 2;
    double begin = MediaQuery.of(context).size.width / 1.5 - side / 2;

    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  tealContainer(context),
                  Container(color: Colors.grey[200], height: 1500),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: begin,
                    padding: EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/kybele_white.png',
                          height: 40,
                        ),
                        Text(
                          "Record",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<DBProvider>(
                    builder: (BuildContext context, provider, widget) {
                      if (provider.events.isEmpty) {
                        return Center(child: Text("DB is empty :("));
                      } else {
                        return Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Column(
                            children: [
                              for (int i = 0; i < provider.events.length; i++)
                                Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xccbbbbbb),
                                              offset: Offset(0, 3),
                                              blurRadius: 5),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(provider.events[
                                                  provider.events.length -
                                                      1 -
                                                      i]
                                              .toMap()['time']),
                                          Text(
                                              provider.events[
                                                      provider.events.length -
                                                          1 -
                                                          i]
                                                  .toMap()['type'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              )),
                                          Text(
                                            provider.events[
                                                    provider.events.length -
                                                        1 -
                                                        i]
                                                .toMap()['description'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                          if (provider.events[
                                                      provider.events.length -
                                                          1 -
                                                          i]
                                                  .toMap()['type'] ==
                                              'APGAR')
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  provider.events[provider
                                                              .events.length -
                                                          1 -
                                                          i]
                                                      .toMap()['info1'],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                Text(
                                                  provider.events[provider
                                                              .events.length -
                                                          1 -
                                                          i]
                                                      .toMap()['info2'],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                Text(
                                                  provider.events[provider
                                                              .events.length -
                                                          1 -
                                                          i]
                                                      .toMap()['info3'],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                Text(
                                                  provider.events[provider
                                                              .events.length -
                                                          1 -
                                                          i]
                                                      .toMap()['info4'],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                Text(
                                                  provider.events[provider
                                                              .events.length -
                                                          1 -
                                                          i]
                                                      .toMap()['info5'],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                  ],
                                ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
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
            builder: (context) => routeBuilders[routeSettings.name]!(context));
      },
    );
  }
}

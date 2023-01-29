import 'dart:core' show String, bool, double, int, override, print;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:provider/provider.dart' show Consumer, Provider;

import '../providers/record_provider.dart';


NumberFormat timeFormat = NumberFormat("00");

class StandardEntry extends StatelessWidget {

  final Color boxBkgColor;
  final Color boxInfoColor;
  final IconData boxIcon;
  final String header;
  final String subHeader;
  final String interval;
  final String time;

  const StandardEntry(
      this.boxBkgColor,
      this.boxInfoColor,
      this.boxIcon,
      this.header,
      this.subHeader,
      this.interval,
      this.time,
      {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: boxBkgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(boxIcon, size: 30, color: boxInfoColor),
                    Text(interval, style: TextStyle(fontWeight: FontWeight.bold, color: boxInfoColor)),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(header, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(subHeader, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
          Text(time, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class TimerEntry extends StatelessWidget {

  final Color boxBkgColor;
  final Color boxInfoColor;
  final IconData boxIcon;
  final String header;
  final String time;
  final bool isMenuEntry;

  const TimerEntry(
      this.boxBkgColor,
      this.boxInfoColor,
      this.boxIcon,
      this.header,
      this.time,
      this.isMenuEntry,
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 50,
      padding: isMenuEntry ? const EdgeInsets.fromLTRB(0,0,20,0) : const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
        color: boxBkgColor,
        borderRadius: isMenuEntry ? const BorderRadius.all(Radius.circular(10)) : const BorderRadius.all(Radius.circular(0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 80, child: Icon(boxIcon, size: 30, color: boxInfoColor)),
              const SizedBox(width: 15),
              Text(header, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: boxInfoColor)),
            ],
          ),
          Text(time, style: TextStyle(fontSize: 14, color: boxInfoColor)),
        ],
      ),
    );
  }
}

class TimelineEntryWrapper extends StatelessWidget {

  final int index;
  final String prevDate;
  final String category;
  final String header;
  final String subHeader;
  final String interval;
  final String date;
  final String time;
  final String primaryKey;

  const TimelineEntryWrapper(
      this.index,
      this.prevDate,
      this.category,
      this.header,
      this.subHeader,
      this.interval,
      this.date,
      this.time,
      this.primaryKey,
      {super.key}
      );

  Widget entryWrapper(BuildContext context, Widget entry, Widget menuEntry, String primaryKey, bool newDate, bool padTimeline) {
    final recordProvider = Provider.of<RecordProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        newDate ? Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Text(date, textAlign: TextAlign.start, style: const TextStyle(fontSize: 18)),
        ) : Container(),
        Dismissible(
            key: Key(primaryKey),
            onDismissed: (DismissDirection direction) {
              recordProvider.removeEvent(primaryKey);
            },
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          menuEntry,
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              recordProvider.removeEvent(primaryKey);
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Text(
                                'Delete event',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(width: 2, color: const Color(0xff9F97E3))
                              ),
                              width: MediaQuery.of(context).size.width - 40,
                              height: 60,
                              child: const Center(
                                child:
                                Text(
                                  'Back',
                                  style: TextStyle(
                                    color: Color(0xff9F97E3),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
              );
            },
            child: Padding(
              padding: padTimeline ? const EdgeInsets.fromLTRB(20, 0, 20, 10) : const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: entry,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool newDate = false;

    print('${primaryKey} ${prevDate} ${date}');
    if ((date != prevDate) || (index == 0)) {
      newDate = true;
    }

    switch(category) {
      case "APGAR": {
        Widget apgarEntry = StandardEntry(
            const Color(0xffFFCDCF),
            const Color(0xff8B3E42),
            Icons.calculate_rounded,
            header,
            subHeader,
            interval,
            time
        );
        return entryWrapper(context, apgarEntry, apgarEntry, primaryKey, newDate, true);
      }

      case "OxygenSaturation": {
        Widget oxygenEntry = StandardEntry(
            const Color(0xffE2EEF9),
            const Color(0xff436B8F),
            Icons.bubble_chart_rounded,
            header,
            subHeader,
            interval,
            time
        );
        return entryWrapper(context, oxygenEntry, oxygenEntry, primaryKey, newDate, true);
      }

      case "Timer": {
        Widget timerEntry = TimerEntry(
          const Color(0xff9F97E3),
          const Color(0xffffffff),
          Icons.timer_rounded,
          header,
          time,
          false,
        );

        Widget timerMenuEntry = TimerEntry(
          const Color(0xff9F97E3),
          const Color(0xffffffff),
          Icons.timer_rounded,
          header,
          time,
          true,
        );

        return entryWrapper(context, timerEntry, timerMenuEntry, primaryKey, newDate, false);
      }

      default: {
        return const Text('Error');
      }
    }
  }
}

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<RecordProvider>(context);

    return Consumer<RecordProvider>(
      builder: (BuildContext context, provider, widget) {
        if (provider.events.isEmpty) {
          provider.getEvents();
        }
        if (provider.events.isEmpty) {
          return const Padding(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Text("No events logged", textAlign: TextAlign.start, style: TextStyle(fontSize: 18)),
          );
        } else {
          return Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Column(
              children: [
                TimelineEntryWrapper(
                    0,
                    provider.events[provider.events.length - 1].toMap()['date'],
                    provider.events[provider.events.length - 1].toMap()['category'],
                    provider.events[provider.events.length - 1].toMap()['header'],
                    provider.events[provider.events.length - 1].toMap()['subHeader'],
                    provider.events[provider.events.length - 1].toMap()['interval'],
                    provider.events[provider.events.length - 1].toMap()['date'],
                    provider.events[provider.events.length - 1].toMap()['time'],
                    provider.events[provider.events.length - 1].toMap()['primaryKey'],
                  ),
                  Column(
                    children: [
                      for (int i = 1; i < provider.events.length; i++)
                        TimelineEntryWrapper(
                          i,
                          provider.events[provider.events.length - 1 - i + 1].toMap()['date'],
                          provider.events[provider.events.length - 1 - i].toMap()['category'],
                          provider.events[provider.events.length - 1 - i].toMap()['header'],
                          provider.events[provider.events.length - 1 - i].toMap()['subHeader'],
                          provider.events[provider.events.length - 1 - i].toMap()['interval'],
                          provider.events[provider.events.length - 1 - i].toMap()['date'],
                          provider.events[provider.events.length - 1 - i].toMap()['time'],
                          provider.events[provider.events.length - 1 - i].toMap()['primaryKey'],
                        ),
                    ],
                  ),
                GestureDetector(
                  onTap: () {
                    recordProvider.removeAllEvents();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 2, color: Colors.red),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 60,
                    child: const Center(
                      child:
                      Text(
                        'Delete all events',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
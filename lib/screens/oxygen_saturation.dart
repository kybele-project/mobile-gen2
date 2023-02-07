import 'package:flutter/material.dart';
import 'package:kybele_gen2/templates/page/page.dart';
import 'package:provider/provider.dart';

class OxygenSaturationProvider with ChangeNotifier {

  final List<int> _minuteIntervalList = [1000, 2000, 3000, 4000, 5000, 10000];
  final List<int> _lowerBound = [60, 65, 70, 75, 80, 85];
  final List<int> _upperBound = [65, 70, 75, 80, 85, 95];

  late int _saturationPercentage = 75;
  late int _minuteInterval = 0;
  late int _status = 1;

  int get saturationPercentage => _saturationPercentage;
  int get minuteInterval => _minuteInterval;
  int get status => _status;

  void setSaturationPercentage(int nextSaturationPercentage) {
    _saturationPercentage = nextSaturationPercentage;
  }

  void setMinuteInterval(int nextMinuteInterval) {
    _minuteInterval = nextMinuteInterval;
  }

  void setStatus(int nextStatus) {
    _status = nextStatus;
  }

  void updateStatus(int milliseconds) {
    int currMinute = (milliseconds/1000).floor();
    late int currIndex;

    if (currMinute >= 10) {
      currIndex = 5;
    }
    else if (currMinute >= 5) {
      currIndex = 4;
    }
    else if (currMinute >= 4) {
      currIndex = 3;
    }
    else if (currMinute >= 3) {
      currIndex = 2;
    }
    else if (currMinute >= 2) {
      currIndex = 1;
    }
    else if (currMinute >= 1) {
      currIndex = 0;
    }
    else {
      setStatus(2);
      return;
    }

    if (_saturationPercentage >= _lowerBound[currIndex] &&
        _saturationPercentage <= _upperBound[currIndex]) {
      setStatus(1);
    }
    else {
      setStatus(0);
    }
  }
}

class OxygenSaturation extends StatefulWidget {
  const OxygenSaturation({Key? key}) : super(key: key);

  @override
  State<OxygenSaturation> createState() => _OxygenSaturationState();
}

class _OxygenSaturationState extends State<OxygenSaturation> {

  late double _currSat;

  @override
  void initState() {
    _currSat = 75;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => OxygenSaturationProvider(),
        child: KybelePage.fixedWithHeader(
            hasHeaderIcon: true,
            headerIconColor: Colors.black,
            headerIconBkgColor: Colors.amberAccent,
            headerIcon: Icons.bakery_dining,
            hasHeaderClose: true,
            hasBottomActionButton: true,
            bottomButtonText: "Log event",
            bottomButtonMenuWidget: const Placeholder(),
            headerText: "Oxygen Saturation",
            bodyWidget: body(context),
        ),
    );
  }

  Widget body(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Consumer<OxygenSaturationProvider>(
              builder: (context, provider, widget) {
                return Text(provider._saturationPercentage.toString());
              }
            ),
            Consumer<OxygenSaturationProvider>(
                builder: (context, provider, widget) {
                  return Slider(
                    value: _currSat,
                    min: 50,
                    max: 100,
                    divisions: 10,
                    label: _currSat.toString() + "%",
                    onChanged: (double value) => provider.setSaturationPercentage(value.toInt()),
                  );
                }
            ),
            
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:kybele_gen2/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class TimerBackgroundLayer extends StatelessWidget {

  const TimerBackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {


    return Consumer<TimerProvider>(
        builder: (context, provider, widget) {
          return LinearProgressIndicator(
            value: provider.fetchProgressBarPosition(),
            minHeight: MediaQuery.of(context).size.height,
            backgroundColor: const Color(0xff7266D7),
            color: const Color(0xff564BAF),
          );
        }
    );
  }
}
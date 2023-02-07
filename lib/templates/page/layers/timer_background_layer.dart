import 'package:flutter/material.dart';
import 'package:kybele_gen2/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class TimerBackgroundLayer extends StatelessWidget {

  final bool isDraggable;

  const TimerBackgroundLayer({
    required this.isDraggable,
    super.key
  });

  @override
  Widget build(BuildContext context) {


    return isDraggable ? Consumer<TimerProvider>(
        builder: (context, provider, widget) {
          return LinearProgressIndicator(
            value: provider.fetchProgressBarPosition(),
            minHeight: MediaQuery.of(context).size.height,
            backgroundColor: const Color(0xff7266D7),
            color: const Color(0xff564BAF),
          );
        }
    ) : Container(width: double.maxFinite, height: double.maxFinite, color: Colors.white);
  }
}
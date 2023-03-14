import 'package:flutter/material.dart';
import 'package:kybele_gen2/providers/timer_provider.dart';
import 'package:provider/provider.dart';

import '../../../style/colors.dart';

class TimerBackgroundLayer extends StatelessWidget {
  final bool isDraggable;
  final Orientation orientation;

  const TimerBackgroundLayer(
      {required this.isDraggable, required this.orientation, super.key});

  @override
  Widget build(BuildContext context) {
    bool orientationPortrait = (orientation == Orientation.portrait);
    return isDraggable
        ? Consumer<TimerProvider>(builder: (context, provider, widget) {
            return LinearProgressIndicator(
              value: provider.fetchProgressBarPosition(),
              minHeight: orientationPortrait
                  ? MediaQuery.of(context).size.height
                  : MediaQuery.of(context).size.height * 0.15,
              backgroundColor: mainMediumPurple,
              color: mainDarkPurple,
            );
          })
        : Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.white);
  }
}

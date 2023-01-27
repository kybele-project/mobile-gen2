import 'package:flutter/material.dart';
import 'package:kybele_gen2/tools/APGAR2.dart';
import 'package:provider/provider.dart';

import 'package:kybele_gen2/log/backend.dart';
import 'dart:core';

import 'package:kybele_gen2/log/button.dart';
import 'package:kybele_gen2/tools/TargetOxygenSaturation.dart';


class StandardPageTemplate extends StatelessWidget {

  final Color boxBkgColor;
  final Color boxInfoColor;
  final IconData boxIcon;
  final bool hasIcon;
  final String header;
  final Widget body;
  final bool hasButton;
  final String buttonLabel;
  final Widget buttonMenu;


  const StandardPageTemplate(
    this.boxBkgColor,
    this.boxInfoColor,
    this.boxIcon,
    this.hasIcon,
    this.header,
    this.body,
    this.hasButton,
    this.buttonLabel,
    this.buttonMenu,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerProvider>(create: (_) => TimerProvider()),
        ChangeNotifierProvider<RecordProvider>(create: (_) => RecordProvider()),
      ],
      child: Material(
        child: Stack(
            children: [
              const TimerBackgroundLayer(),
              ContentLayer(boxBkgColor, boxInfoColor, boxIcon, hasIcon, header, body),
              hasButton ? ActionButtonLayer(buttonLabel, buttonMenu) : Container(),
            ],
          ),
        ),
    );
  }
}


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


class ActionButtonLayer extends StatelessWidget {

  final String buttonLabel;
  final Widget buttonMenu;


  const ActionButtonLayer(
      this.buttonLabel,
      this.buttonMenu,
      {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const KybeleButtonGradientLayer(),
        Positioned(
          bottom: 10,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return buttonMenu;
                  }
              );
            },
            child: KybeleSolidButton(buttonLabel),
          ),
        ),
      ],
    );
  }
}


class ContentLayer extends StatefulWidget {

  final Color boxBkgColor;
  final Color boxInfoColor;
  final IconData boxIcon;
  final bool hasIcon;
  final String header;
  final Widget body;

  const ContentLayer(
      this.boxBkgColor,
      this.boxInfoColor,
      this.boxIcon,
      this.hasIcon,
      this.header,
      this.body,
      {super.key}
  );

  @override
  State<ContentLayer> createState() => _ContentLayerState();
}

class _ContentLayerState extends State<ContentLayer> with SingleTickerProviderStateMixin {

  // height animation vars
  double lowHeightFactor = 0.15;
  double highHeightFactor = 0.5;

  late bool _animationActive;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    generateAnimation();
    _animationActive = false;
  }

  void generateAnimation() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500)
    );

    _animation = Tween<double>(
      begin: highHeightFactor,
      end: lowHeightFactor,
    ).animate(_controller)
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onTimerDisplayTap() {
    setState(() {
      if (_animationActive) {
        _controller.reverse();
      }
      else {
        _controller.forward();
      }

      _animationActive = !_animationActive;
    });
  }

  handleVerticalUpdate(DragUpdateDetails updateDetails) {
    double screenHeight = MediaQuery.of(context).size.height;
    double fractionDragged = updateDetails.primaryDelta! / screenHeight;
    _controller.value = _controller.value - 5 * fractionDragged;
    if (_controller.value == 0) {
      _animationActive = false;
    }
    else {
      _animationActive = true;
    }
  }

  handleVerticalEnd(DragEndDetails endDetails) {
    if (_controller.value >= 0.5) {
      _controller.forward();
    }
    else {
      _controller.reverse();
    }

  }

  Widget timerInteractionButtons(BuildContext context) {

    double paddingWidth;
    MainAxisAlignment rowAlign;

    if (_animationActive) {
      paddingWidth = 10;
      rowAlign = MainAxisAlignment.end;
    }
    else {
      paddingWidth = 20;
      rowAlign = MainAxisAlignment.center;
    }

    return Consumer<TimerProvider>(
        builder: (context, provider, widget) {
          if (provider.buttonsStart) {
            return RawMaterialButton(
                onPressed: () {
                  provider.startTimer();
                },
                elevation: 0,
                fillColor: const Color(0xff9F97E3),
                padding: EdgeInsets.all(paddingWidth),
                shape: const CircleBorder(),
                child: const Icon(Icons.play_arrow_rounded, size: 30, color: Colors.white)
            );
          }
          else if (provider.buttonsPause) {
            return RawMaterialButton(
                onPressed: () {
                  provider.pauseTimer();
                },
                elevation: 0,
                fillColor: const Color(0xff9F97E3),
                padding: EdgeInsets.all(paddingWidth),
                shape: const CircleBorder(),
                child: const Icon(Icons.pause_rounded, size: 30, color: Colors.white)
            );
          }
          else {
            return Row(
              mainAxisAlignment: rowAlign,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RawMaterialButton(
                    onPressed: () {
                      provider.continueTimer();
                    },
                    elevation: 0,
                    fillColor: const Color(0xff9F97E3),
                    padding: EdgeInsets.all(paddingWidth),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.play_arrow_rounded, size: 30, color: Colors.white)
                ),
                SizedBox(width: paddingWidth),
                RawMaterialButton(
                    onPressed: () {
                      provider.resetTimer();
                    },
                    elevation: 0,
                    fillColor: const Color(0xff9F97E3),
                    padding: EdgeInsets.all(paddingWidth),
                    shape: const CircleBorder(),
                    child: const Icon(Icons.stop_rounded, size: 30, color: Colors.white)
                ),
              ],
            );
          }
        }
    );
  }

  Widget timerDisplay() {
    if (_animationActive) {
      return SafeArea(
          child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.transparent,
          padding: const EdgeInsets.fromLTRB(20,0,0,0),
          child:
    Consumer<TimerProvider>(
    builder: (context, provider, widget) { return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [

    Text(provider.fetchTime(),
    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
    timerInteractionButtons(context),
    ],
    );
    }
    ),
    ),);
    }
    else {
      return SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Colors.transparent,
            child: Center(
              child: Consumer<TimerProvider>(
                builder: (context, provider, widget) {
                  return Column(
                    children: [
                      Text(
                        provider.fetchTime(),
                        style: const TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(provider.fetchMessage(),
                      style: TextStyle(color: Colors.white, fontSize: 30), textAlign: TextAlign.center,),
                      SizedBox(height: 20),
                      timerInteractionButtons(context),
                      /*
                      GestureDetector(
                          onTap: (() {}),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            decoration: const BoxDecoration(
                                color: Color(0xff9F97E3),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: const Text(
                              'View record',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                      ),
                       */
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget contentHeader() {
    return PhysicalModel(
      color: Colors.grey,
      elevation: 1,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * .15,
                  margin: const EdgeInsets.fromLTRB(0, 7.5, 0, 0),
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.all(Radius.circular(2.5))
                  ),
                )
            ),
            Container(
              width: double.maxFinite,
              color: Colors.transparent,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: widget.boxBkgColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(widget.boxIcon, size: 20, color: widget.boxInfoColor),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.header,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        },
                      child: Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget contentDisplay() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        height: double.maxFinite,
        color: Colors.white,
        child: Column(
          children: [
            contentHeader(),
            widget.body,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: onTimerDisplayTap,
          child: FractionallySizedBox(
            alignment: Alignment.topCenter,
            heightFactor: _animation.value,
            child: timerDisplay(),
          ),
        ),
        GestureDetector(
          onVerticalDragUpdate: handleVerticalUpdate,
          onVerticalDragEnd: handleVerticalEnd,
          child: FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 1 - _animation.value,
            child: contentDisplay(),
          ),
        ),
      ],
    );
  }
}

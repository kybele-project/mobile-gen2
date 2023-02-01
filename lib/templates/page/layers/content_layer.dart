import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kybele_gen2/providers/timer_provider.dart';

class ContentLayer extends StatefulWidget {

  // Draggable
  final bool isDraggable;

  // Header Options
  final bool hasHeader;
  final bool hasHeaderIcon;
  final bool hasHeaderClose;
  final IconData? headerIcon;
  final Color? headerIconColor;
  final Color? headerIconBkgColor;
  final String? headerText;

  // Body
  final Widget bodyWidget;

  const ContentLayer({
    required this.isDraggable,
    required this.hasHeader,
    required this.hasHeaderIcon,
    required this.hasHeaderClose,
    required this.headerIcon,
    required this.headerIconColor,
    required this.headerIconBkgColor,
    required this.headerText,
    required this.bodyWidget,
    super.key,
  });

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
      begin: lowHeightFactor,
      end: highHeightFactor,
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

  Widget timerInteractionButtons() {

    if (!widget.isDraggable) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: const Text(
          "VIEW RECORD",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<TimerProvider>(
                builder: (context, provider, widget) {
                  return Text(
                    provider.fetchTime(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }
              ),
              timerInteractionButtons(),
            ],
          ),
        ),
      );
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
                        style: const TextStyle(color: Colors.white, fontSize: 30), textAlign: TextAlign.center,),
                      const SizedBox(height: 20),
                      timerInteractionButtons(),
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
                          color: widget.headerIconBkgColor,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(widget.headerIcon, size: 20, color: widget.headerIconColor),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.headerText!,
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
                    child: const Icon(Icons.close_rounded),
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
            widget.hasHeader ? contentHeader() : Container(),
            widget.bodyWidget,
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

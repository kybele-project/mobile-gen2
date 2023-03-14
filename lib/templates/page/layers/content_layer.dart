import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kybele_gen2/models/event.dart';
import 'package:kybele_gen2/providers/kybele_providers.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:kybele_gen2/components/buttons/buttons.dart';

class ContentLayer extends StatefulWidget {
  // Draggable
  final bool isDraggable;
  final bool startExpanded;

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

  // Height Constraint
  final double heightConstraint;

  const ContentLayer({
    required this.isDraggable,
    required this.startExpanded,
    required this.hasHeader,
    required this.hasHeaderIcon,
    required this.hasHeaderClose,
    required this.headerIcon,
    required this.headerIconColor,
    required this.headerIconBkgColor,
    required this.headerText,
    required this.bodyWidget,
    required this.heightConstraint,
    super.key,
  });

  @override
  State<ContentLayer> createState() => _ContentLayerState();
}

class _ContentLayerState extends State<ContentLayer>
    with SingleTickerProviderStateMixin {
  // height animation vars
  late double startHeightFactor;
  late double endHeightFactor;

  late bool _animationActive;
  late AnimationController _controller;
  late Animation<double> _animation;

  bool get _isDraggable => widget.isDraggable;

  @override
  void initState() {
    super.initState();
    generateAnimation();
  }

  void generateAnimation() {

    double ratio = min(80/widget.heightConstraint, 0.15);

    if (widget.startExpanded) {
      startHeightFactor = 0.5;
      endHeightFactor = ratio;
    } else {
      startHeightFactor = ratio;
      endHeightFactor = 0.5;
    }

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));

    _animation = Tween<double>(
      begin: startHeightFactor,
      end: endHeightFactor,
    ).animate(_controller)
      ..addListener(() => setState(() {}));

    _animationActive = widget.startExpanded ? false : true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  onTimerDisplayTap() {
    if (widget.startExpanded) {
      setState(() {
        if (_animationActive) {
          _controller.reverse();
        } else {
          _controller.forward();
        }

        _animationActive = !_animationActive;
      });
    } else {
      setState(() {
        if (_animationActive) {
          _controller.forward();
        } else {
          _controller.reverse();
        }

        _animationActive = !_animationActive;
      });
    }
  }

  handleVerticalUpdate(DragUpdateDetails updateDetails) {
    if (widget.isDraggable) {
      double screenHeight = MediaQuery.of(context).size.height;
      double fractionDragged = updateDetails.primaryDelta! / screenHeight;

      if (widget.startExpanded) {
        _controller.value = _controller.value - 3 * fractionDragged;
        if (_controller.value <= 0.5) {
          _animationActive = false;
        } else {
          _animationActive = true;
        }
      } else {
        _controller.value = _controller.value + 3 * fractionDragged;
        if (_controller.value > 0.5) {
          _animationActive = false;
        } else {
          _animationActive = true;
        }
      }
    }
  }

  handleVerticalEnd(DragEndDetails endDetails) {
    if (widget.isDraggable) {
      if (_controller.value >= 0.5) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  void startActions() {
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    timerProvider.startTimer();

    final recordProvider = Provider.of<RecordProvider>(context, listen: false);
    Event timerEvent = Event(
      category: "Timer",
      header: "Timer started",
      subHeader: "NA",
      interval: "NA",
      status: 2,
    );
    recordProvider.addEvent(timerEvent);
  }

  void pauseActions() {
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    timerProvider.pauseTimer();

    final recordProvider = Provider.of<RecordProvider>(context, listen: false);
    Event timerEvent = Event(
      category: "Timer",
      header: "Timer paused",
      subHeader: "NA",
      interval: "NA",
      status: 2,
    );
    recordProvider.addEvent(timerEvent);
  }

  void continueActions() {
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    timerProvider.continueTimer();

    final recordProvider = Provider.of<RecordProvider>(context, listen: false);
    Event timerEvent = Event(
      category: "Timer",
      header: "Timer resumed",
      subHeader: "NA",
      interval: "NA",
      status: 2,
    );
    recordProvider.addEvent(timerEvent);
  }

  void resetActions() {
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    timerProvider.resetTimer();

    final recordProvider = Provider.of<RecordProvider>(context, listen: false);
    Event timerEvent = Event(
      category: "Timer",
      header: "Timer stopped",
      subHeader: "NA",
      interval: "NA",
      status: 2,
    );
    recordProvider.addEvent(timerEvent);
  }

  Widget timerInteractionButtons() {

    if (_animationActive) {
      return Consumer<TimerProvider>(builder: (context, provider, widget) {
        if (provider.buttonsStart) {
          return TimerSmallButton(
              actionFunction: startActions,
              iconData: Icons.play_arrow_rounded
          );
        } else if (provider.buttonsPause) {
          return TimerSmallButton(
              actionFunction: pauseActions,
              iconData: Icons.pause_rounded,
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TimerSmallButton(
                actionFunction: continueActions,
                iconData: Icons.play_arrow_rounded
              ),
              const SizedBox(width: 30),
              TimerSmallButton(
                  actionFunction: resetActions,
                  iconData: Icons.stop_rounded
              ),
            ],
          );
        }
      });
    }

    return Consumer<TimerProvider>(builder: (context, provider, widget) {
      if (provider.buttonsStart) {
        return TimerLargeButton(
            actionFunction: startActions,
            iconData: Icons.play_arrow_rounded,
            label: "START"
        );
      } else if (provider.buttonsPause) {
        return TimerLargeButton(
            actionFunction: pauseActions,
            iconData: Icons.pause_rounded,
            label: "PAUSE"
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TimerLargeButton(
                actionFunction: continueActions,
                iconData: Icons.play_arrow_rounded,
                label: "RESUME",
            ),
            TimerLargeButton(
              actionFunction: resetActions,
              iconData: Icons.stop_rounded,
              label: "STOP",
            ),
          ],
        );
      }
    });
  }

  Widget timerDisplay() {
    if (_animationActive) {
      return Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: Colors.transparent,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<TimerProvider>(builder: (context, provider, widget) {
                return Text(
                  provider.fetchTime(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }),
              timerInteractionButtons(),
            ],
          ),
      );
    } else {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          width: double.maxFinite,
          height: (MediaQuery.of(context).size.height - 80) * 0.5,
          color: Colors.transparent,
          child: Consumer<TimerProvider>(
            builder: (context, provider, widget) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    provider.fetchTime(),
                    style: const TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  timerInteractionButtons(),
                ],
              );
            },
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
            widget.isDraggable
                ? Center(
                    child: Container(
                    width: MediaQuery.of(context).size.width * .1,
                    margin: const EdgeInsets.fromLTRB(0, 7.5, 0, 0),
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2.5))),
                  ))
                : Container(),
            Container(
              height: 70,
              width: double.maxFinite,
              color: Colors.transparent,
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(widget.headerIcon,
                                size: 20, color: widget.headerIconColor),
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
                  widget.hasHeaderClose
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close_rounded),
                        )
                      : Container(),
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
      borderRadius: widget.isDraggable
          ? const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )
          : const BorderRadius.all(Radius.circular(0)),
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

    return Consumer<RecordProvider>(
          builder: (context, provider, widget) {
            return Stack(
                    fit: StackFit.expand,
                    children: [
                      _isDraggable
                          ? GestureDetector(
                        onTap: onTimerDisplayTap,
                        child: FractionallySizedBox(
                          alignment: Alignment.topCenter,
                          heightFactor: _animation.value,
                          child: timerDisplay(),
                        ),
                      )
                          : Container(),
                      _isDraggable
                          ? GestureDetector(
                        onVerticalDragUpdate: handleVerticalUpdate,
                        onVerticalDragEnd: handleVerticalEnd,
                        child: FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 1 - _animation.value,
                          child: contentDisplay(),
                        ),
                      )
                          : SafeArea(
                        child: FractionallySizedBox(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 1,
                          child: contentDisplay(),
                        ),
                      ),
                    ],
                  );
                }
              );
  }
}

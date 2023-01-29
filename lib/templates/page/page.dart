import 'package:flutter/material.dart';
import 'package:kybele_gen2/providers/record_provider.dart';
import 'package:kybele_gen2/templates/page/layers/action_button_layer.dart';
import 'package:kybele_gen2/templates/page/layers/content_layer.dart';
import 'package:provider/provider.dart';

import 'dart:core';

import '../../providers/timer_provider.dart';
import 'layers/timer_background_layer.dart';


class KybelePage extends StatelessWidget {

  // Options
  late bool isDraggable;
  late bool hasHeader;
  late bool hasHeaderIcon;
  late bool hasHeaderClose;
  late bool hasBottomActionButton;

  // Content Layer Params
  late IconData? headerIcon;
  late Color? headerIconColor;
  late Color? headerIconBkgColor;
  late String? headerText;
  final Widget bodyWidget;

  // Bottom Layer Params
  final String? bottomButtonText;
  final Widget? bottomButtonMenuWidget;

  // Big Constructor
  KybelePage(
    this.isDraggable,
    this.hasHeader,
    this.hasHeaderIcon,
    this.hasHeaderClose,
    this.hasBottomActionButton,
    this.bodyWidget,
    {
      super.key,
      this.headerIcon,
      this.headerIconColor,
      this.headerIconBkgColor,
      this.headerText,
      this.bottomButtonText,
      this.bottomButtonMenuWidget,
    }
  );

  KybelePage.fixedWithHeader(
    this.hasHeaderIcon,
    this.hasHeaderClose,
    this.hasBottomActionButton,
    this.headerText,
    this.bodyWidget,
    {
      super.key,
      this.headerIcon,
      this.headerIconColor,
      this.headerIconBkgColor,
      this.bottomButtonText,
      this.bottomButtonMenuWidget
    }
  )
  {
    isDraggable = false;
    hasHeader = true;
  }

  KybelePage.draggableWithHeader(
      this.hasHeaderIcon,
      this.hasHeaderClose,
      this.hasBottomActionButton,
      this.headerText,
      this.bodyWidget,
      {
        super.key,
        this.headerIcon,
        this.headerIconColor,
        this.headerIconBkgColor,
        this.bottomButtonText,
        this.bottomButtonMenuWidget
      }
      )
  {
    isDraggable = true;
    hasHeader = true;
  }

  KybelePage.fixedNoHeader(
      this.hasBottomActionButton,
      this.bodyWidget,
      {
        super.key,
        this.bottomButtonText,
        this.bottomButtonMenuWidget
      }
      )
  {
    isDraggable = false;
    hasHeader = false;
    hasHeaderIcon = false;
    hasHeaderClose = false;
    headerText = null;
    headerIcon = null;
    headerIconColor = null;
    headerIconBkgColor = null;
  }

  KybelePage.draggableNoHeader(
      this.hasBottomActionButton,
      this.bodyWidget,
      {
        super.key,
        this.bottomButtonText,
        this.bottomButtonMenuWidget
      }
      )
  {
    isDraggable = true;
    hasHeader = false;
    hasHeaderIcon = false;
    hasHeaderClose = false;
    headerText = null;
    headerIcon = null;
    headerIconColor = null;
    headerIconBkgColor = null;
  }

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
            /* TODO fix this
            Consumer<TimerProvider>(
              builder: (context, provider, widget){
                if (provider.getActive()) {

                }
              },
            ),*/
            const TimerBackgroundLayer(),
            ContentLayer(headerIconBkgColor!, headerIconColor!, headerIcon!, hasHeaderIcon!, headerText!, bodyWidget),
            hasBottomActionButton ? ActionButtonLayer(bottomButtonText!, bottomButtonMenuWidget!) : Container(),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/scaffold/layers/layers.dart';

class KScaffold extends StatelessWidget {
  // Options
  final bool isDraggable;
  final bool startExpanded;
  final bool hasHeader;
  final bool hasHeaderIcon;
  final bool hasHeaderClose;
  final bool hasBottomActionButton;

  // Content Layer Params
  final IconData? headerIcon;
  final Color? headerIconColor;
  final Color? headerIconBkgColor;
  final String? headerText;
  final Widget bodyWidget;

  // Bottom Layer Params
  final String? bottomButtonText;
  final Widget? bottomButtonMenuWidget;

  // Big Constructor
  const KScaffold({
    required this.isDraggable,
    required this.hasHeader,
    required this.hasHeaderIcon,
    required this.hasHeaderClose,
    required this.hasBottomActionButton,
    required this.bodyWidget,
    this.startExpanded = true,
    this.headerIcon,
    this.headerIconColor,
    this.headerIconBkgColor,
    this.headerText,
    this.bottomButtonText,
    this.bottomButtonMenuWidget,
    super.key,
  })  : assert(
            ((hasHeader == true) && (headerText != null)) ||
                (hasHeader == false),
            "Must have headerText if header is activated"),
        assert(
            ((hasHeaderIcon == true) &&
                    (headerIcon != null) &&
                    (headerIconColor != null) &&
                    (headerIconBkgColor != null)) ||
                ((hasHeaderIcon == false)),
            "Header icon activated but not all associated parameters defined"),
        assert(
            ((hasBottomActionButton == true) &&
                    (bottomButtonText != null) &&
                    (bottomButtonMenuWidget != null)) ||
                ((hasBottomActionButton == false)),
            "Bottom action button activated but not all associated parameters defined");

  const KScaffold.fixedWithHeader({
    required hasHeaderIcon,
    required hasHeaderClose,
    required hasBottomActionButton,
    required headerText,
    required bodyWidget,
    headerIcon,
    headerIconColor,
    headerIconBkgColor,
    bottomButtonText,
    bottomButtonMenuWidget,
    key,
  }) : this(
          isDraggable: false,
          hasHeader: true,
          hasHeaderIcon: hasHeaderIcon,
          hasHeaderClose: hasHeaderClose,
          hasBottomActionButton: hasBottomActionButton,
          bodyWidget: bodyWidget,
          headerIcon: headerIcon,
          headerIconColor: headerIconColor,
          headerIconBkgColor: headerIconBkgColor,
          headerText: headerText,
          bottomButtonText: bottomButtonText,
          bottomButtonMenuWidget: bottomButtonMenuWidget,
          key: key,
        );

  const KScaffold.draggableWithHeader({
    required hasHeaderIcon,
    required hasHeaderClose,
    required hasBottomActionButton,
    required headerText,
    required bodyWidget,
    required startExpanded,
    headerIcon,
    headerIconColor,
    headerIconBkgColor,
    bottomButtonText,
    bottomButtonMenuWidget,
    key,
  }) : this(
          isDraggable: true,
          startExpanded: startExpanded,
          hasHeader: true,
          hasHeaderIcon: hasHeaderIcon,
          hasHeaderClose: hasHeaderClose,
          hasBottomActionButton: hasBottomActionButton,
          bodyWidget: bodyWidget,
          headerIcon: headerIcon,
          headerIconColor: headerIconColor,
          headerIconBkgColor: headerIconBkgColor,
          headerText: headerText,
          bottomButtonText: bottomButtonText,
          bottomButtonMenuWidget: bottomButtonMenuWidget,
          key: key,
        );

  const KScaffold.fixedNoHeader({
    required hasBottomActionButton,
    required bodyWidget,
    bottomButtonText,
    bottomButtonMenuWidget,
    key,
  }) : this(
          isDraggable: false,
          hasHeader: false,
          hasHeaderIcon: false,
          hasHeaderClose: false,
          hasBottomActionButton: hasBottomActionButton,
          bodyWidget: bodyWidget,
          bottomButtonText: bottomButtonText,
          bottomButtonMenuWidget: bottomButtonMenuWidget,
          key: key,
        );

  const KScaffold.draggableNoHeader({
    required startExpanded,
    required hasBottomActionButton,
    required bodyWidget,
    bottomButtonText,
    bottomButtonMenuWidget,
    key,
  }) : this(
          isDraggable: true,
          startExpanded: startExpanded,
          hasHeader: false,
          hasHeaderIcon: false,
          hasHeaderClose: false,
          hasBottomActionButton: hasBottomActionButton,
          bodyWidget: bodyWidget,
          bottomButtonText: bottomButtonText,
          bottomButtonMenuWidget: bottomButtonMenuWidget,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: OrientationBuilder(builder: (context, orientation) {
        return Stack(
          children: [
            TimerBackgroundLayer(
              isDraggable: isDraggable,
              orientation: orientation,
            ),
            SafeArea(
              bottom: false,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return ContentLayer(
                    isDraggable: isDraggable,
                    startExpanded: startExpanded,
                    hasHeader: hasHeader,
                    hasHeaderIcon: hasHeaderIcon,
                    hasHeaderClose: hasHeaderClose,
                    headerIcon: headerIcon,
                    headerIconColor: headerIconColor,
                    headerIconBkgColor: headerIconBkgColor,
                    headerText: headerText,
                    bodyWidget: bodyWidget,
                    heightConstraint: constraints.maxHeight,
                    orientation: orientation,
                  );
                },
              ),
            ),
            SafeArea(
              bottom: false,
              child: ActionButtonLayer(
                hasBottomActionButton: hasBottomActionButton,
                bottomButtonText: bottomButtonText,
                bottomButtonMenuWidget: bottomButtonMenuWidget,
                orientation: orientation,
              ),
            ),
          ],
        );
      }),
    );
  }
}

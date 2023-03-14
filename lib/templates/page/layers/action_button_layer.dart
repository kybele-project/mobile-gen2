import 'package:flutter/material.dart';

import '../../../components/buttons/buttons.dart';

class ActionButtonLayer extends StatelessWidget {
  final bool hasBottomActionButton;
  final String? bottomButtonText;
  final Widget? bottomButtonMenuWidget;
  final Orientation orientation;

  const ActionButtonLayer(
      {required this.hasBottomActionButton,
      required this.bottomButtonText,
      required this.bottomButtonMenuWidget,
      required this.orientation,
      super.key});

  @override
  Widget build(BuildContext context) {
    if (hasBottomActionButton) {
      return Stack(
        alignment: Alignment.center,
        children: [
          const KybeleButtonGradientLayer(),
          Positioned(
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    builder: (context) {
                      return bottomButtonMenuWidget!;
                    });
              },
              child: KybeleSolidButton(bottomButtonText!),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}

import 'package:flutter/material.dart';

import '../../../components/button.dart';

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
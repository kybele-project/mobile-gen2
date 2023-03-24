import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/buttons/buttons.dart';
import 'package:kybele_gen2/components/scaffold/scaffold.dart';
import 'package:kybele_gen2/main.dart';
import 'package:kybele_gen2/screens/nrp_module/nrp_home.dart';
import 'package:kybele_gen2/screens/pnc_module/pnc_home.dart';
import 'package:kybele_gen2/style/style.dart';

import 'dart_module/dart_home.dart';

class ModuleHome extends StatelessWidget {
  const ModuleHome({super.key});

  Widget body(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 80, 0, 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/kybele_purple.png',
                            height: 45,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Beta version of application",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                  ),
                  const Text(
                      "Please submit screenshots with feedback on the 'Kybele App Beta [Feedback]' WhatsApp chat ",
                      style: TextStyle(fontSize: 18)
                  ),
                  const SizedBox(height: 40),
                  KColorfulButton(
                      bkgColor: mainMediumPurple,
                      labelColor: Colors.white,
                      icon: Icons.backpack_rounded,
                      header: "DART Module",
                      page: const Framework(child: DartHome()),
                      inPopUp: false,
                  ),
                  const SizedBox(height: 20),
                  KColorfulButton(
                      bkgColor: mainMediumPurple,
                      labelColor: Colors.white,
                      icon: Icons.backpack_rounded,
                      header: "NRP Module",
                      page: const Framework(child: NRPHome()),
                      inPopUp: false,
                  ),
                  const SizedBox(height: 20),
                  KColorfulButton(
                      bkgColor: mainMediumPurple,
                      labelColor: Colors.white,
                      icon: Icons.backpack_rounded,
                      header: "PNC Module",
                      page: const Framework(child: PNCHome()),
                      inPopUp: false,
                  ),
                  const SizedBox(height: 40),
                      const Text("Powered by ClinicPal, LLC",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      Text("Made with ❤️ in the USA",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade600)),
                      const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold.fixedNoHeader(
      hasBottomActionButton: false,
      bodyWidget: body(context),
    );
  }
}

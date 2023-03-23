import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/buttons/buttons.dart';
import 'package:kybele_gen2/models/models.dart';

class KPdfGrid extends StatelessWidget {

  final List<Document> documentList;
  final IconData icon;
  final Color bkgColor;
  final Color iconColor;

  const KPdfGrid({
    required this.documentList,
    required this.icon,
    required this.bkgColor,
    required this.iconColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        color: Colors.white,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: documentList.length,
            itemBuilder: (context, index) {
              return KPdfTile(
                  document: documentList[index],
                icon: icon,
                bkgColor: bkgColor,
                iconColor: iconColor,
              );
            }
        ),
      ),
    );
  }
}
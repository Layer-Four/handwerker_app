import 'package:flutter/material.dart';

class ReadQRCodeView extends StatelessWidget {
  const ReadQRCodeView({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Center(
              child: const Text(
            'Erste Anmeldung\nBitte scanne den QRCode',
            textAlign: TextAlign.center,
          )),
        ),
        body: Container(),
      );
}

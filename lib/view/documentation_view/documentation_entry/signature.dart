import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignaturePopUpWidget extends StatefulWidget {
  const SignaturePopUpWidget({super.key});

  @override
  _SignaturePopUpWidgetState createState() => _SignaturePopUpWidgetState();
}

class _SignaturePopUpWidgetState extends State<SignaturePopUpWidget> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Signaturfeld', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Signature(
              controller: _controller,
              height: 200,
              backgroundColor: Colors.grey[200]!,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.clear();
                  },
                  child: Text('Neu'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_controller.isNotEmpty) {
                      final signature = await _controller.toPngBytes();
                      Navigator.of(context).pop(signature);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bitte eine Signatur hinzufügen')),
                      );
                    }
                  },
                  child: Text('Bestätigen'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ablehnen'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

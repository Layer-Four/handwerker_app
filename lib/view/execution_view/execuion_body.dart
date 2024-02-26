import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/globals.dart';
import 'package:handwerker_app/view/execution_view/execution_view.dart';

class ExecutionBody extends ConsumerStatefulWidget {
  const ExecutionBody({super.key});
  @override
  ConsumerState<ExecutionBody> createState() => _ExecutionState();
}

class _ExecutionState extends ConsumerState<ExecutionBody> {
  final TextEditingController dayPickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var selecedDate;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabeledTextFField(
                  label: 'Tag',
                  onPressed: () async {
                    selecedDate = await Utilits.selecetDate(context);
                    if (selecedDate != null) {
                      setState(() {
                        dayPickerController.text =
                            '${selecedDate!.day}.${selecedDate!.month}.${selecedDate!.year}';
                      });
                    }
                  },
                ),
                const LabeledTextFField(label: 'Dauer')
              ],
            )
          ],
        ),
      ),
    );
  }
}

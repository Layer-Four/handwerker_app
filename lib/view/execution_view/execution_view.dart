import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/globals.dart';
import 'package:handwerker_app/view/navigation_view/app_navigation_bar.dart';

class ExecutionView extends ConsumerStatefulWidget {
  const ExecutionView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExecutionViewState();
}

class _ExecutionViewState extends ConsumerState<ExecutionView> {
  final dayPickerController = TextEditingController();
  // final vonController?
  // final bisController?

  @override
  Widget build(BuildContext context) {
    DateTime? selecedDate;
    return Scaffold(
      body: GestureDetector(
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
      ),
    );
  }
}

class LabeledTextFField extends StatefulWidget {
  final Function()? onPressed;
  final String label;

  const LabeledTextFField({super.key, this.onPressed, required this.label});

  @override
  State createState() => _LabeledTextFFieldState();
}

class _LabeledTextFFieldState extends State<LabeledTextFField> {
  final controller = TextEditingController();
  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            widget.label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 30,
          width: 150,
          child: TextFormField(
            textInputAction: TextInputAction.done,
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue))),
            onTap: widget.onPressed,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/globals.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavigationIcon(title: 'Zeiteintrag', isCurrent: true),
            NavigationIcon(title: 'Doku'),
            NavigationIcon(title: 'Material'),
          ],
        ),
      ),
      body: Padding(
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
                LabeledTextFField(label: 'Dauer')
              ],
            )
          ],
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
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 30,
          width: 150,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue))),
            onTap: widget.onPressed,
          ),
        ),
      ],
    );
  }
}

class NavigationIcon extends StatelessWidget {
  final String title;
  final bool isCurrent;
  const NavigationIcon({
    super.key,
    required this.title,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            title,
            style: isCurrent
                ? const TextStyle(color: Colors.orange, fontSize: 17)
                : const TextStyle(color: Colors.white, fontSize: 17),
          ),
          isCurrent
              ? Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  width: 25,
                  decoration: BoxDecoration(border: Border.all(width: 1.5, color: Colors.orange)),
                )
              : const SizedBox()
        ],
      );
}

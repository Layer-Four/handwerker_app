import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/globals.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/small_textfield.dart';

class ExecutionBody extends ConsumerStatefulWidget {
  const ExecutionBody({super.key});
  @override
  ConsumerState<ExecutionBody> createState() => _ExecutionState();
}

class _ExecutionState extends ConsumerState<ExecutionBody> {
  final TextEditingController dayPickerController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  DateTime? selecedDate;
  TimeOfDay? selectedTime;
  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
    startController.text = '${selectedTime!.hour}:${selectedTime!.minute}';
  }

  @override
  Widget build(BuildContext context) {
    log('$selectedTime');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallLabelInputWidget(
                  label: 'Tag',
                  child: CustomTextField(
                    controller: dayPickerController,
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
                ),
                SmallLabelInputWidget(
                  label: 'Dauer',
                  child: CustomTextField(
                    controller: durationController,
                    onPressed: () async {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallLabelInputWidget(
                  label: 'VON',
                  child: CustomTextField(
                    controller: startController,
                    onPressed: () async {
                      final newTime = await showTimePicker(
                          initialEntryMode: TimePickerEntryMode.input,
                          context: context,
                          initialTime: selectedTime!);
                      if (newTime != null) {
                        setState(() {
                          startController.text = '${newTime.hour} : ${newTime.minute}';
                        });
                      }
                    },
                  ),
                ),
                SmallLabelInputWidget(
                  label: 'BIS',
                  child: CustomTextField(
                    controller: endController,
                    onPressed: () async {
                      final newTime = await showTimePicker(
                          initialEntryMode: TimePickerEntryMode.input,
                          context: context,
                          initialTime: selectedTime!);
                      if (newTime != null) {
                        setState(() {
                          endController.text = '${newTime.hour} : ${newTime.minute}';
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// TODO: keyboardType.multiline
class CustomTextField extends StatefulWidget {
  final String? initialValue;
  final TextEditingController controller;
  final VoidCallback? onPressed;
  const CustomTextField({super.key, required this.controller, this.onPressed, this.initialValue});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) => TextFormField(
        cursorHeight: 20,
        // TODO: all input style in grey or just default? like initvalue is Today and when update its black?
        textAlignVertical: TextAlignVertical.center,

        style: TextStyle(color: Colors.grey[400], fontSize: 20),
        textInputAction: TextInputAction.done,
        controller: widget.controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue))),
        onTap: widget.onPressed,
      );
}

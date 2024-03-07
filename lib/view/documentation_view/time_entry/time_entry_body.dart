import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/time_entry/time_entry.dart';
import 'package:handwerker_app/provider/doku_provider/time_provider.dart';
import 'package:handwerker_app/provider/language_provider/language_provider.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labeld_textfield.dart';

class TimeEntryBody extends ConsumerStatefulWidget {
  const TimeEntryBody({super.key});
  @override
  ConsumerState<TimeEntryBody> createState() => _ExecutionState();
}

class _ExecutionState extends ConsumerState<TimeEntryBody> {
  final TextEditingController _dayPickerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  TimeOfDay? selectedTime;
  static const _customerProject = [
    ' Wählen',
    ' Koch / Fenster Montage',
    ' Meier/ Bad verfliesen',
    ' Berger/ Putzen',
  ];
  static const _services = [
    ' Wählen',
    ' Fenster Montage',
    ' Bad fliesen',
    ' Reinigung',
  ];
  String _project = _customerProject.first;
  String _executedService = _services.first;

  late TimeEntry _entry;
  @override
  void initState() {
    super.initState();
    _entry = TimeEntry(date: DateTime.now(), startTime: DateTime.now());
    final minute =
        _entry.startTime.minute < 10 ? '0${_entry.startTime.minute}' : '${_entry.startTime.minute}';
    if (selectedTime == null || _dayPickerController.text.isEmpty) {
      _dayPickerController.text =
          '${_entry.startTime.day}.${_entry.startTime.month}.${_entry.startTime.year}';
      selectedTime = TimeOfDay(hour: _entry.startTime.hour, minute: _entry.startTime.minute);
    }
    _startController.text = '${selectedTime!.hour}:$minute';
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            _dayInputRow(),
            _timeInputRow(),
            _buildCustomerProjectField(),
            _buildServiceButton(),
            _buildDescription(),
            const SizedBox(height: 46),
            _submitInput(),
            SizedBox(
              height: 70,
              child: Center(
                child: Image.asset('assets/images/img_techtool.png', height: 20),
              ),
            ),
          ],
        ),
      );

  Padding _submitInput() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SymmetricButton(
          color: AppColor.kPrimaryButtonColor,
          text: ref.watch(languangeProvider).createEntry,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          onPressed: () {
            if (_startController.text.isEmpty || _endController.text.isEmpty) {
              return ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bitte gib Start und eine Endzeit an'),
                ),
              );
            } else if (_project == 'Wählen' || _executedService == 'Wählen') {
              return ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bitte wähle einen Kunde/Projekt und eine Leistung'),
                ),
              );
            } else {
              ref.read(timeEntryProvider.notifier).addTimeEntry(_entry);
              setState(() {
                _startController.clear();
                _descriptionController.clear();
                _endController.clear();
                _durationController.clear();
                _executedService = _services.first;
                _project = _customerProject.first;
              });
            }
          },
        ),
      );

  Padding _buildCustomerProjectField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: LabeledInputWidget(
          label: ref.watch(languangeProvider).customerProject,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.kTextfieldBorder),
            ),
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              value: _project,
              items: _customerProject
                  .map(
                    (e) => DropdownMenuItem(value: e, child: Text(e)),
                  )
                  .toList(),
              onChanged: (e) {
                setState(() {
                  _project = e!;
                  _entry = _entry.copyWith(projectID: e);
                });
              },
            ),
          ),
        ),
      );

  _dayInputRow() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallLabelInputWidget(
              label: ref.watch(languangeProvider).date,
              child: SizedBox(
                height: 35,
                child: TextField(
                  controller: _dayPickerController,
                  cursorHeight: 20,
                  autofocus: false,
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    final date = await Utilits.selecetDate(context);
                    if (date != null) {
                      setState(() {
                        _entry = _entry.copyWith(date: date);
                        _dayPickerController.text = '${date.day}.${date.month}.${date.year}';
                      });
                    }
                  },
                  decoration: Utilits.textFieldDecorator(context),
                ),
              ),
            ),
            SmallLabelInputWidget(
              label: ref.watch(languangeProvider).duration,
              child: SizedBox(
                height: 35,
                child: TextField(
                  cursorHeight: 20,
                  autofocus: false,
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  // TODO: implement a wheelspinner for pick Hours and minutes?
                  onChanged: (value) {
                    setState(() {
                      _entry = _entry.copyWith(duration: int.tryParse(value));
                    });
                  },
                  decoration: Utilits.textFieldDecorator(context, hintText: 'min.'),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _timeInputRow() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallLabelInputWidget(
              label: ref.watch(languangeProvider).start,
              child: SizedBox(
                height: 35,
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  autofocus: false,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.next,
                  controller: _startController,
                  decoration: Utilits.textFieldDecorator(context),
                  onTap: () async {
                    final time = await showTimePicker(context: context, initialTime: selectedTime!);
                    if (time != null) {
                      final minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
                      _entry = _entry.copyWith(
                          startTime: DateTime(
                        _entry.date.year,
                        _entry.date.month,
                        _entry.date.day,
                        time.hour,
                        time.minute,
                      ));
                      _startController.text = '${time.hour}:$minute';
                    }
                  },
                ),
              ),
            ),
            SmallLabelInputWidget(
              label: ref.watch(languangeProvider).end,
              child: SizedBox(
                height: 35,
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  autofocus: false,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.done,
                  controller: _endController,
                  decoration: Utilits.textFieldDecorator(context),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                        hour: int.tryParse(_endController.text.split(':').first) ?? 16,
                        minute: int.tryParse(_endController.text.split(':').last) ?? 30,
                      ),
                    );
                    if (time != null) {
                      setState(() {
                        _entry = _entry.copyWith(
                            endTime: DateTime(
                          _entry.date.year,
                          _entry.date.month,
                          _entry.date.day,
                          time.hour,
                          time.minute,
                        ));
                        final minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
                        _endController.text = '${time.hour}:$minute';
                      });
                      _calculateDuration();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );

  /// Split the [String] values from the TextEdingController with the given
  /// format and build [DateTime] objects with the Compination from
  /// _dayPickerController and _startController.
  /// than do  the same translation with _dayPickerController and _endController
  /// and return the different between this [DateTime] object in minutes.
  void _calculateDuration() {
    final dateAsList = _dayPickerController.text.split('.').map((e) => int.parse(e)).toList();
    final start = DateTime(
      dateAsList[2],
      dateAsList[1],
      dateAsList[0],
      int.parse(_startController.text.split(':').first),
      int.parse(_startController.text.split(':').last),
    );
    final end = DateTime(
      start.year,
      start.month,
      start.day,
      int.parse(_endController.text.split(':').first),
      int.parse(_endController.text.split(':').last),
    );
    final sum = ((end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) / 1000) ~/ 60;
    setState(() {
      _entry = _entry.copyWith(duration: sum);
    });
    final hours = sum ~/ 60;
    final minutes = sum % 60;
    // TODO: exclude pause?
    _durationController.text = '$hours:${minutes < 10 ? '0$minutes' : minutes} h.';
  }

  Padding _buildDescription() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: LabeledInputWidget(
          label: ref.watch(languangeProvider).description,
          child: SizedBox(
            height: 80,
            child: TextField(
              cursorHeight: 20,
              controller: _descriptionController,
              textAlignVertical: TextAlignVertical.top,
              expands: true,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: null,
              decoration: Utilits.textFieldDecorator(context),
              onChanged: (value) {
                setState(() {
                  _descriptionController.text = value;
                  _entry = _entry.copyWith(description: _descriptionController.text);
                });
              },
            ),
          ),
        ),
      );

  Padding _buildServiceButton() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: LabeledInputWidget(
          label: ref.watch(languangeProvider).service,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.kTextfieldBorder),
            ),
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              value: _executedService,
              items: _services.map(
                (e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                },
              ).toList(),
              onChanged: (e) => setState(() {
                _executedService = e!;
                _entry = _entry.copyWith(service: e);
              }),
            ),
          ),
        ),
      );
}

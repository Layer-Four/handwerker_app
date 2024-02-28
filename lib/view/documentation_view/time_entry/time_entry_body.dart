import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/globals.dart';
import 'package:handwerker_app/models/execution/execution.dart';
import 'package:handwerker_app/provider/doku_provider/dokumentation_provider.dart';
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
  DateTime? selecedDate;
  TimeOfDay? selectedTime;
  static const customerProject = [
    'Wählen',
    'Koch / Fenster Montage',
    'Meier/ Bad verfliesen',
    'Berger/ Putzen',
  ];
  static const services = ['Wählen', 'Fenster Montage', 'Bad fliesen', 'Reinigung'];
  String _project = customerProject.first;
  String _executedService = services.first;
  @override
  void initState() {
    super.initState();
    final minute =
        DateTime.now().minute < 10 ? '0${DateTime.now().minute}' : '${DateTime.now().minute}';
    if (selectedTime == null || _dayPickerController.text.isEmpty) {
      _dayPickerController.text =
          '${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}';
      selectedTime = TimeOfDay(hour: DateTime.now().hour, minute: int.parse(minute));
    }
    _startController.text = '${selectedTime!.hour}:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final collection = ref.read(dokuProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Column(
        children: [
          _dayInputRow(),
          _durationInputRow(),
          _buildCustomerProjectField(),
          _buildServiceButton(),
          _buildDescription(),
          const SizedBox(height: 40),
          _submitInput(collection),
          SizedBox(
            child: Image.asset(
              'assets/images/img_techtool.png',
              height: 70,
            ),
          ),
        ],
      ),
    );
  }

  Padding _submitInput(InputNotifier collection) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SymetricButton(
        color: AppColor.kPrimaryColor,
        text: 'Eintrag erstellen',
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
            final execution = _createExecution();
            collection.saveStart(start: execution.start);
            collection.saveDescription(description: execution.descritpion);
            collection.saveProject(project: execution.project);
            collection.saveEnd(end: execution.end);
            collection.saveService(service: execution.service);
            collection.saveUser(users: execution.users);
          }
        },
      ),
    );
  }

  Execution _createExecution() {
    final startTime = _startController.text.split(':').map((e) => int.parse(e)).toList();
    final startAsList = _dayPickerController.text.split('.').map((e) => int.parse(e)).toList();
    final start = DateTime(
      startAsList[2],
      startAsList[1],
      startAsList[0],
      startTime[0],
      startTime[1],
    );
    final endTime = _endController.text.split(':').map((e) => int.parse(e)).toList();
    final end = DateTime(
      startAsList[2],
      startAsList[1],
      startAsList[0],
      endTime.first,
      endTime.last,
    );
    return Execution(
      project: _project,
      start: start,
      end: end,
      descritpion:
          'Dauer: ${_durationController.text.split('m').first}min. ${_descriptionController.text}',
      service: _executedService,
    );
  }

  Padding _buildCustomerProjectField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LabeledInputWidget(
        label: 'KUNDE/PROJEKT',
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.kTextfieldBorder),
          ),
          child: DropdownButton(
            underline: const SizedBox(),
            isExpanded: true,
            value: _project,
            items: customerProject
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e)),
                )
                .toList(),
            onChanged: (e) {
              setState(() => _project = e!);
            },
          ),
        ),
      ),
    );
  }

  _dayInputRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmallLabelInputWidget(
            label: 'Tag',
            child: SizedBox(
              height: 35,
              child: TextField(
                cursorHeight: 20,
                autofocus: false,
                controller: _dayPickerController,
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  final date = await Utilits.selecetDate(context);
                  if (date != null) {
                    setState(() {
                      _dayPickerController.text = '${date.day}.${date.month}.${date.year}';
                    });
                  }
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.kTextfieldBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColor.kBlue))),
              ),
            ),
          ),
          SmallLabelInputWidget(
            label: 'Dauer',
            child: SizedBox(
              height: 35,
              child: TextField(
                cursorHeight: 20,
                autofocus: false,
                controller: _durationController,
                keyboardType: TextInputType.number,
                // TODO: implement a wheelspinner for pick Hours and minutes?
                onChanged: (value) {},
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.kTextfieldBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColor.kBlue))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _durationInputRow() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallLabelInputWidget(
              label: 'VON',
              child: SizedBox(
                height: 35,
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  autofocus: false,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.done,
                  controller: _startController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColor.kTextfieldBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.kBlue),
                    ),
                  ),
                  onTap: () async {
                    final time = await showTimePicker(context: context, initialTime: selectedTime!);
                    if (time != null) {
                      final minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
                      setState(
                        () => _startController.text = '${time.hour}:$minute',
                      );
                    }
                  },
                ),
              ),
            ),
            SmallLabelInputWidget(
              label: 'BIS',
              child: SizedBox(
                height: 35,
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  autofocus: false,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.done,
                  controller: _endController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: AppColor.kTextfieldBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColor.kBlue),
                    ),
                  ),
                  onTap: () async {
                    final time = await showTimePicker(context: context, initialTime: selectedTime!);
                    if (time != null) {
                      setState(() {
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

    final hours = sum ~/ 60;
    final minutes = sum % 60;
    // TODO: exclude pause?
    _durationController.text = '$sum min. $hours:${minutes < 10 ? '0$minutes' : minutes} h.';
  }

  Padding _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LabeledInputWidget(
        label: 'BESCHREBUNG',
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
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.kTextfieldBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.kBlue),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildServiceButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LabeledInputWidget(
        label: 'LEISTUNG',
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
            items: services.map(
              (e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              },
            ).toList(),
            onChanged: (e) => setState(() => _executedService = e!),
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/project_models/project_list_vm/project_list.dart';
import 'package:handwerker_app/models/service_models/service_list_vm/service_list.dart';
import 'package:handwerker_app/models/time_models/time_entry.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';
import 'package:handwerker_app/provider/doku_provider/service_provider.dart';
import 'package:handwerker_app/provider/doku_provider/time_provider.dart';
import 'package:handwerker_app/provider/settings_provider/language_provider.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labelt_textfield.dart';

class TimeEntryBody extends ConsumerStatefulWidget {
  const TimeEntryBody({super.key});
  @override
  ConsumerState<TimeEntryBody> createState() => _TimeEntryState();
}

class _TimeEntryState extends ConsumerState<TimeEntryBody> {
  final TextEditingController _dayPickerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  bool isServiceSet = false;
  bool _isProjectSet = false;
  TimeOfDay? selectedTime;

  ServiceListVM? _choosenService;

  ProjectListVM? _project;
  late TimeEntry _entry;

  @override
  void initState() {
    super.initState();
    ref.read(projectVMProvider.notifier).loadpProject();
    _entry = TimeEntry(date: DateTime.now(), startTime: DateTime.now());
    final minute = _entry.startTime.minute < 10
        ? '0${_entry.startTime.minute}'
        : '${_entry.startTime.minute}';
    if (selectedTime == null || _dayPickerController.text.isEmpty) {
      _dayPickerController.text =
          '${_entry.startTime.day}.${_entry.startTime.month}.${_entry.startTime.year}';
      selectedTime = TimeOfDay(
          hour: _entry.startTime.hour, minute: _entry.startTime.minute);
    }
    _startController.text = '${selectedTime!.hour}:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          _dayInputRow(),
          _timeInputRow(),
          _buildCustomerProjectField(),
          _buildServiceDropdown(),
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
  }

  Widget _buildCustomerProjectField() {
    return ref.watch(projectVMProvider).when(
          error: (error, stackTrace) {
            log('error occurent in buildServieDropdown in TimeEntryBody-> $error \n\n this was the stack $stackTrace');
            return const SizedBox.expand(
              child: Center(child: Text('Etwas lief schief')),
            );
          },
          loading: () => const CircularProgressIndicator.adaptive(),
          data: (data) {
            if (data == null) {
              ref.read(projectVMProvider.notifier).loadpProject();
            }
            final projects = data;
            if (projects != null && !_isProjectSet) {
              setState(() {
                _project = projects.first;
                _entry = _entry.copyWith(projectID: projects.first.id);
                _isProjectSet = true;
              });
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(ref.watch(languangeProvider).customerProject,
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.kTextfieldBorder),
                    ),
                    child: DropdownButton(
                      menuMaxHeight: 350,
                      underline: const SizedBox(),
                      isExpanded: true,
                      value: _project,
                      items: projects
                          ?.map(
                            (e) => DropdownMenuItem(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(' ${e.title}'),
                            ),
                          )
                          .toList(),
                      onChanged: (e) {
                        setState(() {
                          _project = e!;
                          _entry = _entry.copyWith(projectID: e.id);
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }

  Widget _buildDescription() => LabeldTextfield(
        heigt: 80,
        textInputAction: TextInputAction.newline,
        textInputType: TextInputType.multiline,
        label: ref.watch(languangeProvider).description,
        controller: _descriptionController,
        onChanged: (value) {
          setState(() {
            _descriptionController.text = value;
            _entry = _entry.copyWith(description: _descriptionController.text);
          });
        },
      );

  Widget _buildServiceDropdown() {
    return ref.watch(serviceProvider).when(
          error: (error, stackTrace) {
            log('error occurent in buildServieDropdown in TimeEntryBody-> $error \n\n this was the stack $stackTrace');
            return const SizedBox(child: Text('Etwas lief schief'));
          },
          loading: () => const CircularProgressIndicator.adaptive(),
          data: (data) {
            if (data == null) {
              ref.watch(serviceProvider.notifier).loadServices();
            }
            final services = data;
            if (services != null && !isServiceSet) {
              setState(() {
                _choosenService = services.first;
                _entry = _entry.copyWith(serviceID: services.first.id);
                isServiceSet = true;
              });
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      ref.watch(languangeProvider).service,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColor.kTextfieldBorder),
                    ),
                    child: DropdownButton(
                      menuMaxHeight: 350,
                      underline: const SizedBox(),
                      isExpanded: true,
                      value: _choosenService,
                      items: services?.map(
                        (e) {
                          return DropdownMenuItem(
                            alignment: Alignment.center,
                            value: e,
                            child: Text(' ${e.name}'),
                          );
                        },
                      ).toList(),
                      onChanged: (e) => setState(() {
                        _choosenService = e;
                        _entry = _entry.copyWith(serviceID: e!.id, serviceTitle: e.name);
                      }),
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }

  /// Split the [String] values from the TextEdingController with the given
  /// format and build [DateTime] objects with the Compination from
  /// _dayPickerController and _startController.
  /// than do  the same translation with _dayPickerController and _endController
  /// and return the different between this [DateTime] object in minutes.
  void _calculateDuration() {
    final dateAsList =
        _dayPickerController.text.split('.').map((e) => int.parse(e)).toList();
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
    final sum =
        ((end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) / 1000) ~/
            60;
    setState(() {
      _entry = _entry.copyWith(duration: sum);
    });
    final hours = sum ~/ 60;
    final minutes = sum % 60;
    // TODO: exclude pause?
    _durationController.text =
        '$hours:${minutes < 10 ? '0$minutes' : minutes} h.';
  }

  _dayInputRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LabeldTextfield(
            label: ref.watch(languangeProvider).date,
            width: 150,
            textInputType: TextInputType.datetime,
            controller: _dayPickerController,
            onTap: () async {
              final date = await Utilits.selecetDate(context);
              if (date != null) {
                setState(() {
                  _entry = _entry.copyWith(date: date);
                  _dayPickerController.text =
                      '${date.day}.${date.month}.${date.year}';
                });
              }
            },
          ),
          LabeldTextfield(
            label: ref.watch(languangeProvider).duration,
            width: 150,
            hintText: 'min.',
            textInputType: TextInputType.number,
            controller: _durationController,
            // TODO: implement a wheelspinner for pick Hours and minutes?
            onChanged: (value) {
              _entry = _entry.copyWith(duration: int.tryParse(value));
            },
          ),
        ],
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
                SnackBar(
                  content: Text(ref.watch(languangeProvider).plsChooseBeginEnd),
                ),
              );
              // TODO: change wählen to an editable object
            } else {
              ref.read(timeEntryProvider.notifier).uploadTimeEntry(_entry);
              final now = DateTime.now();
              setState(() {
                _startController.clear();
                _descriptionController.clear();
                _endController.clear();
                _durationController.clear();
                _dayPickerController.text =
                    '${now.day}.${now.month}.${now.year}';
              });
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(ref.watch(languangeProvider).succes),
                ),
              );
            }
          },
        ),
      );

  Widget _timeInputRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LabeldTextfield(
            width: 150,
            textInputType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            label: ref.watch(languangeProvider).start,
            controller: _startController,
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: selectedTime!,
              );
              if (time != null) {
                final minute =
                    time.minute < 10 ? '0${time.minute}' : '${time.minute}';
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
          LabeldTextfield(
            width: 150,
            textInputType: TextInputType.datetime,
            textInputAction: TextInputAction.done,
            label: ref.watch(languangeProvider).end,
            controller: _endController,
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour:
                      int.tryParse(_endController.text.split(':').first) ?? 16,
                  minute:
                      int.tryParse(_endController.text.split(':').last) ?? 30,
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
                  final minute =
                      time.minute < 10 ? '0${time.minute}' : '${time.minute}';
                  _endController.text = '${time.hour}:$minute';
                });
                _calculateDuration();
              }
            },
          ),
        ],
      );
}

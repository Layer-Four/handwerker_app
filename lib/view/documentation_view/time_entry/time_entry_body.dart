import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/view/widgets/time_spinner_view_widget.dart';
import 'package:intl/intl.dart';
import '../../../constants/apptheme/app_colors.dart';
import '../../../models/project_models/project_short_vm/project_short_vm.dart';
import '../../../provider/doku_provider/time_provider.dart';
import '../../../provider/settings_provider/settings_provider.dart';
import '../../widgets/custom_datepicker_widget.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/error_message_widget.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/symetric_button_widget.dart';
import 'widgets/choose_customer_widget.dart';

class TimeEntriesBody extends ConsumerStatefulWidget {
  const TimeEntriesBody({super.key});
  @override
  ConsumerState<TimeEntriesBody> createState() => _TimeEntriesState();
}

class _TimeEntriesState extends ConsumerState<TimeEntriesBody> {
  late final TextEditingController _dayPickerCtrl, _descriptionCtrl, _durationCtrl, _endCtrl, _startCtrl;
  late final dictionary = ref.watch(settingsProv).dictionary;

  @override
  void initState() {
    super.initState();
    _dayPickerCtrl = TextEditingController(
      text: DateFormat('dd.MM.y').format(DateTime.now()),
    );
    _descriptionCtrl = TextEditingController();
    _durationCtrl = TextEditingController();
    _endCtrl = TextEditingController();
    _startCtrl = TextEditingController(
      text: DateFormat.Hm().format(DateTime.now()),
    );
    initEntry();
  }

  initEntry() async => Future.delayed(const Duration(microseconds: 1)).then(
        (_) => ref.read(timeEntriesProvider.notifier).updateEntry(
              newDate: DateTime.now(),
              startTime: DateTime.now(),
            ),
      );
  @override
  void dispose() {
    _dayPickerCtrl.dispose();
    _descriptionCtrl.dispose();
    _durationCtrl.dispose();
    _endCtrl.dispose();
    _startCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDatePicker(
                  width: MediaQuery.of(context).size.width * 0.4,
                  controller: _dayPickerCtrl,
                  title: dictionary.date,
                ),
                CustomTextfield(
                  widgetWidth: MediaQuery.of(context).size.width * 0.4,
                  controller: _durationCtrl,
                  title: dictionary.duration,
                  readOnly: true,
                  hintText: dictionary.minutesShort,
                  onTap: () {},
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.kTextfieldBorder),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
            // _timeInputRow(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextfield(
                  title: dictionary.start,
                  widgetWidth: MediaQuery.of(context).size.width * 0.40,
                  controller: _startCtrl,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.kTextfieldBorder),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onTap: () => _selectStartTime(),
                  onTapOutside: (_) => setState(() {
                    final result = _checkIfTimeFormat(_startCtrl.text);
                    _startCtrl.text = result.isEmpty ? _startCtrl.text : result;
                    if (_endCtrl.text.isNotEmpty) {
                      _calculateDuration();
                    }
                  }),
                  onEditingComplete: () => setState(() {
                    final result = _checkIfTimeFormat(_startCtrl.text);
                    _startCtrl.text = result.isEmpty ? _startCtrl.text : result;
                    if (_endCtrl.text.isNotEmpty) {
                      _calculateDuration();
                    }
                  }),
                ),
                CustomTextfield(
                  title: dictionary.end,
                  widgetWidth: MediaQuery.of(context).size.width * 0.40,
                  controller: _endCtrl,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.kTextfieldBorder),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onTap: () => _selectEndTime(),
                ),
              ],
            ),
            //:TODO: check is there no customers or is it on init Provider
            ref.watch(timeEntriesProvider).customers.isEmpty
                ? Text(ref.watch(settingsProv).dictionary.loadData)
                : CustomerDropdown(
                    title: ref.watch(settingsProv).dictionary.customer,
                    value: ref.watch(timeEntriesProvider).currentCustomer,
                    items: ref
                        .watch(timeEntriesProvider)
                        .customers
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Center(child: Text(e.companyName)),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (e) => ref.read(timeEntriesProvider.notifier).updateSeletedCustomer(e),
                  ),
            CustomerDropdown<ProjectShortVM>(
              title: dictionary.projectUpperCase,
              items: ref
                  .watch(timeEntriesProvider.notifier)
                  .projectsList
                  .map(
                    (e) => DropdownMenuItem(
                      alignment: Alignment.center,
                      value: e,
                      child: Text(' ${e.title}'),
                    ),
                  )
                  .toList(),
              onChanged: (e) {
                ref.read(timeEntriesProvider.notifier).updateSelectedProject(e);
              },
              value: ref.watch(timeEntriesProvider).project,
            ),

            CustomerDropdown(
              value: ref.watch(timeEntriesProvider).currentService,
              items: ref
                  .watch(timeEntriesProvider)
                  .allServices
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Center(
                        child: Text(e.name),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (e) => ref.read(timeEntriesProvider.notifier).updateSelectedService(e),
              title: dictionary.service,
            ),
            // _buildDescription(),
            CustomTextfield(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.kTextfieldBorder),
                borderRadius: BorderRadius.circular(6),
              ),
              title: dictionary.description,
              widgetWidth: MediaQuery.of(context).size.width,
              textfieldHeight: 80,
              controller: _descriptionCtrl,
              isMultiLine: true,
            ),
            const SizedBox(height: 58),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SymmetricButton(
                color: AppColor.kPrimaryButtonColor,
                text: dictionary.createEntry,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                onPressed: () => _checkAndSendEntry(context),
              ),
            ),
            const Center(
              child: LogoWidget(
                assetString: 'assets/images/img_techtool.png',
                size: 20,
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
    if (_startCtrl.text.isEmpty) {
      final nowTime = TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
      _startCtrl.text = '${nowTime.hour}:${nowTime.minute}';
    }
    final dateAsList = _dayPickerCtrl.text.split('.').map((e) => int.parse(e)).toList();
    final start = DateTime(
      dateAsList[2],
      dateAsList[1],
      dateAsList[0],
      int.parse(_startCtrl.text.split(':').first),
      int.parse(_startCtrl.text.split(':').last),
    );
    final end = DateTime(
      start.year,
      start.month,
      start.day,
      int.parse(_endCtrl.text.split(':').first),
      int.parse(_endCtrl.text.split(':').last),
    );
    final sum = ((end.millisecondsSinceEpoch - start.millisecondsSinceEpoch) / 1000) ~/ 60;
    //  TODO: update TimeProvider
    // setState(() {
    //   _entry = _entry.copyWith(duration: sum);
    // });
    final hours = sum ~/ 60;
    final minutes = sum % 60;
    // TODO: exclude pause?
    _durationCtrl.text = '$hours:${minutes < 10 ? '0$minutes' : minutes} h.';
    ref.read(timeEntriesProvider.notifier).updateEntry(duration: sum);
  }

  String _checkIfTimeFormat(String timeString) {
    final regex = RegExp(r'^([01]?[0-9]|2[0-3]):[0-5]?[0-9]$');
    if (!regex.hasMatch(timeString)) {
      showDialog(
        context: context,
        builder: (context) => const ErrorMessageWidget('Keine Gültige Uhrzeit'),
      );
      return '';
    }
    return timeString;
  }

  _checkAndSendEntry(BuildContext context) {
    final state = ref.watch(timeEntriesProvider);
    if ((state.currentCustomer == null) || (state.project == null) || (state.currentService == null)) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(dictionary.plsChooseCustomerService)),
        ),
      );
    } else if (_startCtrl.text.isEmpty || _endCtrl.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(dictionary.plsChooseBeginEnd)),
        ),
      );
    } else {
      final startList = _startCtrl.text.split(':').map((e) => int.parse(e)).toList();
      final endList = _endCtrl.text.split(':').map((e) => int.parse(e)).toList();
      final date = _dayPickerCtrl.text.split('.').map((e) => int.parse(e)).toList();

      final dateTime = DateTime(date[2], date[1], date[0]);
      //final date = DateFormat('dd.MM:yyyy').parse(_dayPickerCtrl.text);
      final start = DateTime(dateTime.year, dateTime.month, dateTime.day, startList[0], startList[1]);

      final end = DateTime(dateTime.year, dateTime.month, dateTime.day, endList[0], endList[1]);
      ref.read(timeEntriesProvider.notifier).updateEntry(
            newDate: dateTime,
            startTime: start,
            endTime: end,
            //endTime: DateTime.parse(DateFormat.parse(_endCtrl.text).toIso8601String()),
          );
      ref.read(timeEntriesProvider.notifier).createTimeEntriesVM().then((e) {
        if (e) {
          setState(() {
            final now = DateTime.now();
            _dayPickerCtrl.text = '${now.day}.${now.month}.${now.year}';
            _startCtrl.text = '${now.hour}:${now.minute}';
            _descriptionCtrl.clear();
            _endCtrl.clear();
            _durationCtrl.clear();
          });
        }
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e ? dictionary.succes : dictionary.failed),
          ),
        );
      });
    }
  }

  void _selectEndTime() async {
    final date = ref.watch(timeEntriesProvider).entry.date!;
    final initialTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.tryParse(_endCtrl.text.split(':').first) ?? 16,
      int.tryParse(_endCtrl.text.split(':').last) ?? 30,
    );
    final time = await showDialog(
      context: context,
      builder: (context) => TimeSpinnerViewWidget(initTime: initialTime),
    );
    if (time == null) return;
    final timeAsList = time.split(':');
    final hour = int.parse(timeAsList.first);
    final minute = int.parse(timeAsList.last);

    DateTime endDate = DateTime(date.year, date.month, date.day, hour, minute);
    final startDate = DateTime(
      date.year,
      date.month,
      date.day,
      int.tryParse(_startCtrl.text.split(':').first) ?? 0,
      int.tryParse(_startCtrl.text.split(':').last) ?? 0,
    );
    if (endDate.millisecondsSinceEpoch < startDate.millisecondsSinceEpoch) {
      _startCtrl.text = DateFormat.Hm().format(endDate);
      ref.read(timeEntriesProvider.notifier).updateEntry(startTime: endDate);
    }
    final minuteString = endDate.minute < 10 ? '0${endDate.minute}' : '${endDate.minute}';
    ref.read(timeEntriesProvider.notifier).updateEntry(endTime: endDate);

    _endCtrl.text = '${endDate.hour}:$minuteString';
    _calculateDuration();
    return;
  }

  void _selectStartTime() async {
    final date = ref.watch(timeEntriesProvider).entry.date!;
    final initialTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.tryParse(_startCtrl.text.split(':').first) ?? DateTime.now().hour,
      int.tryParse(_startCtrl.text.split(':').last) ?? DateTime.now().minute,
    );
    final time = await showDialog(
      context: context,
      builder: (context) => TimeSpinnerViewWidget(initTime: initialTime),
    );
    if (time == null) return;
    final timeAsList = time.split(':');
    final hour = int.parse(timeAsList.first);
    final minute = int.parse(timeAsList.last);
    DateTime startDate = DateTime(date.year, date.month, date.day, hour, minute);
    if (_endCtrl.text.isNotEmpty) {
      DateTime endDate = DateTime(
        date.year,
        date.month,
        date.day,
        int.tryParse(_endCtrl.text.split(':').first) ?? 0,
        int.tryParse(_endCtrl.text.split(':').last) ?? 0,
      );
      if (endDate.millisecondsSinceEpoch < startDate.millisecondsSinceEpoch) {
        endDate = startDate;
        _endCtrl.text = DateFormat.Hm().format(endDate);
        ref.read(timeEntriesProvider.notifier).updateEntry(endTime: endDate);
      }
      _calculateDuration();
    }

    final minuteString = startDate.minute < 10 ? '0${startDate.minute}' : '${startDate.minute}';
    ref.read(timeEntriesProvider.notifier).updateEntry(startTime: startDate);
    _startCtrl.text = '${startDate.hour}:$minuteString';
    return;
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/projectVM/project.dart';
import 'package:handwerker_app/provider/doku_provider/project_provider.dart';
import 'package:handwerker_app/provider/doku_provider/source_provider.dart';
import 'package:handwerker_app/provider/doku_provider/time_provider.dart';
import 'package:handwerker_app/provider/language_provider/language_provider.dart';
import 'package:handwerker_app/provider/view_provider/view_provider.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labeld_textfield.dart';

class ProjectBody extends ConsumerStatefulWidget {
  const ProjectBody({super.key});

  @override
  ConsumerState<ProjectBody> createState() => _ProjectBodyState();
}

class _ProjectBodyState extends ConsumerState<ProjectBody> {
  final TextEditingController _dayPickerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Project _entry = Project(createDate: DateTime.now());
  static const customerProject = [
    ' Wählen',
    ' Koch / Fenster Montage',
    ' Meier/ Bad verfliesen',
    ' Berger/ Putzen',
  ];
  String _project = customerProject.first;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      // TODO: show the date from last TimeEntry, or default the current day?
      final timeEntry = ref.watch(timeEntryProvider);
      if (timeEntry.isNotEmpty && timeEntry.last != null) {
        final lastTimeEntry = timeEntry.last;
        _dayPickerController.text =
            '${lastTimeEntry!.date.day}.${lastTimeEntry.date.month}.${lastTimeEntry.date.year}';
        _entry = _entry.copyWith(createDate: lastTimeEntry.date);
        final i = customerProject.indexWhere((e) => e == lastTimeEntry.projectID);
        setState(() {
          _project = customerProject[i];
          _entry = _entry.copyWith(createDate: lastTimeEntry.date, name: _project);
        });
      }
      log(_entry.toJson().toString());
    }
    final lanugage = ref.watch(languangeProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          children: [
            _dayInputWidget(lanugage),
            _buildCustomerProjectField(),
            _buildChooseMedai(),
            _buildDescription(),
            const SizedBox(height: 18),
            _submitInput(),
            SizedBox(
              height: 70,
              child: Center(
                child: Image.asset('assets/images/img_techtool.png', height: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildChooseMedai() {
    return Container(
      height: 170,
      width: 500,
      decoration: BoxDecoration(
        color: AppColor.kTextfieldBorder,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Foto machen'),
              IconButton(
                icon: const Icon(Icons.camera_alt, size: 75),
                onPressed: () async {
                  final image = await Utilits.pickImageFromCamera(context);
                  if (image != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          ' Bild ausgewählt',
                          style: TextStyle(
                            color: AppColor.kPrimaryButtonColor,
                          ),
                        ),
                        backgroundColor: AppColor.kPrimary,
                      ),
                    );
                    final filename = '$_project /${DateTime.timestamp()}';
                    setState(() {
                      _entry = _entry.copyWith(dokusPath: [..._entry.dokusPath, filename]);
                    });
                    ref.read(projectSourceProvider.notifier).state = [
                      ...ref.watch(projectSourceProvider),
                      (filename, image),
                    ];
                    log(ref.watch(projectSourceProvider)[0].$1);
                  }
                },
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Bild wählen'),
              IconButton(
                icon: const Icon(Icons.image, size: 70),
                onPressed: () async {
                  final image = await Utilits.pickImageFromGalery(context);
                  if (image != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          ' Bild ausgewählt',
                          style: TextStyle(
                            color: AppColor.kPrimaryButtonColor,
                          ),
                        ),
                        backgroundColor: AppColor.kPrimaryButtonColor,
                      ),
                    );
                    final filename = '$_project /${DateTime.timestamp()}';
                    setState(() {
                      _entry = _entry.copyWith(dokusPath: [..._entry.dokusPath, filename]);
                      ref.read(projectSourceProvider.notifier).state = [
                        ...ref.watch(projectSourceProvider),
                        (filename, image),
                      ];
                    });
                    log(ref.watch(projectSourceProvider).length.toString());
                    // }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: LabeledInputWidget(
        label: 'BESCHREBUNG',
        child: SizedBox(
          height: 80,
          child: TextField(
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
                borderSide: BorderSide(color: AppColor.kPrimaryButtonColor),
              ),
            ),
            onChanged: (value) {
              _descriptionController.text = value;
              _entry = _entry.copyWith(description: value);
            },
          ),
        ),
      ),
    );
  }

  Padding _submitInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SymmetricButton(
        color: AppColor.kPrimaryButtonColor,
        text: 'Eintrag erstellen',
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        onPressed: () {
          if (_dayPickerController.text.isEmpty) {
            return ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bitte wähle ein anderes Datum'),
              ),
            );
          } else if (_project == 'Wählen') {
            return ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Bitte wähle einen Kunde und Projekt'),
              ),
            );
          }
          if (_dayPickerController.text.isNotEmpty && _project != 'Wählen') {
            log(_entry.toJson().toString());
            ref.read(projectProvider.notifier).addProject(_entry);
            ref.read(dokuViewProvider.notifier).state = DokuViews.consumables;
          }
        },
      ),
    );
  }

  Padding _buildCustomerProjectField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
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
              setState(() {
                _project = e!;
                _entry = _entry.copyWith(name: e);
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _dayInputWidget(Dictionary language) {
    return LabeledInputWidget(
        label: language.date,
        child: TextField(
          controller: _dayPickerController,
          keyboardType: TextInputType.datetime,
          onTap: () async {
            final date = await Utilits.selecetDate(context);
            if (date != null) {
              setState(() {
                _dayPickerController.text = '${date.day}.${date.month}.${date.year}';
                _entry = _entry.copyWith(createDate: date);
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
                  borderSide: BorderSide(color: AppColor.kPrimaryButtonColor))),
        ));
  }
}

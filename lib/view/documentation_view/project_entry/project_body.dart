// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/projectVM/project.dart';
import 'package:handwerker_app/provider/doku_provider/time_provider.dart';
import 'package:handwerker_app/provider/language_provider/language_provider.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labeld_textfield.dart';

class ProjectBody extends ConsumerStatefulWidget {
  const ProjectBody({super.key});

  @override
  ConsumerState<ProjectBody> createState() => _DokumentationBodyState();
}

class _DokumentationBodyState extends ConsumerState<ProjectBody> {
  final TextEditingController _dayPickerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Project _entry = Project(createDate: DateTime.now());
  static const customerProject = [
    ' Wählen',
    ' Koch / Fenster Montage',
    ' Meier/ Bad verfliesen',
    ' Berger/ Putzen',
  ];
  // static const services = ['Wählen', 'Fenster Montage', 'Bad fliesen', 'Reinigung'];
  String _project = customerProject.first;
  // String _executedService = services.first;
  File? _file;
  bool _isStorageSource = true;

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
        _project = customerProject.firstWhere(
          (element) => element == lastTimeEntry.projectID,
        );
      }
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
                        backgroundColor: AppColor.kPrimaryButtonColor,
                      ),
                    );
                    setState(() {
                      _file = image;
                      _isStorageSource = false;
                    });
                    // }
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
                    setState(() {
                      _file = image;
                      _isStorageSource = false;
                    });
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
          // switch (_isStorageSource) {
          //   case true:
          //     ref.read(dokuProvider.notifier).saveGalleryFile(galleryFile: _file);
          //     break;
          //   default:
          //     ref.read(dokuProvider.notifier).saveStorageFile(storageFile: _file);
          //     break;
          // }

          // if (_startController.text.isEmpty || _endController.text.isEmpty) {
          //   return ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('Bitte gib Start und eine Endzeit an'),
          //     ),
          //   );
          // } else if (_project == 'Wählen' || _executedService == 'Wählen') {
          //   return ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('Bitte wähle einen Kunde/Projekt und eine Leistung'),
          //     ),
          //   );
          // } else {
          //   final execution = _createExecution();
          //   collection.saveStart(start: execution.start);
          //   collection.saveDescription(description: execution.descritpion);
          //   collection.saveProject(project: execution.project);
          //   collection.saveEnd(end: execution.end);
          //   collection.saveService(service: execution.service);
          //   collection.saveUser(users: execution.users);
          // }
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
              setState(() => _project = e!);
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

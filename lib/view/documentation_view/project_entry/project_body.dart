// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/projectVM/project.dart';
import 'package:handwerker_app/provider/doku_provider/project_provider.dart';
import 'package:handwerker_app/provider/doku_provider/source_provider.dart';
import 'package:handwerker_app/provider/language_provider/language_provider.dart';
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
  late Project _entry;
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
    setState(() {
      _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
      _entry = Project(createDate: now);
    });
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            _dayInputWidget(),
            _buildCustomerProjectField(),
            _buildChooseMedai(),
            _buildDescription(),
            const SizedBox(height: 38),
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

  Container _buildChooseMedai() => Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        height: 150,
        decoration: BoxDecoration(
          color: AppColor.kTextfieldBorder,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(ref.watch(languangeProvider).makePicture),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, size: 75),
                      onPressed: () async {
                        final image = await Utilits.pickImageFromCamera(context);
                        if (image != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                ref.watch(languangeProvider).pictureSucces,
                              ),
                              backgroundColor: AppColor.kPrimaryButtonColor,
                            ),
                          );
                          final filename = '$_project /${DateTime.timestamp()}.jpg';
                          setState(() {
                            _entry = _entry.copyWith(dokusPath: [..._entry.dokusPath, filename]);
                          });
                          ref.read(projectSourceProvider.notifier).state = [
                            ...ref.watch(projectSourceProvider),
                            (filename, image),
                          ];
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(ref.watch(languangeProvider).takePicture),
                    IconButton(
                      icon: const Icon(Icons.image, size: 70),
                      onPressed: () async {
                        final image = await Utilits.pickImageFromGalery(context);
                        if (image != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                ref.watch(languangeProvider).pictureSucces,
                                style: TextStyle(
                                  color: AppColor.kPrimaryButtonColor,
                                ),
                              ),
                              backgroundColor: AppColor.kPrimaryButtonColor,
                            ),
                          );
                          //TODO: check to translate file to a JPG with mime or something else
                          final filename = '$_project /${DateTime.timestamp()}.jpg';
                          setState(() {
                            _entry = _entry.copyWith(dokusPath: [..._entry.dokusPath, filename]);
                            ref.read(projectSourceProvider.notifier).state = [
                              ...ref.watch(projectSourceProvider),
                              (filename, image),
                            ];
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            Text(
              ref.watch(projectSourceProvider).isEmpty
                  ? ''
                  : '${ref.watch(projectSourceProvider).length} Bilder ausgewählt',
              style: ref.watch(projectSourceProvider).isEmpty
                  ? const TextStyle(fontSize: 0)
                  : Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      );

  Padding _buildDescription() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: LabeledInputWidget(
          label: ref.watch(languangeProvider).description,
          child: SizedBox(
            height: 80,
            child: TextField(
              controller: _descriptionController,
              textAlignVertical: TextAlignVertical.top,
              expands: true,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: null,
              decoration: Utilits.textFieldDecorator(context),
              onChanged: (value) {
                _descriptionController.text = value;
                _entry = _entry.copyWith(description: value);
              },
            ),
          ),
        ),
      );

  Padding _submitInput() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SymmetricButton(
          color: AppColor.kPrimaryButtonColor,
          text: ref.watch(languangeProvider).createEntry,
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
              ref.read(projectProvider.notifier).addProject(_entry);
            }
          },
        ),
      );

  Padding _buildCustomerProjectField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: LabeledInputWidget(
          label: 'KUNDE/PROJEKT',
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

  Widget _dayInputWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LabeledInputWidget(
        label: ref.watch(languangeProvider).date,
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
          decoration: Utilits.textFieldDecorator(context),
        ),
      ),
    );
  }
}

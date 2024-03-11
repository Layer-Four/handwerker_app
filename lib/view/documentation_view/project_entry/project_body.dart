// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/project_vm/project.dart';
import 'package:handwerker_app/provider/doku_provider/project_provider.dart';
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
  static const _customerProject = [
    ' Wählen',
    ' Koch / Fenster Montage',
    ' Meier/ Bad verfliesen',
    ' Berger/ Putzen',
  ];
  String _project = _customerProject.first;

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
                        final image = await Utilits.pickImageFromCamera(context, _project);
                        if (image != null) {
                          log('returned paht ${image}');
                          //TODO: Maybe show image in popUp?
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                ref.watch(languangeProvider).pictureSucces,
                              ),
                              backgroundColor: AppColor.kPrimaryButtonColor,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Image.file(
                              File(image),
                              height: 100,
                              width: 100,
                            ),
                          ));
                          setState(() {
                            _entry = _entry.copyWith(
                              imageUrl: [..._entry.imageUrl, image],
                            );
                          });
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
                        final image = await Utilits.pickImageFromGalery(context, _project);
                        if (image != null) {
                          log('imagepath: $image');
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
                          setState(() {
                            _entry = _entry.copyWith(
                              imageUrl: [..._entry.imageUrl, image],
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            Text(
              _entry.imageUrl.isEmpty
                  ? ''
                  : '${_entry.imageUrl.length} ${ref.watch(languangeProvider).choosedImage}',
              style: _entry.imageUrl.isEmpty
                  ? const TextStyle(fontSize: 0)
                  : Theme.of(context).textTheme.labelSmall,
            ),
          ],
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
                  _entry = _entry.copyWith(name: e);
                });
              },
            ),
          ),
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

  Padding _submitInput() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SymmetricButton(
          color: AppColor.kPrimaryButtonColor,
          text: ref.watch(languangeProvider).createEntry,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          onPressed: () {
            if (_dayPickerController.text.isEmpty) {
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(ref.watch(languangeProvider).plsChooseDay),
                ),
              );
              // TODO: change wählen to an editable object
            } else if (_project == ' Wählen') {
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(ref.watch(languangeProvider).plsChooseProject),
                ),
              );
            }
            if (_dayPickerController.text.isNotEmpty && _project != ' Wählen') {
              ref.read(projectProvider.notifier).addProject(_entry);
              final now = DateTime.now();
              setState(() {
                _project = _customerProject.first;
                _descriptionController.clear();
                _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
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
}

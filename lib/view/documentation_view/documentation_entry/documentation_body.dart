// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/project_models/project_dm/project_entry.dart';
import 'package:handwerker_app/models/project_models/project_list_vm/project_list.dart';
import 'package:handwerker_app/provider/doku_provider/project_provider.dart';
import 'package:handwerker_app/provider/settings_provider/language_provider.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labelt_textfield.dart';

class DocumentationBody extends ConsumerStatefulWidget {
  const DocumentationBody({super.key});

  @override
  ConsumerState<DocumentationBody> createState() => _DocumentationBodyState();
}

class _DocumentationBodyState extends ConsumerState<DocumentationBody> {
  final TextEditingController _dayPickerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late ProjectEntry _entry;
  bool isProjectSet = false;

  ProjectListVM? _project;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    setState(() {
      _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
      _entry = ProjectEntry(
        createDate: now,
      );
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
            const SizedBox(height: 56),
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
        height: 145,
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
                        final image =
                            await Utilits.pickImageFromCamera(context, _project?.title ?? '');
                        if (image != null) {
                          log(image);
                          // log('image was successfully convert to Base64');
                          //TODO: Maybe show image in popUp?
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //       ref.watch(languangeProvider).pictureSucces,
                          //     ),
                          //     backgroundColor: AppColor.kPrimaryButtonColor,
                          //   ),
                          // );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.transparent,
                            content: Image.memory(
                              base64Decode(image),
                              height: 100,
                              width: 100,
                            ),
                          ));
                          setState(() {
                            _entry = _entry.copyWith(
                              imageUrl: [image],
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
                        final image =
                            await Utilits.pickImageFromGalery(context, _project?.title ?? '');
                        if (image != null) {
                          log('image are successfully translate to Base64');
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
                              imageUrl: [image],
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

  Widget _buildCustomerProjectField() {
    return ref.read(projectProvider).when(
          error: (error, stackTrace) {
            log('error occurent in buildServieDropdown in TimeEntryBody-> $error \n\n this was the stack $stackTrace');
            return const SizedBox(child: Text('Etwas lief schief'));
          },
          loading: () => const CircularProgressIndicator(),
          data: (data) {
            if (data == null) {
              ref.read(projectProvider.notifier).loadpProject();
            }
            final projects = data;
            if (projects != null && !isProjectSet) {
              setState(() {
                _project = projects.first;
                _entry = _entry.copyWith(
                  projectID: projects.first.id,
                  projectName: projects.first.title,
                );
                isProjectSet = true;
              });
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      ref.watch(languangeProvider).customerProject,
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
                          _entry = _entry.copyWith(
                            projectID: e.id,
                            projectName: e.title,
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
              //  LabeledInputWidget(
              //   label:
              //   child:
              // ),
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
  Widget _dayInputWidget() => LabeldTextfield(
        label: ref.watch(languangeProvider).date,
        textInputType: TextInputType.datetime,
        controller: _dayPickerController,
        onTap: () async {
          final date = await Utilits.selecetDate(context);
          if (date != null) {
            setState(() {
              _entry = _entry.copyWith(createDate: date);
              _dayPickerController.text = '${date.day}.${date.month}.${date.year}';
            });
          }
        },
      );

  Widget _submitInput() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SymmetricButton(
          color: AppColor.kPrimaryButtonColor,
          text: ref.watch(languangeProvider).createEntry,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          onPressed: () {
            if (_entry.imageUrl.isEmpty) {
              log((_entry.toJson().toString()));
            }
            if (_dayPickerController.text.isEmpty) {
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(ref.watch(languangeProvider).plsChooseDay),
                ),
              );
            }
            if (_dayPickerController.text.isNotEmpty) {
              // log(json.encode(_entry.toJson()));
              ref.read(projectProvider.notifier).uploadProjectEntry(_entry);
              final now = DateTime.now();
              setState(() {
                _descriptionController.clear();
                _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
                _entry = ProjectEntry(
                    projectID: _project!.id,
                    projectName: null,
                    imageUrl: [],
                    description: null,
                    createDate: DateTime.now());
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

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/dokumentation_models/documentation_entry/documentation_entry.dart';
import 'package:handwerker_app/models/project_models/project_list_vm/project_list.dart';
import 'package:handwerker_app/provider/doku_provider/documentation_provider.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';
import 'package:handwerker_app/provider/settings_provider/settings_provider.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labelt_textfield.dart';
import 'package:handwerker_app/view/widgets/waiting_message_widget.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentationBody extends ConsumerStatefulWidget {
  const DocumentationBody({super.key});

  @override
  ConsumerState<DocumentationBody> createState() => _DocumentationBodyState();
}

class _DocumentationBodyState extends ConsumerState<DocumentationBody> {
  final TextEditingController _dayPickerController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late DocumentationEntry _entry;
  bool isProjectSet = false;

  ProjectListVM? _project;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    setState(() {
      _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
      _entry = DocumentationEntry(
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
                    Text(ref.watch(settingsProv).dictionary.makePicture),
                    IconButton(
                      icon: const Icon(Icons.camera_alt, size: 75),
                      onPressed: () async {
                        final image = await Utilits.pickImage(context, _project?.title ?? '',
                            permission: Permission.camera);
                        if (image != null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.transparent,
                            content: Image.file(
                              File(image.path),
                              height: 100,
                              width: 150,
                            ),
                          ));
                          setState(() {
                            _entry = _entry.copyWith(
                              imageUrl: [..._entry.imageUrl, image.path],
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
                    Text(ref.watch(settingsProv).dictionary.takePicture),
                    IconButton(
                      icon: const Icon(Icons.image, size: 70),
                      onPressed: () async {
                        final image = await Utilits.pickImage(
                          context,
                          _project?.title ?? '',
                          permission: Permission.storage,
                        );
                        if (image != null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.transparent,
                            content: Image.file(
                              File(image.path),
                              height: 100,
                              width: 150,
                            ),
                          ));
                          setState(() {
                            _entry = _entry.copyWith(
                              imageUrl: [..._entry.imageUrl, image.path],
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
                  : '${_entry.imageUrl.length} ${ref.watch(settingsProv).dictionary.choosedImage}',
              style: _entry.imageUrl.isEmpty
                  ? const TextStyle(fontSize: 0)
                  : Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      );

  Widget _buildCustomerProjectField() {
    return ref.watch(projectVMProvider).isEmpty
        ? WaitingMessageWidget('Warte')
        :
        // .when(
        //       error: (error, stackTrace) {
        //         log('error occurent in buildServieDropdown in TimeEntryBody-> $error \n\n this was the stack $stackTrace');
        //         return const SizedBox(child: Text('Etwas lief schief'));
        //       },
        //       loading: () => const CircularProgressIndicator(),
        //       data: (data) {
        //         if (data == null) {
        //           ref.read(projectVMProvider.notifier).loadpProject();
        //         }
        //         final projects = data;
        //         if (projects != null && !isProjectSet) {
        //           setState(() {
        //             _project = projects.first;
        //             _entry = _entry.copyWith(
        //               projectID: projects.first.id,
        //               projectName: projects.first.title,
        //             );
        //             isProjectSet = true;
        //           });
        //         }
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    ref.watch(settingsProv).dictionary.customerProject,
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
                    items: ref
                        .watch(projectVMProvider.notifier)
                        .customer
                        .map(
                          (e) => DropdownMenuItem(
                            alignment: Alignment.center,
                            value: e,
                            // TODO: change to attribute from obkect
                            child: Text(' e.title'),
                            // child: Text(' ${e.title}'),
                          ),
                        )
                        .toList(),
                    onChanged: (e) {
                      setState(() {
                        // _project = e;
                        // _entry = _entry.copyWith(
                        //   projectID: e.id,
                        //   projectName: e.title,
                        // );
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
  }

  Widget _buildDescription() => LabeldTextfield(
        heigt: 80,
        textInputAction: TextInputAction.newline,
        textInputType: TextInputType.multiline,
        label: ref.watch(settingsProv).dictionary.description,
        controller: _descriptionController,
        onChanged: (value) {
          setState(() {
            TextSelection previousSelection = _descriptionController.selection;
            _descriptionController.text = value;
            _descriptionController.selection = previousSelection;
            _entry = _entry.copyWith(description: _descriptionController.text);
          });
        },
      );
  Widget _dayInputWidget() => LabeldTextfield(
        label: ref.watch(settingsProv).dictionary.date,
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
          text: ref.watch(settingsProv).dictionary.createEntry,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          onPressed: () {
            if (_dayPickerController.text.isEmpty) {
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(ref.watch(settingsProv).dictionary.plsChooseDay),
                ),
              );
            }
            if (_dayPickerController.text.isNotEmpty) {
              ref.read(documentationProvider.notifier).createDocumentationEntry(_entry);
              final now = DateTime.now();
              setState(() {
                _descriptionController.clear();
                _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
                _entry = DocumentationEntry(
                    projectID: _project!.id,
                    projectName: null,
                    imageUrl: [],
                    description: null,
                    createDate: DateTime.now());
              });
              return ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(ref.watch(settingsProv).dictionary.succes),
                ),
              );
            }
          },
        ),
      );
}

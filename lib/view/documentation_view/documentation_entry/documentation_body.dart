import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../constants/apptheme/app_colors.dart';
import '../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../models/project_models/project_short_vm/project_short_vm.dart';
import '../../../provider/doku_provider/documentation_provider.dart';
import '../../../provider/settings_provider/settings_provider.dart';
import '../../widgets/choose_media_widget.dart';
import '../../widgets/custom_datepicker_widget.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/symetric_button_widget.dart';
import '../time_entry/widgets/choose_customer_widget.dart';

class DocumentationBody extends ConsumerStatefulWidget {
  const DocumentationBody({super.key});

  @override
  ConsumerState<DocumentationBody> createState() => _DocumentationBodyState();
}

class _DocumentationBodyState extends ConsumerState<DocumentationBody> {
  late final TextEditingController _dayPickerController, _descriptionController;

  @override
  void initState() {
    super.initState();
    _dayPickerController =
        TextEditingController(text: DateFormat('dd.MM.y').format(DateTime.now()));
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _dayPickerController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  late final dictionary = ref.watch(settingsProv).dictionary;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            CustomDatePicker(
              controller: _dayPickerController,
              initDate: DateTime.now(),
              title: dictionary.date,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColor.kTextfieldBorder),
              ),
            ),
            ref.watch(documentationProvider).customers.isEmpty
                ? GestureDetector(
                    onTap: () => ref.watch(documentationProvider).customers.isEmpty
                        ? ref.read(documentationProvider.notifier).getAllCustomer()
                        : null,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Center(child: Text(dictionary.loadData)),
                    ),
                  )
                : ChooseCustomer<CustomerShortDM>(
                    title: dictionary.customer,
                    items: ref
                        .watch(documentationProvider)
                        .customers
                        .map(
                          (e) => DropdownMenuItem(
                            alignment: Alignment.center,
                            value: e,
                            child: Text(' ${e.companyName}'),
                          ),
                        )
                        .toList(),
                    onChanged: (e) => ref.read(documentationProvider.notifier).updateCustomer(e),
                    value: ref.watch(documentationProvider.notifier).currentCustomer,
                  ),
            ChooseCustomer<ProjectShortVM>(
              title: dictionary.projectUpperCase,
              items: ref
                  .watch(documentationProvider.notifier)
                  .projects
                  .map(
                    (e) => DropdownMenuItem(
                      alignment: Alignment.center,
                      value: e,
                      child: Text(' ${e.title}'),
                    ),
                  )
                  .toList(),
              onChanged: (e) {
                ref.read(documentationProvider.notifier).updateProject(e);
              },
              value: ref.watch(documentationProvider).project,
            ),
            const ChooseMediaWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomTextfield(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.kTextfieldBorder),
                  borderRadius: BorderRadius.circular(6),
                ),
                title: dictionary.description,
                widgetWidth: MediaQuery.of(context).size.width,
                textfieldHeight: 80,
                controller: _descriptionController,
                isMultiLine: true,
              ),
            ),
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.kTextfieldBorder),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Center(
                child: Text('Hier könnte ihre Unterschrift stehen'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SymmetricButton(
                color: AppColor.kPrimaryButtonColor,
                text: dictionary.createEntry,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                onPressed: _checkAndSubmit,
              ),
            ),
            SizedBox(
              height: 70,
              child: Center(
                child: Image.asset('assets/images/img_techtool.png', height: 20),
              ),
            ),
          ],
        ),
      );

  _checkAndSubmit() {
    if (_dayPickerController.text.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(dictionary.plsChooseDay)),
      );
    }
    if (ref.watch(documentationProvider).project == null) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(dictionary.plsChooseProject)),
      );
    }
    if (_dayPickerController.text.isNotEmpty && ref.watch(documentationProvider).project != null) {
      final d = _dayPickerController.text.split('.').map((e) => int.parse(e)).toList();
      ref.read(documentationProvider.notifier).updateDocumentation(
            description: _descriptionController.text,
            createDate: DateTime(d[2], d[1], d[0]),
          );
      ref.read(documentationProvider.notifier).createDocumentationEntry().then((e) {
        _descriptionController.clear();
        _dayPickerController.text = DateFormat('d.M.y').format(DateTime.now());
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text(e ? dictionary.succes : dictionary.failed),
            ),
          ),
        );
      });
    }
  }
}

  // Container _buildChooseMedai() => Container(
  //       padding: const EdgeInsets.symmetric(vertical: 6),
  //       height: 150,
  //       decoration: BoxDecoration(
  //         color: AppColor.kTextfieldBorder,
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(dictionary.makePicture),
  //                   IconButton(
  //                     icon: const Icon(Icons.camera_alt, size: 75),
  //                     onPressed: () async {
  //                       final image = await Utilits.pickImage(
  //                         context,
  //                         permission: Permission.camera,
  //                       );
  //                       if (image != null) {
  //                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                           backgroundColor: Colors.transparent,
  //                           content: Image.file(
  //                             File(image.path),
  //                             height: 100,
  //                             width: 150,
  //                           ),
  //                         ));
  //                         ref.read(documentationProvider.notifier).updateDocumentation(
  //                           imageUrl: [
  //                             ...ref.watch(documentationProvider).docu.imageUrl,
  //                             image.path,
  //                           ],
  //                         );
  //                       }
  //                     },
  //                   ),
  //                 ],
  //               ),
  //               Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(dictionary.takePicture),
  //                   IconButton(
  //                     icon: const Icon(Icons.image, size: 70),
  //                     onPressed: () async {
  //                       final image = await Utilits.pickImage(
  //                         context,
  //                         permission: Permission.storage,
  //                       );
  //                       if (image != null) {
  //                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                           backgroundColor: Colors.transparent,
  //                           content: Image.file(
  //                             File(image.path),
  //                             height: 100,
  //                             width: 150,
  //                           ),
  //                         ));
  //                         ref.read(documentationProvider.notifier).updateDocumentation(
  //                           imageUrl: [
  //                             ...ref.watch(documentationProvider).docu.imageUrl,
  //                             image.path,
  //                           ],
  //                         );
  //                       }
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           Text(
  //             ref.watch(documentationProvider).docu.imageUrl.isEmpty
  //                 ? ''
  //                 : '${ref.watch(documentationProvider).docu.imageUrl.length} ${dictionary.choosedImage}',
  //             style: ref.watch(documentationProvider).docu.imageUrl.isEmpty
  //                 ? const TextStyle(fontSize: 0)
  //                 : Theme.of(context).textTheme.labelSmall,
  //           ),
  //         ],
  //       ),
  //     );
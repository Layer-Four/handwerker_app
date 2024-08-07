import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/provider/doku_provider/documentation_provider.dart';
import 'package:handwerker_app/view/documentation_view/documentation_entry/signature.dart';
import 'package:handwerker_app/view/widgets/choose_media_widget.dart';
import 'package:intl/intl.dart';

import '../../../constants/apptheme/app_colors.dart';
import '../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../models/project_models/project_short_vm/project_short_vm.dart';
import '../../../provider/settings_provider/settings_provider.dart';
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
  Uint8List? _signature;

  @override
  void initState() {
    super.initState();
    _dayPickerController = TextEditingController(text: DateFormat('dd.MM.y').format(DateTime.now()));
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
                    value: ref.watch(documentationProvider.notifier).currentCustomer,
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
                  ),
            ChooseCustomer<ProjectShortVM>(
              title: dictionary.projectUpperCase,
              value: ref.watch(documentationProvider).project,
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
              onChanged: (e) => ref.read(documentationProvider.notifier).updateProject(e),
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
            GestureDetector(
              onDoubleTap: () async {
                final signature = await showDialog<Uint8List?>(
                  context: context,
                  builder: (context) {
                    return const SignaturePopUpWidget();
                  },
                );

                if (signature != null) {
                  setState(() {
                    _signature = signature;
                  });
                }
              },
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.kTextfieldBorder),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: _signature == null
                    ? const Center(child: Text('Hier könnte ihre Unterschrift stehen'))
                    : Image.memory(_signature!),
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

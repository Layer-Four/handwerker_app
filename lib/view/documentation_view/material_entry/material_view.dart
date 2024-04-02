// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/models/consumable_models/consumable_entry/consumable_entry.dart';
import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';
import 'package:handwerker_app/models/project_models/project_list_vm/project_list.dart';
import 'package:handwerker_app/provider/doku_provider/consumable_provider.dart';
import 'package:handwerker_app/provider/doku_provider/material_vm_provider.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';
import 'package:handwerker_app/provider/settings_provider/language_provider.dart';
import 'package:handwerker_app/view/widgets/logo_widget.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labelt_textfield.dart';

class MaterialBody extends ConsumerStatefulWidget {
  const MaterialBody({super.key});

  @override
  ConsumerState<MaterialBody> createState() => _MaterialBodyState();
}

class _MaterialBodyState extends ConsumerState<MaterialBody> {
  final TextEditingController _dayPickerController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _summeryController = TextEditingController();
  late ConsumealbeEntry _entry;
  String _unit = _units.first;
  bool _isProjectSet = false;
  bool _isMaterialsLoaded = false;
  static const _units = [
    ' Stk',
    ' CM',
    ' KG',
    ' Liter',
    ' Meter',
  ];

  List<MaterialVM> _materials = [];
  ProjectListVM? _project;
  MaterialVM? _selectedMaterial;

  @override
  void initState() {
    final now = DateTime.now();
    setState(() {
      _entry = ConsumealbeEntry(createDate: now);
      _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          _dayInputWidget(),
          _chooseCustomerProjectField(),
          _chooseMaterialField(),
          _buildAmountPriceFields(),
          const SizedBox(height: 184),
          _submitInput(),
          const SizedBox(
            height: 70,
            child: Center(
              child: LogoWidget(
                assetString: 'assets/images/img_techtool.png',
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountPriceFields() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          child: Text(
                            ref.watch(languangeProvider).amount,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: SizedBox(
                            width: 60,
                            height: 30,
                            child: DropdownButton(
                              menuMaxHeight: 350,
                              underline: const SizedBox(),
                              isExpanded: true,
                              value: _unit,
                              items: _units
                                  .map(
                                    (e) => DropdownMenuItem(
                                      alignment: Alignment.center,
                                      value: e,
                                      child: Text(
                                        e,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: AppColor.kPrimary),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (e) => setState(() => _unit = e!),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 150,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.done,
                      controller: _amountController,
                      decoration: Utilits.textFieldDecorator(
                        context,
                        hintText: ref.watch(languangeProvider).amount,
                      ),
                      onChanged: (value) {
                        setState(() => _amountController.text = value);
                      },
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
                    child: Text(
                      ref.watch(languangeProvider).sum,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    width: 150,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      autofocus: false,
                      cursorHeight: 20,
                      textInputAction: TextInputAction.done,
                      controller: _summeryController,
                      decoration: Utilits.textFieldDecorator(
                        context,
                        hintText: '${ref.watch(languangeProvider).sum} €',
                      ),
                      onChanged: (value) {
                        setState(() {
                          // _entry = _entry.copyWith(cost: int.tryParse(value));
                          _summeryController.text = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  Widget _chooseCustomerProjectField() {
    return ref.read(projectVMProvider).when(
          error: (error, stackTrace) {
            log('error occurent in buildServieDropdown in TimeEntryBody-> $error \n\n this was the stack $stackTrace');
            return const SizedBox(child: Text('Etwas lief schief'));
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
                    child: Text(
                      ref.watch(languangeProvider).customerProject,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
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

  Widget _chooseMaterialField() {
    return ref.read(materialVMProvider).when(
          error: (err, stackTrace) {
            log('a error apeared $err');
            return const SizedBox.expand(
              child: Center(
                child:
                    Text('Leider ist ein Fehler aufgetretten bitte versuchen sie es später erneut'),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          data: (materials) {
            if (materials.isEmpty) {
              ref.read(materialVMProvider.notifier).loadMaterials();
            }
            if (materials.isNotEmpty && !_isMaterialsLoaded) {
              setState(() {
                _selectedMaterial = materials.first;
                _materials = materials;
                _isMaterialsLoaded = true;
              });
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(ref.watch(languangeProvider).material,
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 20, right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.kTextfieldBorder),
                    ),
                    child: DropdownButton(
                      menuMaxHeight: 350,
                      underline: const SizedBox.shrink(),
                      isExpanded: true,
                      value: _selectedMaterial,
                      items: _materials
                          .map(
                            (e) => DropdownMenuItem(
                              alignment: Alignment.center,
                              value: e,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      onChanged: (e) {
                        setState(() {
                          _selectedMaterial = e!;
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

  Widget _dayInputWidget() => LabeldTextfield(
        label: ref.watch(languangeProvider).date,
        controller: _dayPickerController,
        textInputType: TextInputType.datetime,
        onTap: () async {
          final date = await Utilits.selecetDate(context);
          if (date != null) {
            setState(() {
              _dayPickerController.text = '${date.day}.${date.month}.${date.year}';
              _entry = _entry.copyWith(createDate: date);
            });
          }
        },
      );

  Padding _submitInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SymmetricButton(
        color: AppColor.kPrimaryButtonColor,
        text: ref.watch(languangeProvider).createEntry,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        onPressed: () {
          final material = Consumable(
            // name: _selectedMaterial!.name,
            amount: int.tryParse(_amountController.text) ?? 1,
            price: int.tryParse(_summeryController.text) ?? 0,
          );
          _entry = _entry.copyWith(
            consumables: [..._entry.consumables, material],
            // cost: int.tryParse(_summeryController.text) ?? 0,
            // estimatedDuration: double.tryParse(_duration),
          );
          ref.read(consumableProvider.notifier).uploadConsumableEntry(_entry);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(ref.watch(languangeProvider).succes),
          ));
          final now = DateTime.now();
          setState(() {
            _selectedMaterial = _materials.first;
            _amountController.clear();
            _summeryController.clear();
            // _duration = _durationSteps.first;
            _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
          });
        },
      ),
    );
  }

  // Widget _addMoreMaterial() {
  //   return Row(
  //     children: [
  //       SymmetricButton(color: AppColor.kPrimaryButtonColor, text: '+'),
  //     ],
  //   );
  // }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/globals.dart';
import 'package:handwerker_app/provider/doku_provider/dokumentation_provider.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labeld_textfield.dart';

class MaterialBody extends ConsumerStatefulWidget {
  const MaterialBody({super.key});

  @override
  ConsumerState<MaterialBody> createState() => _MaterialBodyState();
}

class _MaterialBodyState extends ConsumerState<MaterialBody> {
  final TextEditingController _dayPickerController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _summeryController = TextEditingController();
  static const customerProject = [
    ' Wählen',
    ' Koch / Fenster Montage',
    ' Meier/ Bad verfliesen',
    ' Berger/ Putzen',
  ];
  static const _materials = [
    ' Wählen',
    ' Tür',
    ' PU-Schaum',
    ' Schrauben',
    ' Latte',
  ];
  String _project = customerProject.first;
  String _selectedMaterial = _materials.first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      final savedData = ref.watch(dokuProvider);
      if (savedData.isNotEmpty) {
        final startDate =
            savedData.where((element) => element.containsKey('start')).first.values.toList();
        log(startDate.toString());
      }
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
        child: Column(
          children: [
            _dayInputWidget(),
            _buildCustomerProjectField(),
            _buildMaterialField(),
            _buildAmountPriceFields(),
            _addMoreMaterial(),
            const SizedBox(height: 110),
            _submitInput(),
            SizedBox(
              child: Image.asset('assets/images/img_techtool.png', height: 70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountPriceFields() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallLabelInputWidget(
              label: 'MENGE',
              child: SizedBox(
                height: 35,
                child: TextField(
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.done,
                  controller: _amountController,
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
                      borderSide: BorderSide(color: AppColor.kBlue),
                    ),
                  ),
                  onChanged: (value) => setState(
                    () => _amountController.text = value,
                  ),
                ),
              ),
            ),
            SmallLabelInputWidget(
              label: 'SUMME',
              child: SizedBox(
                height: 35,
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  autofocus: false,
                  cursorHeight: 20,
                  textInputAction: TextInputAction.done,
                  controller: _summeryController,
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
                      borderSide: BorderSide(color: AppColor.kBlue),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    _summeryController.text = value;
                  }),
                ),
              ),
            ),
          ],
        ),
      );

  Padding _submitInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SymmetricButton(
        color: AppColor.kPrimaryColor,
        text: 'Eintrag erstellen',
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        onPressed: () {},
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

  Padding _buildMaterialField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: LabeledInputWidget(
        label: 'MATERIAL',
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.kTextfieldBorder),
          ),
          child: DropdownButton(
            underline: const SizedBox(),
            isExpanded: true,
            value: _selectedMaterial,
            items: _materials
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e)),
                )
                .toList(),
            onChanged: (e) {
              setState(() => _selectedMaterial = e!);
            },
          ),
        ),
      ),
    );
  }

  Widget _dayInputWidget() {
    return LabeledInputWidget(
        label: 'TAG',
        child: TextField(
          controller: _dayPickerController,
          keyboardType: TextInputType.datetime,
          onTap: () async {
            final date = await Utilits.selecetDate(context);
            if (date != null) {
              setState(() {
                _dayPickerController.text = '${date.day}.${date.month}.${date.year}';
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
                  borderSide: BorderSide(color: AppColor.kBlue))),
        ));
  }

  Widget _addMoreMaterial() {
    return Row(
      children: [
        SymmetricButton(color: AppColor.kPrimaryColor, text: '+'),
      ],
    );
  }
}

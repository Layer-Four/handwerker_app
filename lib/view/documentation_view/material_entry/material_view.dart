// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/provider/doku_provider/dokumentation_provider.dart';
import 'package:handwerker_app/provider/view_provider/view_provider.dart';
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
  String _unit = _units.first;
  static final _durationSteps = List.generate(20, (index) {
    return index * 0.5;
  });
  double _duration = _durationSteps.first;
  static const _units = [
    'Stk.',
    'CM',
    'KG',
    'Liter',
    'Meter',
  ];
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
  File? _file;
  bool _isStorageSource = false;

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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            _dayInputWidget(),
            _buildCustomerProjectField(),
            _buildMaterialField(),
            _buildAmountPriceFields(),

            _buildChooseMedai(),
            // const SizedBox(height: 10),
            _submitInput(),
            SizedBox(
              child: Image.asset('assets/images/img_techtool.png', height: 70),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildChooseMedai() {
    return Container(
      height: 160,
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
                      const SnackBar(content: Text(' Bild ausgewählt')),
                    );
                    setState(() {
                      _file = image;
                      _isStorageSource = true;
                    });
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountPriceFields() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                            child: Text('MENGE', style: Theme.of(context).textTheme.labelMedium),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SizedBox(
                              width: 50,
                              height: 30,
                              child: DropdownButton(
                                underline: const SizedBox(),
                                isExpanded: true,
                                value: _unit,
                                items: _units
                                    .map(
                                      (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .copyWith(color: AppColor.kPrimary),
                                          )),
                                    )
                                    .toList(),
                                onChanged: (e) {
                                  setState(() => _unit = e!);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        cursorHeight: 20,
                        textInputAction: TextInputAction.done,
                        controller: _amountController,
                        decoration: InputDecoration(
                          hintText: 'MENGE',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: AppColor.kTextfieldBorder),
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
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: Text(
                        'SUMME',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        cursorHeight: 20,
                        textInputAction: TextInputAction.done,
                        controller: _summeryController,
                        decoration: InputDecoration(
                          hintText: 'SUMME €',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: AppColor.kTextfieldBorder),
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
                          () {
                            _summeryController.text = value;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 400,
              height: 35,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text('Geschätze Dauer'),
                  ),
                  SizedBox(
                    width: 100,
                    // height: 100,
                    child: DropdownButton(
                        isExpanded: true,
                        value: _duration,
                        items: _durationSteps.map(
                          (e) {
                            final x =
                                '${e.toString().split('.').first},${e.toString().split('.').last}';
                            log(x.toString());
                            // String value = '';
                            // if (e.) {
                            //   final whole = (e / 2).toStringAsFixed(0);
                            //   value = '$whole,5';
                            // } else {
                            //   value = (e ~/ 2).toString();
                            // }

                            return DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            );
                          },
                        ).toList(),
                        onChanged: (e) => setState(() {
                              log(e.toString());
                              _duration = e!;
                            })),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Padding _submitInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SymmetricButton(
        color: AppColor.kPrimaryButtonColor,
        text: 'Eintrag erstellen',
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        onPressed: () {
          if (_file != null) {
            if (_isStorageSource) {
              ref.read(dokuProvider.notifier).saveGalleryFile(galleryFile: _file);
            } else {
              if (_file != null) {
                ref.read(dokuProvider.notifier).saveStorageFile(storageFile: _file);
              }
            }
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Success')));
          ref.read(dokuViewProvider.notifier).state = DokuViews.timeEntry;
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
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
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
        SymmetricButton(color: AppColor.kPrimaryButtonColor, text: '+'),
      ],
    );
  }
}

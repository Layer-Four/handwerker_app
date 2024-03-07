// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/consumable/consumable.dart';
import 'package:handwerker_app/models/consumableEntry/consumable_entry.dart';
import 'package:handwerker_app/provider/doku_provider/project_provider.dart';
import 'package:handwerker_app/provider/doku_provider/source_provider.dart';
import 'package:handwerker_app/provider/doku_provider/time_provider.dart';
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
  ConsumeEntry _entry = const ConsumeEntry();
  String _unit = _units.first;
  static final _durationSteps = List.generate(25, (index) {
    if (index == 0) return 'in Stunden';
    final x = (index * 0.5).toString().split('.');
    return '${x.first},${x.last} h.';
  });
  String _duration = _durationSteps.first;
  static const _units = [
    ' Stk',
    ' CM',
    ' KG',
    ' Liter',
    ' Meter',
  ];
  static const _customerProject = [
    ' Wählen',
    ' Koch / Fenster Montage',
    ' Meier/ Bad verfliesen',
    ' Berger/ Putzen',
  ];
  static const _materials = [
    ' Wählen',
    ' Tür',
    ' Fliesen',
    ' PU-Schaum',
    ' Schrauben',
    ' Latte',
  ];
  String _project = _customerProject.first;
  String _selectedMaterial = _materials.first;

  @override
  void initState() {
    final now = DateTime.now();
    setState(() {
      _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (mounted) {
      _preFillPage();
    }
    return Padding(
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
            height: 70,
            child: Center(
              child: Image.asset('assets/images/img_techtool.png', height: 20),
            ),
          ),
        ],
      ),
    );
  }

  _preFillPage() {
    // TODO: set default time? set default time equal to last time entry?
    final timeEntry = ref.watch(timeEntryProvider);
    final project = ref.watch((projectProvider));
    if (timeEntry.isNotEmpty) {
      final date = timeEntry.last!.date;
      setState(() {
        _dayPickerController.text = '${date.day}.${date.month}.${date.year}';
        _project = timeEntry.last!.projectID ?? _customerProject.first;
        _entry = _entry.copyWith(createDate: date);
      });
    } else {
      final now = DateTime.now();
      _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
    }
    if (project.isNotEmpty) {
      setState(() {
        _project = _customerProject.firstWhere((element) => element == project.last.name);
        _entry = _entry.copyWith(project: _project);
      });
    }
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
                    final name = '$_project /${DateTime.timestamp()}';
                    setState(() {
                      ref.read(consumableSourceProvider.notifier).state = [
                        ...ref.watch(consumableSourceProvider),
                        (name, image),
                      ];
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
                    final name = '$_project /${DateTime.timestamp()}';
                    setState(() {
                      ref.read(consumableSourceProvider.notifier).state = [
                        ...ref.watch(consumableSourceProvider),
                        (name, image),
                      ];
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
                            _entry = _entry.copyWith(cost: int.tryParse(value));
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
              width: 500,
              height: 35,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text('Geschätze Dauer'),
                  ),
                  SizedBox(
                    width: 150,
                    child: DropdownButton(
                        isExpanded: true,
                        value: _duration,
                        items: _durationSteps
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (e) => setState(
                              () => _duration = e!,
                            )),
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
          _entry = _entry.copyWith(
            consumables: [
              ..._entry.consumables,
              Consumable(
                name: _selectedMaterial,
                amount: int.tryParse(_amountController.text) ?? 1,
              )
            ],
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Success')));
          _selectedMaterial = _materials.first;
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
            items: _customerProject
                .map(
                  (e) => DropdownMenuItem(value: e, child: Text(e)),
                )
                .toList(),
            onChanged: (e) {
              setState(() {
                _project = e!;
                _entry = _entry.copyWith(project: e);
              });
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
              setState(() {
                _selectedMaterial = e!;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _dayInputWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LabeledInputWidget(
          label: 'TAG',
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
                    borderSide: BorderSide(color: AppColor.kBlue))),
          )),
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

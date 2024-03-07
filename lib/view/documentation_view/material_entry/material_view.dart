// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/consumable/consumable.dart';
import 'package:handwerker_app/models/consumable_entry/consumable_entry.dart';
import 'package:handwerker_app/provider/doku_provider/source_provider.dart';
import 'package:handwerker_app/provider/language_provider/language_provider.dart';
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
  late ConsumeEntry _entry;
  String _unit = _units.first;
  static final _durationSteps = List.generate(25, (index) {
    if (index == 0) return ' in Stunden';
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
      _entry = ConsumeEntry(createDate: now);
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
          _buildCustomerProjectField(),
          _buildMaterialField(),
          _buildAmountPriceFields(),
          _buildChooseMedai(),
          const SizedBox(height: 25),
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

  Widget _buildAmountPriceFields() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
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
                      width: 150,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            child: Text(
                              ref.watch(languangeProvider).amount,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: SizedBox(
                              width: 70,
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
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
                            _entry = _entry.copyWith(cost: int.tryParse(value));
                            _summeryController.text = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 390,
              height: 40,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Text(ref.watch(languangeProvider).estimatedDuration),
                  ),
                  SizedBox(
                    width: 210,
                    child: DropdownButton(
                        isExpanded: true,
                        value: _duration,
                        items: _durationSteps
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ))
                            .toList(),
                        onChanged: (e) {
                          setState(() => _duration = e!);
                        }),
                  ),
                ],
              ),
            )
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
                          ref.read(consumableSourceProvider.notifier).state = [
                            ...ref.watch(consumableSourceProvider),
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
              ref.watch(consumableSourceProvider).isEmpty
                  ? ''
                  : '${ref.watch(consumableSourceProvider).length} ${ref.watch(languangeProvider).choosedImage}',
              style: ref.watch(consumableSourceProvider).isEmpty
                  ? const TextStyle(fontSize: 0)
                  : Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      );

  Padding _buildCustomerProjectField() {
    return Padding(
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
                _entry = _entry.copyWith(project: e);
              });
            },
          ),
        ),
      ),
    );
  }

  Padding _buildMaterialField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: LabeledInputWidget(
          label: ref.watch(languangeProvider).material,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
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
                setState(() {
                  _selectedMaterial = e!;
                });
              },
            ),
          ),
        ),
      );

  Widget _dayInputWidget() => Padding(
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

  Padding _submitInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SymmetricButton(
        color: AppColor.kPrimaryButtonColor,
        text: ref.watch(languangeProvider).createEntry,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        onPressed: () {
          if (_project != ' Wählen' && _selectedMaterial != ' Wählen') {
            final material = Consumable(
              name: _selectedMaterial,
              amount: int.tryParse(_amountController.text) ?? 1,
            );
            _entry = _entry.copyWith(
              consumables: [..._entry.consumables, material],
              cost: int.tryParse(_summeryController.text) ?? 0,
              estimatedDuration: double.tryParse(_duration),
            );
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(ref.watch(languangeProvider).succes),
            ));
            final now = DateTime.now();
            setState(() {
              _project = _customerProject.first;
              _selectedMaterial = _materials.first;
              _amountController.clear();
              _summeryController.clear();
              ref.read(consumableSourceProvider.notifier).state = [];
              _duration = _durationSteps.first;
              _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(ref.watch(languangeProvider).checkInput),
            ));
          }
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

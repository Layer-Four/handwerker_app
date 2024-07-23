import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/language/dictionary.dart';
import '../../models/settings_state_model/setttings_state.dart';

final settingsProv = NotifierProvider<SettingsNotifer, SettingsState>(() => SettingsNotifer());

class SettingsNotifer extends Notifier<SettingsState> {
  @override
  SettingsState build() => const SettingsState();

  void changeLanguage(Dictionary? e) {
    if (e == null) return;
    final newState = state.copyWith(newLanguage: e);
    state = newState;
    return;
  }

  void changeThememode() {
    ThemeMode nextMode = switch (state.themeMode) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system
    };
    final newState = state.copyWith(nextMode: nextMode);
    state = newState;
    return;
  }
}




// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:handwerker_app/constants/apptheme/app_colors.dart';
// import 'package:handwerker_app/constants/utiltis.dart';
// import 'package:handwerker_app/models/consumable_models/consumable_entry/consumable_entry.dart';
// import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
// import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';
// import 'package:handwerker_app/models/consumable_models/unit_dm/unit_dm.dart';
// import 'package:handwerker_app/models/project_models/project_list_vm/project_list.dart';
// import 'package:handwerker_app/provider/doku_provider/consumable_provider.dart';
// import 'package:handwerker_app/provider/doku_provider/material_vm_provider.dart';
// import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';
// import 'package:handwerker_app/view/widgets/logo_widget.dart';
// import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
// import 'package:handwerker_app/view/widgets/textfield_widgets/labelt_textfield.dart';
// import 'package:handwerker_app/provider/settings_provider/language_provider.dart';
// import '../../../provider/settings_provider/settings_provider.dart';

// class MaterialBody extends ConsumerStatefulWidget {
//   const MaterialBody({super.key});

//   @override
//   ConsumerState<MaterialBody> createState() => _MaterialBodyState();
// }

// class _MaterialBodyState extends ConsumerState<MaterialBody> {
//   late final TextEditingController _dayPickerController, _amountController, _summeryController;
//   late final dictionary = ref.watch(settingsProv).dictionary;
//   late ConsumealbeEntry _entry;
//   UnitDM? _unit;
//   bool _isProjectSet = false, _isMaterialsLoaded = false;
//   List<UnitDM>? _units;

//   List<ConsumeableVM> _materials = [];
//   ProjectListVM? _project;
//   ConsumeableVM? _selectedMaterial;

//   @override
//   void initState() {
//     super.initState();
//     final now = DateTime.now();
//     setState(() {
//       _entry = ConsumealbeEntry(createDate: now);
//       _dayPickerController = TextEditingController(text: '${now.day}.${now.month}.${now.year}');
//       _amountController = TextEditingController();
//       _summeryController = TextEditingController();
//     });
//     _refreshUnits();
//     ref.read(materialVMProvider.notifier).loadMaterials();
//     ref.read(projectVMProvider.notifier).loadpProject();

//     // Add listeners for the text controllers to update the sum
//     _amountController.addListener(_updateSum);
//   }

//   @override
//   void dispose() {
//     _amountController.removeListener(_updateSum);
//     _amountController.dispose();
//     _dayPickerController.dispose();
//     _summeryController.dispose();
//     super.dispose();
//   }

//   void _updateSum() {
//     final double amount = double.tryParse(_amountController.text) ?? 0.0;
//     final double price = _selectedMaterial?.price ?? 0.0;
//     final double sum = amount * price;
//     setState(() {
//       _summeryController.text = sum.toStringAsFixed(2);
//     });
//   }

//   @override
//   @override
//   Widget build(BuildContext context) {
//     final materialsAsyncValue = ref.watch(materialVMProvider);

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//       child: Column(
//         children: [
//           _dayInputWidget(),
//           _chooseCustomerProjectField(),
//           _chooseMaterialField(materialsAsyncValue),
//           _buildAmountPriceFields(),
//           const SizedBox(height: 184),
//           _submitInput(),
//           const SizedBox(
//             height: 70,
//             child: Center(
//               child: LogoWidget(
//                 assetString: 'assets/images/img_techtool.png',
//                 size: 20,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Column _buildAmointElement() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 160,
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                 child: Text(
//                   dictionary.amount,
//                   style: Theme.of(context).textTheme.labelMedium,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 35,
//           width: 150,
//           child: TextField(
//             keyboardType: TextInputType.number,
//             autofocus: false,
//             cursorHeight: 20,
//             textInputAction: TextInputAction.done,
//             controller: _amountController,
//             decoration: Utilits.textFieldDecorator(
//               context,
//               hintText: dictionary.amount,
//             ),
//             onChanged: (value) {
//               if (_amountController.text.length > 20) {
//                 return;
//               }
//               if (_amountController.text.length <= 20) {
//                 setState(() => _amountController.text = value);
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAmountPriceFields() => Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _buildAmointElement(),
//           _buildSumElement(),
//         ],
//       );

//   Column _buildSumElement() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
//           child: Text(
//             dictionary.sum,
//             style: Theme.of(context).textTheme.labelMedium,
//           ),
//         ),
//         SizedBox(
//           height: 35,
//           width: 150,
//           child: TextField(
//             keyboardType: TextInputType.number,
//             autofocus: false,
//             cursorHeight: 20,
//             textInputAction: TextInputAction.done,
//             controller: _summeryController,
//             decoration: Utilits.textFieldDecorator(
//               context,
//               hintText: '${dictionary.sum} €',
//             ),
//             onChanged: (value) {
//               setState(() {
//                 if (value.length < 20) {
//                   _summeryController.text = value;
//                 }
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _chooseCustomerProjectField() {
//     return ref.read(projectVMProvider).when(
//           error: (error, stackTrace) {
//             log('error occurent in buildServieDropdown in MaterialEntryBody-> $error \n\n this was the stack $stackTrace');
//             return const SizedBox(child: Text('Etwas lief schief'));
//           },
//           loading: () => const CircularProgressIndicator.adaptive(),
//           data: (data) {
//             if (data == null) {
//               ref.read(projectVMProvider.notifier).loadpProject();
//             }
//             final projects = data;
//             if (projects != null && !_isProjectSet) {
//               setState(() {
//                 _project = projects.first;
//                 _entry = _entry.copyWith(projectID: projects.first.id);
//                 _isProjectSet = true;
//               });
//             }
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(4),
//                     child: Text(
//                       dictionary.customerProject,
//                       style: Theme.of(context).textTheme.labelMedium,
//                     ),
//                   ),
//                   Container(
//                     height: 40,
//                     padding: const EdgeInsets.only(left: 20, right: 15),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: AppColor.kTextfieldBorder),
//                     ),
//                     child: DropdownButton(
//                       menuMaxHeight: 350,
//                       underline: const SizedBox(),
//                       isExpanded: true,
//                       value: _project,
//                       items: projects
//                           ?.map(
//                             (e) => DropdownMenuItem(
//                               alignment: Alignment.center,
//                               value: e,
//                               child: Text(' ${e.title}'),
//                             ),
//                           )
//                           .toList(),
//                       onChanged: (e) {
//                         setState(() {
//                           _project = e!;
//                           _entry = _entry.copyWith(projectID: e.id);
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//   }

//   Widget _chooseMaterialField(AsyncValue<List<ConsumeableVM>> materialsAsyncValue) {
//     return materialsAsyncValue.when(
//       error: (err, stackTrace) {
//         log('error occurred in buildServiceDropdown in MaterialEntryBody-> $err \n\n this was the stack $stackTrace');
//         return const SizedBox.expand(
//           child: Center(child: Text('Etwas lief schief')),
//         );
//       },
//       loading: () => const CircularProgressIndicator(),
//       data: (materials) {
//         if (materials.isEmpty) {
//           ref.read(materialVMProvider.notifier).loadMaterials();
//         }
//         if (materials.isNotEmpty && !_isMaterialsLoaded) {
//           setState(() {
//             _selectedMaterial = materials.first;
//             _materials = materials;
//             _isMaterialsLoaded = true;
//             // Initialize the sum calculation
//             _updateSum();
//           });
//         }

//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(4),
//                 child:
//                     Text(ref.watch(settingsProv).dictionary.material, style: Theme.of(context).textTheme.labelMedium),
//               ),
//               Container(
//                 height: 40,
//                 padding: const EdgeInsets.only(left: 20, right: 15),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColor.kTextfieldBorder),
//                 ),
//                 child: DropdownButton<ConsumeableVM>(
//                   menuMaxHeight: 350,
//                   underline: const SizedBox.shrink(),
//                   isExpanded: true,
//                   value: _selectedMaterial,
//                   items: _materials
//                       .map(
//                         (e) => DropdownMenuItem(
//                           alignment: Alignment.center,
//                           value: e,
//                           child: Text(e.name),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (e) {
//                     setState(() {
//                       _selectedMaterial = e!;
//                       _amountController.text = _selectedMaterial!.amount.toString();
//                       // Update the sum in _summeryController
//                       _updateSum();
//                     });
//                   },
//                 ),
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _dayInputWidget() => LabeldTextfield(
//         label: dictionary.date,
//         controller: _dayPickerController,
//         textInputType: TextInputType.datetime,
//         onTap: () async {
//           final date = await Utilits.selecetDate(context);
//           if (date != null) {
//             setState(() {
//               _dayPickerController.text = '${date.day}.${date.month}.${date.year}';
//               _entry = _entry.copyWith(createDate: date);
//             });
//           }
//         },
//       );

//   void _refreshUnits() {
//     ref.read(consumableProvider.notifier).getUnits().then(
//           (value) => setState(() {
//             _units = value;
//             _unit = _units!.first;
//           }),
//         );
//   }

//   Padding _submitInput() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: SymmetricButton(
//         color: AppColor.kPrimaryButtonColor,
//         text: dictionary.createEntry,
//         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
//         onPressed: () {
//           final material = Consumable(
//             amount: int.tryParse(_amountController.text) ?? 1,
//             materialUnitID: _unit!.id,
//             price: int.tryParse(_summeryController.text) ?? 0,
//             materialID: _selectedMaterial!.id.toString(),
//           );
//           _entry = _entry.copyWith(
//             consumables: [material],
//           );
//           ref.read(consumableProvider.notifier).uploadConsumableEntry(_entry);
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(dictionary.succes),
//           ));
//           final now = DateTime.now();
//           setState(() {
//             _selectedMaterial = _materials.first;
//             _amountController.clear();
//             _summeryController.clear();
//             _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
//           });
//         },
//       ),
//     );
//   }
// }

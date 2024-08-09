import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:intl/intl.dart';
import '../../../constants/apptheme/app_colors.dart';
import '../../../models/project_models/project_short_vm/project_short_vm.dart';
import '../../../provider/doku_provider/consumable_provider.dart';
import '../../../provider/settings_provider/settings_provider.dart';
import '../../widgets/custom_datepicker_widget.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/symetric_button_widget.dart';
import '../time_entry/widgets/choose_customer_widget.dart';

class MaterialBody extends ConsumerStatefulWidget {
  const MaterialBody({super.key});

  @override
  ConsumerState<MaterialBody> createState() => _MaterialBodyState();
}

class _MaterialBodyState extends ConsumerState<MaterialBody> {
  late final TextEditingController _amountController, _dayPickerController, _summeryController;
  late final dictionary = ref.watch(settingsProv).dictionary;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '1');
    _dayPickerController = TextEditingController(
      text: DateFormat('dd.MM.y').format(DateTime.now()),
    );
    _summeryController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _dayPickerController.dispose();
    _summeryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            CustomDatePicker(
              width: MediaQuery.of(context).size.width,
              title: dictionary.date,
              controller: _dayPickerController,
            ),
            ref.watch(consumableProvider).customers.isEmpty
                ? Text(ref.watch(settingsProv).dictionary.loadData)
                : CustomerDropdown(
                    title: ref.watch(settingsProv).dictionary.customer,
                    value: ref.watch(consumableProvider).currentCustomer,
                    items: ref
                        .watch(consumableProvider)
                        .customers
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Center(child: Text(e.companyName)),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (e) => ref.read(consumableProvider.notifier).updateSeletedCustomer(e),
                  ),
            CustomerDropdown<ProjectShortVM>(
              title: dictionary.projectUpperCase,
              value: ref.watch(consumableProvider).project,
              items: ref
                  .watch(consumableProvider)
                  .customerProject
                  .map(
                    (e) => DropdownMenuItem(
                      alignment: Alignment.center,
                      value: e,
                      child: Center(child: Text(' ${e.title}')),
                    ),
                  )
                  .toList(),
              onChanged: (e) {
                ref.read(consumableProvider.notifier).updateSelectedProject(e);
              },
            ),
            CustomerDropdown<ConsumableDM>(
              title: dictionary.material,
              value: ref.watch(consumableProvider).consumable,
              items: ref
                  .watch(consumableProvider)
                  .consumables
                  .map((e) => DropdownMenuItem(
                        alignment: Alignment.center,
                        value: e,
                        child: Center(child: Text(' ${e.name}')),
                      ))
                  .toList(),
              onChanged: (e) => ref.read(consumableProvider.notifier).updateSelectedConsumable(e),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextfield(
                  title: dictionary.amount,
                  widgetWidth: MediaQuery.of(context).size.width * 0.40,
                  controller: _amountController,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.kTextfieldBorder),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                CustomTextfield(
                  title: dictionary.sum,
                  widgetWidth: MediaQuery.of(context).size.width * 0.40,
                  controller: _summeryController,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.kTextfieldBorder),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 170),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SymmetricButton(
                color: AppColor.kPrimaryButtonColor,
                text: dictionary.createEntry,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                onPressed: () => _submitInput(),
              ),
            ),
            const Center(
              child: LogoWidget(
                assetString: 'assets/images/img_techtool.png',
                size: 20,
              ),
            ),
          ],
        ),
      );

  void _submitInput() {
    final isValid = ref.read(consumableProvider.notifier).validState();
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte überpüfe deine Eingabe')),
      );
      return;
    }

    ref.read(consumableProvider.notifier).uploadConsumableEntry().then((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submission successful')),
      );
    });
  }
}

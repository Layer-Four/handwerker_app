import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/consumable_models/consumable_entry/consumable_entry.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';
import 'package:handwerker_app/models/consumable_models/unit_dm/unit_dm.dart';
import 'package:handwerker_app/models/language/dictionary.dart';
import 'package:handwerker_app/models/project_models/project_short_vm/project_short_vm.dart';
import 'package:handwerker_app/provider/doku_provider/consumable_provider.dart';
import 'package:handwerker_app/provider/doku_provider/material_vm_provider.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';
import 'package:handwerker_app/provider/settings_provider/settings_provider.dart';
import 'package:handwerker_app/view/widgets/logo_widget.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labelt_textfield.dart';

class MaterialBody extends ConsumerStatefulWidget {
  const MaterialBody({super.key});

  @override
  ConsumerState<MaterialBody> createState() => _MaterialBodyState();
}

class _MaterialBodyState extends ConsumerState<MaterialBody> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController(text: '1');
  final TextEditingController _summaryController = TextEditingController();

  late ConsumealbeEntry _entry;
  UnitDM? _unit;
  List<UnitDM>? _units;
  List<ConsumeableVM> _materials = [];
  ProjectShortVM? _project;
  ConsumeableVM? _selectedMaterial;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeEntry();
    _loadInitialData();
  }

  void _initializeControllers() {
    final now = DateTime.now();
    _dateController.text = _formatDate(now);
  }

  void _initializeEntry() {
    final now = DateTime.now();
    _entry = ConsumealbeEntry(createDate: now);
  }

  void _loadInitialData() {
    _refreshUnits();
    ref.read(materialVMProvider.notifier).loadMaterials();
    ref.read(projectVMProvider.notifier).loadpProject();
  }

  void _refreshUnits() {
    ref.read(consumableProvider.notifier).getUnits().then(
          (value) => setState(() {
            _units = value;
            _unit = _units?.first;
          }),
        );
  }

  String _formatDate(DateTime date) => '${date.day}.${date.month}.${date.year}';

  @override
  Widget build(BuildContext context) {
    final dictionary = ref.watch(settingsProv).dictionary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          _buildDateInput(dictionary),
          _buildProjectSelector(dictionary),
          _buildMaterialSelector(dictionary),
          _buildAmountAndPriceFields(dictionary),
          const SizedBox(height: 184),
          _buildSubmitButton(dictionary),
          _buildLogo(),
        ],
      ),
    );
  }

  Widget _buildDateInput(Dictionary dictionary) {
    return LabeldTextfield(
      label: dictionary.date,
      controller: _dateController,
      textInputType: TextInputType.datetime,
      onTap: () => _selectDate(context),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await Utilits.selecetDate(context);
    if (date != null) {
      setState(() {
        _dateController.text = _formatDate(date);
        _entry = _entry.copyWith(createDate: date);
      });
    }
  }

  Widget _buildProjectSelector(Dictionary dictionary) {
    final projects = ref.watch(projectVMProvider);
    return projects.isEmpty
        ? const Text('Lade Projekte...')
        : _buildDropdown(
            label: dictionary.customer,
            value: _project,
            items: projects
                .map((e) => DropdownMenuItem<ProjectShortVM>(
                      value: e,
                      child: Text(e.title ?? 'Untitled Projekt'),
                    ))
                .toList(),
            onChanged: (dynamic value) {
              if (value is ProjectShortVM) {
                setState(() {
                  _project = value;
                  _entry = _entry.copyWith(projectID: value.id);
                });
              }
            },
          );
  }

  Widget _buildMaterialSelector(Dictionary dictionary) {
    return ref.watch(materialVMProvider).when(
          data: (materials) {
            if (materials.isNotEmpty && _selectedMaterial == null) {
              _selectedMaterial = materials.first;
              _materials = materials;
            }
            return _buildDropdown(
              label: dictionary.material,
              value: _selectedMaterial,
              items: _materials
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text('${e.name}/ ${e.materialUnitName}'),
                      ))
                  .toList(),
              onChanged: (dynamic value) {
                if (value is ConsumeableVM) {
                  setState(() {
                    _selectedMaterial = value;
                    _updateSummary();
                  });
                }
              },
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
        );
  }

  Widget _buildDropdown({
    required String label,
    required dynamic value,
    required List<DropdownMenuItem<dynamic>> items,
    required Function(dynamic) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(label, style: Theme.of(context).textTheme.labelMedium),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.kTextfieldBorder),
            ),
            child: DropdownButton<dynamic>(
              value: value,
              items: items,
              onChanged: onChanged,
              isExpanded: true,
              underline: const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountAndPriceFields(Dictionary dictionary) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAmountField(dictionary),
        _buildSummaryField(dictionary),
      ],
    );
  }

  Widget _buildAmountField(Dictionary dictionary) {
    return _buildNumberField(
      label: dictionary.amount,
      controller: _amountController,
      onChanged: (value) {
        if (value.length <= 20) {
          setState(_updateSummary);
        }
      },
    );
  }

  Widget _buildSummaryField(Dictionary dictionary) {
    return _buildNumberField(
      label: dictionary.sum,
      controller: _summaryController,
      onChanged: (value) {
        if (value.length < 20) {
          setState(_updateSummary);
        }
      },
      suffix: '€',
    );
  }

  Widget _buildNumberField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
    String? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Text(label, style: Theme.of(context).textTheme.labelMedium),
        ),
        SizedBox(
          height: 35,
          width: 150,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            decoration: Utilits.textFieldDecoration(
              context,
              hintText: suffix != null ? '$label $suffix' : label,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  void _updateSummary() {
    final amount = int.tryParse(_amountController.text) ?? 1;
    final price = _selectedMaterial?.price ?? 0;
    _summaryController.text = (price * amount).toStringAsFixed(2);
  }

  Widget _buildSubmitButton(Dictionary dictionary) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SymmetricButton(
        color: AppColor.kPrimaryButtonColor,
        text: dictionary.createEntry,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
        onPressed: _submitEntry,
      ),
    );
  }

  void _submitEntry() {
    if (_selectedMaterial == null || _project == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a material and project')),
      );
      return;
    }

    final material = Consumable(
      amount: int.tryParse(_amountController.text) ?? 1,
      materialUnitID: _unit!.id,
      price: int.tryParse(_summaryController.text) ?? 0,
      materialID: _selectedMaterial!.id.toString(),
    );

    _entry = _entry.copyWith(
      consumables: [material],
      projectID: _project!.id,
    );

    ref.read(consumableProvider.notifier).uploadConsumableEntry(_entry);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ref.read(settingsProv).dictionary.succes)),
    );

    _resetForm();
  }

  void _resetForm() {
    final now = DateTime.now();
    setState(() {
      _selectedMaterial = _materials.first;
      _amountController.text = '1';
      _summaryController.clear();
      _dateController.text = _formatDate(now);
      _entry = ConsumealbeEntry(createDate: now);
    });
  }

  Widget _buildLogo() {
    return const SizedBox(
      height: 70,
      child: Center(
        child: LogoWidget(
          assetString: 'assets/images/img_techtool.png',
          size: 20,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    _amountController.dispose();
    _summaryController.dispose();
    super.dispose();
  }
}

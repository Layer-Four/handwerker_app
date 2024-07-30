import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handwerker_app/constants/apptheme/app_colors.dart';
import 'package:handwerker_app/constants/utiltis.dart';
import 'package:handwerker_app/models/consumable_models/consumable_entry/consumable_entry.dart';
import 'package:handwerker_app/models/consumable_models/consumable_vm/consumable.dart';
import 'package:handwerker_app/models/consumable_models/material_vm/material_vm.dart';
import 'package:handwerker_app/models/consumable_models/unit_dm/unit_dm.dart';
import 'package:handwerker_app/provider/doku_provider/consumable_provider.dart';
import 'package:handwerker_app/provider/doku_provider/material_vm_provider.dart';
import 'package:handwerker_app/provider/doku_provider/project_vm_provider.dart';
import 'package:handwerker_app/provider/settings_provider/settings_provider.dart';
import 'package:handwerker_app/view/widgets/logo_widget.dart';
import 'package:handwerker_app/view/widgets/symetric_button_widget.dart';
import 'package:handwerker_app/view/widgets/textfield_widgets/labelt_textfield.dart';
import 'package:handwerker_app/models/state_models/material_state.dart';
import 'package:intl/intl.dart';

import '../../../models/project_models/project_short_vm/project_short_vm.dart';
import '../../../models/customer_models/customer_short_model/customer_short_dm.dart';
import '../../../provider/doku_provider/customer_provider.dart';

class MaterialBody extends ConsumerStatefulWidget {
  const MaterialBody({super.key});

  @override
  ConsumerState<MaterialBody> createState() => _MaterialBodyState();
}

class _MaterialBodyState extends ConsumerState<MaterialBody> {
  late final TextEditingController _amountController, _dayPickerController, _summeryController;
  late final dictionary = ref.watch(settingsProv).dictionary;

  late ConsumealbeEntry _entry;
  UnitDM? _unit;

  bool _isMaterialsLoaded = false;
  List<UnitDM>? _units;

  String? _customerID;

  List<ConsumeableVM> _materials = [];
  ProjectShortVM? _project;
  CustomerShortDM? _customer; // State for customer
  ConsumeableVM? _selectedMaterial;
  List<ProjectShortVM> _projects = [];

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '1');
    _dayPickerController = TextEditingController(
      text: DateFormat('d.M.y').format(DateTime.now()),
    );
    _summeryController = TextEditingController();
    _entry = ConsumealbeEntry(createDate: DateTime.now());
    _refreshUnits();
    ref.read(materialNotifierProvider.notifier).loadData();
    ref.read(projectVMProvider.notifier).loadpProject();
    ref.read(customerProvider.notifier).loadCustomers(); // Load customers
  }

  @override
  Widget build(BuildContext context) {
    final materials = ref.watch(materialNotifierProvider);
    final customers = ref.watch(customerProvider);
    final projectsAsync = ref.watch(projectVMProvider.select((state) => state));

    if (_customer != null && _customer!.id != null) {
      ref.read(projectVMProvider.notifier).loadProjectsForCustomer(_customer!.id);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          _dayInputWidget(),
          _chooseCustomerField(customers), // Customer dropdown
          _chooseProjectField(projectsAsync),   // Project dropdown
          _chooseMaterialField(materials),
          _buildAmountPriceFields(),
          const SizedBox(height: 184),
          //_submitInput(),
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

  void _refreshProjects() {
    if (_customer != null) {
      ref.read(projectVMProvider.notifier).loadProjectsForCustomer(_customer!.id);
    }
  }

  Column _buildAmountElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  dictionary.amount,
                  style: Theme.of(context).textTheme.labelMedium,
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
            decoration: Utilits.textFieldDecoration(
              context,
              hintText: dictionary.amount,
            ),
            onChanged: (value) {
              if (_amountController.text.length > 20) {
                return;
              }
              if (_amountController.text.length <= 20) {
                setState(() => _amountController.text = value);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAmountPriceFields() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildAmountElement(),
      _buildSumElement(),
    ],
  );

  Column _buildSumElement() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 7),
          child: Text(
            dictionary.sum,
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
            decoration: Utilits.textFieldDecoration(
              context,
              hintText: '${dictionary.sum} €',
            ),
            onChanged: (value) {
              setState(() {
                if (value.length < 20) {
                  _summeryController.text = value;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _chooseCustomerField(List<CustomerShortDM> customers) {
    // Show loading text if customers are not yet loaded
    if (customers.isEmpty) {
      return const Text('Loading customers...');
    }

    // Ensure `_customer` is properly initialized
    _customer = _customer ?? (customers.isNotEmpty ? customers.first : null);

    // Ensure unique customers to avoid duplicate values
    final uniqueCustomers = customers.toSet().toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              dictionary.customer,
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
            child: DropdownButton<CustomerShortDM>(
              value: _customer,
              isExpanded: true,
              underline: const SizedBox(),
              items: [
                DropdownMenuItem<CustomerShortDM>(
                  alignment: Alignment.center,
                  value: null,
                  child: Text('Select a customer'),
                ),
                ...uniqueCustomers.map((customer) {
                  return DropdownMenuItem<CustomerShortDM>(
                    alignment: Alignment.center,
                    value: customer,
                    child: Text('${customer.companyName}'),
                  );
                }).toList(),
              ],
              onChanged: (selectedCustomer) {
                setState(() {
                  _customer = selectedCustomer;
                  _project = null; // Reset project when customer changes
                  _refreshProjects(); // Refresh projects based on the selected customer
                });
              },
            ),
          ),
        ],
      ),
    );
  }



  Widget _chooseProjectField(List<ProjectShortVM> projects) {
    // Show loading text if projects are not yet loaded
    if (projects.isEmpty) {
      return const Text('Loading projects...');
    }

    // Ensure `_project` is properly initialized
    _project = _project ?? (projects.isNotEmpty ? projects.first : null);

    // Ensure unique projects to avoid duplicate values
    final uniqueProjects = projects.toSet().toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              dictionary.projectUpperCase,
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
            child: DropdownButton<ProjectShortVM>(
              value: _project,
              isExpanded: true,
              underline: const SizedBox(),
              items: [
                DropdownMenuItem<ProjectShortVM>(
                  alignment: Alignment.center,
                  value: null,
                  child: Text('Select a project'),
                ),
                ...uniqueProjects.map((project) {
                  return DropdownMenuItem<ProjectShortVM>(
                    alignment: Alignment.center,
                    value: project,
                    child: Text('${project.title}'),
                  );
                }).toList(),
              ],
              onChanged: (selectedProject) {
                setState(() {
                  _project = selectedProject;
                });
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _chooseMaterialField(List<ConsumeableVM>? materials) {
    if (materials == null || materials.isEmpty) {
      return const Text('No materials available');
    }

    if (!_isMaterialsLoaded) {
      setState(() {
        _selectedMaterial = materials.first;
        _materials = materials;
        _isMaterialsLoaded = true;
      });
    }

    final multi = int.tryParse(_amountController.text) ?? 1;
    final price = _selectedMaterial?.price ?? 0;
    _summeryController.text = (price * multi).toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(dictionary.material, style: Theme.of(context).textTheme.labelMedium),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.only(left: 20, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColor.kTextfieldBorder),
            ),
            child: DropdownButton<ConsumeableVM>(
              menuMaxHeight: 350,
              underline: const SizedBox.shrink(),
              isExpanded: true,
              value: _selectedMaterial,
              items: materials
                  .map(
                    (e) => DropdownMenuItem(
                  alignment: Alignment.center,
                  value: e,
                  child: Text('${e.name}/ ${e.materialUnitName}'),
                ),
              )
                  .toList(),
              onChanged: (e) {
                setState(() {
                  _selectedMaterial = e!;
                  final multi = int.tryParse(_amountController.text) ?? 1;
                  _summeryController.text = (e.price * multi).toStringAsFixed(2);
                });
              },
            ),
          ),
        ],
      ),
    );
  }



  Widget _dayInputWidget() => LabeldTextfield(
    label: dictionary.date,
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

  void _refreshUnits() {
    ref.read(consumableProvider.notifier).getUnits().then(
          (value) => setState(() {
        _units = value;
        _unit = _units!.first;
      }),
    );
  }

  void _submitInput() {
    final unitId = _unit?.id;
    final materialId = _selectedMaterial?.id.toString();

    if (unitId == null || materialId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Required fields are missing')),
        );
      });
      return; // Exit early to avoid further processing
    }

    final material = Consumable(
      amount: int.tryParse(_amountController.text) ?? 1,
      materialUnitID: unitId,
      price: int.tryParse(_summeryController.text) ?? 0,
      materialID: materialId,
    );

    _entry = _entry.copyWith(
      consumables: [material],
      projectID: _project?.id, // This should be checked if necessary
      //customerID: _customer?.id, // This should be checked if necessary
    );

    ref.read(consumableProvider.notifier).uploadConsumableEntry(_entry);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(dictionary.succes)),
      );
    });

    final now = DateTime.now();
    setState(() {
      _selectedMaterial = _materials.first;
      _amountController.clear();
      _summeryController.clear();
      _dayPickerController.text = '${now.day}.${now.month}.${now.year}';
      _customer = null; // Reset customer
      _project = null;  // Reset project
    });
  }
}

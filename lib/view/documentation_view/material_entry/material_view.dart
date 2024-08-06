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
  CustomerShortDM? _customer;
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
    ref.read(customerProvider.notifier).loadCustomers();
  }

  @override
  Widget build(BuildContext context) {
    final materialsAsync = ref.watch(materialNotifierProvider);
    final customersAsync = ref.watch(customerProvider);
    final projectsAsync = ref.watch(projectVMProvider.select((state) => state));

    final uniqueCustomers = customersAsync.toSet().toList();

    if (_customer != null && !uniqueCustomers.contains(_customer)) {
      log('Warning: Selected customer is not in the list.');
      _customer = null;
    }

    if (_customer != null && _customer!.id != null) {
      ref.read(projectVMProvider.notifier).loadProjectsForCustomer(_customer!.id);
    }

    _initializeSelectedValues(uniqueCustomers, _projects);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _dayInputWidget(),
          _chooseCustomerField(uniqueCustomers),
          _chooseProjectField(projectsAsync),
          _chooseMaterialField(materialsAsync),
          _buildAmountPriceFields(),
          const SizedBox(height: 20),
          SymmetricButton(
            color: AppColor.kPrimaryButtonColor,
            text: 'Submit',
            onPressed: _submitInput,
          ),
          const SizedBox(height: 20),
          const Center(
            child: LogoWidget(
              assetString: 'assets/images/img_techtool.png',
              size: 40,
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
    final materialId = _selectedMaterial?.id?.toString();

    if (unitId == null || materialId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Required fields are missing')),
        );
      });
      return;
    }

    final price = int.tryParse(_summeryController.text) ?? 0;

    final material = Consumable(
      amount: int.tryParse(_amountController.text) ?? 1,
      materialUnitID: unitId,
      price: price,
      materialID: materialId,
    );

    _entry = _entry.copyWith(
      consumables: [material],
      projectID: _project?.id,
    );

    ref.read(consumableProvider.notifier).uploadConsumableEntry(_entry);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submission successful')),
      );
    });

    final now = DateTime.now();
    setState(() {
      _selectedMaterial = _materials.isNotEmpty ? _materials.first : null;
      _amountController.clear();
      _summeryController.clear();
      _dayPickerController.text = DateFormat('d.M.y').format(now);
      _customer = null;
      _project = null;
    });
  }

  Widget _chooseCustomerField(List<CustomerShortDM> customers) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<CustomerShortDM>(
        decoration: InputDecoration(
          labelText: dictionary.customer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.kTextfieldBorder),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        value: _customer,
        items: [
          DropdownMenuItem<CustomerShortDM>(
            value: null,
            child: Text('Select a customer'),
          ),
          ...customers.map((customer) {
            return DropdownMenuItem<CustomerShortDM>(
              value: customer,
              child: Text(customer.companyName),
            );
          }).toList(),
        ],
        onChanged: (selectedCustomer) {
          setState(() {
            _customer = selectedCustomer;
            _project = null;
            _refreshProjects();
          });
        },
      ),
    );
  }

  Widget _chooseProjectField(List<ProjectShortVM> projects) {
    if (projects.isEmpty) {
      return const Text('No projects available.');
    }

    _project = _project ?? (projects.isNotEmpty ? projects.first : null);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<ProjectShortVM>(
        decoration: InputDecoration(
          labelText: dictionary.project,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.kTextfieldBorder),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        value: _project,
        items: [
          DropdownMenuItem<ProjectShortVM>(
            value: null,
            child: Text('Select a project'),
          ),
          ...projects.map((project) {
            return DropdownMenuItem<ProjectShortVM>(
              value: project,
              child: Text(project.title!),
            );
          }).toList(),
        ],
        onChanged: (selectedProject) {
          setState(() {
            _project = selectedProject;
          });
        },
      ),
    );
  }

  Widget _chooseMaterialField(List<ConsumeableVM> materials) {
    if (materials.isEmpty) {
      return const Text('No materials available.');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<ConsumeableVM>(
        decoration: InputDecoration(
          labelText: dictionary.material,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.kTextfieldBorder),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        value: _selectedMaterial,
        items: [
          DropdownMenuItem<ConsumeableVM>(
            value: null,
            child: Text('Select a material'),
          ),
          ...materials.map((material) {
            return DropdownMenuItem<ConsumeableVM>(
              value: material,
              child: Text(material.name),
            );
          }).toList(),
        ],
        onChanged: (selectedMaterial) {
          setState(() {
            _selectedMaterial = selectedMaterial;
          });
        },
      ),
    );
  }

  Widget _dayInputWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: _dayPickerController,
        decoration: InputDecoration(
          labelText: dictionary.date,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColor.kTextfieldBorder),
          ),
          suffixIcon: Icon(Icons.calendar_today),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        readOnly: true,
        onTap: () async {
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (selectedDate != null) {
            _dayPickerController.text = DateFormat('d.M.y').format(selectedDate);
            setState(() {
              _entry = _entry.copyWith(createDate: selectedDate);
            });
          }
        },
      ),
    );
  }

  Widget _buildAmountPriceFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.kTextfieldBorder),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _summeryController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColor.kTextfieldBorder),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  void _initializeSelectedValues(
      List<CustomerShortDM> customers,
      List<ProjectShortVM> projects,
      ) {
    if (_customer == null && customers.isNotEmpty) {
      _customer = customers.first;
    }

    if (_project == null && projects.isNotEmpty) {
      _project = projects.first;
    }

    if (_selectedMaterial == null && _materials.isNotEmpty) {
      _selectedMaterial = _materials.first;
    }
  }
}

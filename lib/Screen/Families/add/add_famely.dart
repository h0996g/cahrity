import 'package:charity/Screen/Families/cubit/family_cubit.dart';
import 'package:charity/widget/enum.dart';
import 'package:flutter/material.dart';
import 'package:charity/Screen/Login/componants/components.dart';
import 'package:charity/const/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFamilyPage extends StatefulWidget {
  const AddFamilyPage({super.key});

  @override
  State<AddFamilyPage> createState() => _AddFamilyPageState();
}

class _AddFamilyPageState extends State<AddFamilyPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _idCard = TextEditingController();
  final TextEditingController _familySize = TextEditingController();
  final TextEditingController _income = TextEditingController();
  final TextEditingController _helpNeeded = TextEditingController();
  final TextEditingController _notes = TextEditingController();

  DateTime? _birthDate;
  Sex? _sex;
  FamilySituation? _familySituation;
  WorkSituation? _workSituation;
  ResidenceType? _residenceType;

  List<Map<String, TextEditingController>> _childrenControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Family"),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_firstName, 'First Name'),
              _buildTextField(_lastName, 'Last Name'),
              _buildDatePicker(context, 'Birth Date'),
              _buildEnumDropdown<Sex>(
                label: 'Sex',
                value: _sex,
                items: Sex.values,
                onChanged: (val) => setState(() => _sex = val),
              ),
              _buildTextField(
                _phone,
                'Phone',
                keyboardType: TextInputType.phone,
              ),
              _buildTextField(_address, 'Address'),
              _buildTextField(_state, 'State'),
              _buildTextField(_idCard, 'ID Card Number'),
              _buildEnumDropdown<FamilySituation>(
                label: 'Family Situation',
                value: _familySituation,
                items: FamilySituation.values,
                onChanged: (val) => setState(() => _familySituation = val),
              ),
              _buildTextField(
                _familySize,
                'Family Size',
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                _income,
                'Family Income',
                keyboardType: TextInputType.number,
              ),
              _buildEnumDropdown<ResidenceType>(
                label: 'Residence Type',
                value: _residenceType,
                items: ResidenceType.values,
                onChanged: (val) => setState(() => _residenceType = val),
              ),
              _buildEnumDropdown<WorkSituation>(
                label: 'Work Situation',
                value: _workSituation,
                items: WorkSituation.values,
                onChanged: (val) => setState(() => _workSituation = val),
              ),
              _buildTextField(_helpNeeded, 'Help Needed'),
              _buildTextField(_notes, 'Notes', maxLines: 3),
              const SizedBox(height: 20),
              _buildChildrenSection(),
              const SizedBox(height: 24),
              BlocConsumer<FamilyCubit, FamilyState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return CustomSubmitButton(
                    text: 'Add',
                    onPressed: _submitForm,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    int? maxLines,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator:
            (val) => val == null || val.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label),
        subtitle: Text(
          _birthDate != null
              ? "${_birthDate!.year}-${_birthDate!.month.toString().padLeft(2, '0')}-${_birthDate!.day.toString().padLeft(2, '0')}"
              : 'Select a date',
        ),
        trailing: const Icon(Icons.calendar_today),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime(1990),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (date != null) setState(() => _birthDate = date);
        },
      ),
    );
  }

  Widget _buildEnumDropdown<T extends Enum>({
    required String label,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<T>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        value: value,
        items:
            items
                .map(
                  (item) =>
                      DropdownMenuItem<T>(value: item, child: Text(item.label)),
                )
                .toList(),
        onChanged: onChanged,
        validator: (val) => val == null ? 'Select $label' : null,
      ),
    );
  }

  Widget _buildChildrenSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Children",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        ..._childrenControllers.asMap().entries.map((entry) {
          final index = entry.key;
          final child = entry.value;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      child['age']!,
                      'Age',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      child['shoeSize']!,
                      'Shoe Size',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  IconButton(
                    onPressed:
                        () => setState(
                          () => _childrenControllers.removeAt(index),
                        ),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 6),
            ],
          );
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed:
                () => setState(
                  () => _childrenControllers.add({
                    'age': TextEditingController(),
                    'shoeSize': TextEditingController(),
                  }),
                ),
            icon: const Icon(Icons.add),
            label: const Text("Add Child"),
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final children =
          _childrenControllers.map((child) {
            return {
              'age': int.tryParse(child['age']!.text),
              'shoeSize': int.tryParse(child['shoeSize']!.text),
            };
          }).toList();

      final newFamily = {
        "firstName": _firstName.text,
        "lastName": _lastName.text,
        "birthDate": _birthDate?.toIso8601String(),
        "sex": _sex?.label,
        "phone": _phone.text,
        "address": _address.text,
        "state": _state.text,
        "idCardNumber": _idCard.text,
        "familySituation": _familySituation?.label,
        "familySize": int.tryParse(_familySize.text),
        "familyIncome": int.tryParse(_income.text),
        "residenceType": _residenceType?.label,
        "workSituation": _workSituation?.label,
        "helpNeeded": _helpNeeded.text,
        "notes": _notes.text,
        "children": children,
      };

      FamilyCubit.get(context).addFamily(newFamily);

      debugPrint("Submitted Family: $newFamily");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Family submitted!")));
    }
  }
}

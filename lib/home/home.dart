import 'package:charity/const/colors.dart';
import 'package:charity/home/cubit/home_cubit.dart';
import 'package:charity/home/family.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _state = TextEditingController();

  String? _selectedSex;
  String? _selectedFamilySituation;
  bool _showFilters = false; // 👈 NEW STATE

  final List<String> sexes = ["Male", "Female"];
  final List<String> familySituations = [
    "Single",
    "Married",
    "Divorced",
    "Widowed",
  ];

  void _applyFilters() {
    final filters = <String, dynamic>{
      'firstName': _firstName.text.trim(),
      'lastName': _lastName.text.trim(),
      'state': _state.text.trim(),
      'sex': _selectedSex,
      'familySituation': _selectedFamilySituation,
    };
    context.read<HomeCubit>().getFamilies(filters: filters);
  }

  void _resetFilters() {
    _firstName.clear();
    _lastName.clear();
    _state.clear();
    setState(() {
      _selectedSex = null;
      _selectedFamilySituation = null;
    });
    context.read<HomeCubit>().getFamilies();
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getFamilies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Families"),
        actions: [
          IconButton(
            icon: Icon(_showFilters ? Icons.close : Icons.filter_list),
            tooltip: _showFilters ? 'Hide Filters' : 'Show Filters',
            onPressed: () {
              setState(() => _showFilters = !_showFilters);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState:
                _showFilters
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _textField("First Name", _firstName),
                      _textField("Last Name", _lastName),
                      _textField("State", _state),
                      _dropdownField("Sex", sexes, _selectedSex, (value) {
                        setState(() => _selectedSex = value);
                      }),
                      _dropdownField(
                        "Family Situation",
                        familySituations,
                        _selectedFamilySituation,
                        (value) {
                          setState(() => _selectedFamilySituation = value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _applyFilters,
                        icon: const Icon(Icons.search),
                        label: const Text("Apply Filters"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton.icon(
                        onPressed: _resetFilters,
                        icon: const Icon(Icons.refresh),
                        label: const Text("Reset"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          side: const BorderSide(color: Colors.indigo),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            secondChild: const SizedBox.shrink(),
          ),
          // const Divider(thickness: 1.2),
          Expanded(
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetFamiliesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is GetFamiliesError) {
                  return Center(child: Text(state.message));
                } else if (state is GetFamiliesFaild) {
                  return const Center(child: Text("Failed to load families"));
                }
                return FamilyCardList(
                  families: HomeCubit.get(context).familyModel?.families ?? [],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(String label, TextEditingController controller) {
    return SizedBox(
      width: 160,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _dropdownField(
    String label,
    List<String> items,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    return SizedBox(
      width: 160,
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items:
            items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

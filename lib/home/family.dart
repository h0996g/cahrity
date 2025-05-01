import 'package:charity/model/family/family_m.dart';
import 'package:flutter/material.dart';

class FamilyCardList extends StatelessWidget {
  final List<FamilyModel>? families;

  const FamilyCardList({super.key, this.families});

  @override
  Widget build(BuildContext context) {
    if (families == null || families!.isEmpty) {
      return Center(
        child: Text(
          "No families found.",
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: families!.length,
      itemBuilder: (context, index) {
        final family = families![index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${family.firstName ?? ''} ${family.lastName ?? ''}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _infoRow("📞 Phone", family.phone),
                _infoRow("🏠 Address", family.address),
                _infoRow("👨‍👩‍👧 Family Size", family.familySize?.toString()),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _showFamilyDetails(context, family),
                    icon: const Icon(Icons.info_outline),
                    label: const Text("See more"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value?.trim().isNotEmpty == true ? value! : "N/A",
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  void _showFamilyDetails(BuildContext context, FamilyModel family) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: Text(
              "${family.firstName ?? ''} ${family.lastName ?? ''}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow("Sex", family.sex),
                  _infoRow("Birth Date", _formatDate(family.birthDate)),
                  _infoRow("Phone", family.phone),
                  _infoRow("Address", family.address),
                  _infoRow("State", family.state),
                  _infoRow("ID Card", family.idCardNumber),
                  _infoRow("Family Situation", family.familySituation),
                  _infoRow("Family Size", family.familySize?.toString()),
                  _infoRow(
                    "Educated Children",
                    family.educatedChildren?.toString(),
                  ),
                  _infoRow(
                    "Disabled Children",
                    family.disabledChildren?.toString(),
                  ),
                  _infoRow(
                    "Family Income",
                    family.familyIncome != null
                        ? "${family.familyIncome} DZD"
                        : null,
                  ),
                  _infoRow("Work Situation", family.workSituation),
                  _infoRow("Residence", family.residenceType),
                  _infoRow("Help Needed", family.helpNeeded),
                  _infoRow("Last Help", _formatDate(family.lastHelpDate)),
                  _infoRow(
                    "Times Help Received",
                    family.numberOfReceivedHelp?.toString(),
                  ),
                  _infoRow("Notes", family.notes),
                  if (family.children != null &&
                      family.children!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    const Divider(thickness: 1.2),
                    const Text(
                      "Children",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ...family.children!.map(
                      (child) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.child_care,
                              size: 18,
                              color: Colors.blueAccent,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "Age: ${child.age}, Shoe Size: ${child.shoeSize}",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Close", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    final local = date.toLocal();
    return "${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}";
  }
}

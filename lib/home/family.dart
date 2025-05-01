import 'package:charity/Screen/Login/componants/function.dart';
import 'package:flutter/material.dart';
import 'package:charity/model/family/family_m.dart';

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
      padding: const EdgeInsets.all(16),
      itemCount: families!.length,
      itemBuilder: (context, index) {
        final family = families![index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${family.firstName ?? ''} ${family.lastName ?? ''}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.phone, size: 18, color: Colors.blueAccent),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () => launchPhone(family.phone, context),
                      child: Text(
                        family.phone ?? "N/A",
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.home, size: 18, color: Colors.grey),
                    const SizedBox(width: 6),
                    Flexible(child: Text(family.address ?? "N/A")),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.group, size: 18, color: Colors.green),
                    const SizedBox(width: 6),
                    Text("Family Size: ${family.familySize ?? 'N/A'}"),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.info_outline),
                    label: const Text("See more"),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: const BorderSide(color: Colors.blueAccent),
                      foregroundColor: Colors.blueAccent,
                    ),
                    onPressed: () => _showFamilyDetails(context, family),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFamilyDetails(BuildContext context, FamilyModel family) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${family.firstName ?? ''} ${family.lastName ?? ''}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _infoText("Sex", family.sex),
                          _infoText(
                            "Birth Date",
                            _formatDate(family.birthDate),
                          ),
                          _infoText("Phone", family.phone),
                          _infoText("Address", family.address),
                          _infoText("State", family.state),
                          _infoText("ID Card", family.idCardNumber),
                          _infoText("Family Situation", family.familySituation),
                          _infoText(
                            "Family Size",
                            family.familySize?.toString(),
                          ),
                          _infoText(
                            "Educated Children",
                            family.educatedChildren?.toString(),
                          ),
                          _infoText(
                            "Disabled Children",
                            family.disabledChildren?.toString(),
                          ),
                          _infoText(
                            "Family Income",
                            family.familyIncome != null
                                ? "${family.familyIncome} DZD"
                                : null,
                          ),
                          _infoText("Work Situation", family.workSituation),
                          _infoText("Residence", family.residenceType),
                          _infoText("Help Needed", family.helpNeeded),
                          _infoText(
                            "Last Help",
                            _formatDate(family.lastHelpDate),
                          ),
                          _infoText(
                            "Times Help Received",
                            family.numberOfReceivedHelp?.toString(),
                          ),
                          _infoText("Notes", family.notes),
                          if (family.children != null &&
                              family.children!.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            const Text(
                              "Children:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ...family.children!.map(
                              (child) => Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  "Age: ${child.age}, Shoe Size: ${child.shoeSize}",
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Close",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Widget _infoText(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        "$label: ${value?.trim().isNotEmpty == true ? value! : 'N/A'}",
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    final local = date.toLocal();
    return "${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}";
  }
}

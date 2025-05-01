enum Sex { male, female }

enum FamilySituation { married, single, divorced, widowed }

enum WorkSituation { employed, unemployed, retired, withoutJob }

enum ResidenceType { owned, rented, fragile, homeless }

extension LabelExtension on Enum {
  String get label => name[0].toUpperCase() + name.substring(1);
}

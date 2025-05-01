enum Sex { male, female }

enum FamilySituation { married, single, divorced, widowed }

enum WorkSituation { employed, unemployed, retired, withoutJob }

enum ResidenceType { owned, rented, fragile, homeless }

extension EnumHelpers on Enum {
  String get displayName =>
      toString().split('.').last[0].toUpperCase() +
      toString().split('.').last.substring(1);
}

class FamilyResponse {
  final String? message;
  final List<FamilyModel>? families;
  final Pagination? pagination;

  FamilyResponse({this.message, this.families, this.pagination});

  factory FamilyResponse.fromJson(Map<String, dynamic> json) {
    return FamilyResponse(
      message: json['message'],
      families:
          (json['families'] as List?)
              ?.map((x) => FamilyModel.fromJson(x))
              .toList(),
      pagination:
          json['pagination'] != null
              ? Pagination.fromJson(json['pagination'])
              : null,
    );
  }
}

class FamilyModel {
  final int? numberOfChildren;
  final String? id;
  final String? firstName;
  final String? lastName;
  final DateTime? birthDate;
  final String? sex;
  final String? phone;
  final String? address;
  final String? state;
  final String? idCardNumber;
  final String? familySituation;
  final int? familySize;
  final List<Child>? children;
  final int? educatedChildren;
  final int? disabledChildren;
  final int? familyIncome;
  final String? workSituation;
  final String? residenceType;
  final String? helpNeeded;
  final DateTime? lastHelpDate;
  final int? numberOfReceivedHelp;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FamilyModel({
    this.numberOfChildren,
    this.id,
    this.firstName,
    this.lastName,
    this.birthDate,
    this.sex,
    this.phone,
    this.address,
    this.state,
    this.idCardNumber,
    this.familySituation,
    this.familySize,
    this.children,
    this.educatedChildren,
    this.disabledChildren,
    this.familyIncome,
    this.workSituation,
    this.residenceType,
    this.helpNeeded,
    this.lastHelpDate,
    this.numberOfReceivedHelp,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory FamilyModel.fromJson(Map<String, dynamic> json) {
    return FamilyModel(
      numberOfChildren: json['numberOfChildren'],
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthDate:
          json['birthDate'] != null
              ? DateTime.tryParse(json['birthDate'])
              : null,
      sex: json['sex'],
      phone: json['phone'],
      address: json['address'],
      state: json['state'],
      idCardNumber: json['idCardNumber'],
      familySituation: json['familySituation'],
      familySize: json['familySize'],
      children:
          (json['children'] as List?)?.map((x) => Child.fromJson(x)).toList(),
      educatedChildren: json['educatedChildren'],
      disabledChildren: json['disabledChildren'],
      familyIncome: json['familyIncome'],
      workSituation: json['workSituation'],
      residenceType: json['residenceType'],
      helpNeeded: json['helpNeeded'],
      lastHelpDate:
          json['lastHelpDate'] != null
              ? DateTime.tryParse(json['lastHelpDate'])
              : null,
      numberOfReceivedHelp: json['numberOfReceivedHelp'],
      notes: json['notes'],
      createdAt:
          json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'])
              : null,
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'])
              : null,
    );
  }
}

class Child {
  final int? age;
  final int? shoeSize;
  final String? id;

  Child({this.age, this.shoeSize, this.id});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(age: json['age'], shoeSize: json['shoeSize'], id: json['_id']);
  }
}

class Pagination {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;
  final dynamic next;

  Pagination({this.total, this.page, this.limit, this.totalPages, this.next});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
      next: json['next'],
    );
  }
}

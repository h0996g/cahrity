import 'package:charity/home/family.dart';
import 'package:charity/model/family/family_m.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Families")),
      body: FamilyCardList(families: myLoadedFamilyList),
    );
  }
}

final List<FamilyModel> myLoadedFamilyList = [
  FamilyModel(
    numberOfChildren: 1,
    id: "681232dbc84c7421048b95a3",
    firstName: "Ahmed",
    lastName: "Benali",
    birthDate: DateTime.parse("1985-07-15"),
    sex: "Male",
    phone: "+213661234567",
    address: "123 Rue de la Liberté, Alger",
    state: "Alger",
    idCardNumber: "123456789012",
    familySituation: "Married",
    familySize: 5,
    children: [Child(age: 10, shoeSize: 30, id: "681232dbc84c7421048b95a4")],
    educatedChildren: 2,
    disabledChildren: 1,
    familyIncome: 35000,
    workSituation: "Unemployed",
    residenceType: "Rented",
    helpNeeded: "Food, Clothing",
    lastHelpDate: DateTime.parse("2024-12-01"),
    numberOfReceivedHelp: 2,
    notes: "Requires additional medical assistance",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  FamilyModel(
    numberOfChildren: 2,
    id: "681232dbc84c7421048b95b9",
    firstName: "Fatima",
    lastName: "Zohra",
    birthDate: DateTime.parse("1990-03-10"),
    sex: "Female",
    phone: "+213665432198",
    address: "45 Avenue des Martyrs, Oran",
    state: "Oran",
    idCardNumber: "987654321098",
    familySituation: "Widowed",
    familySize: 4,
    children: [
      Child(age: 12, shoeSize: 32, id: "child1"),
      Child(age: 8, shoeSize: 28, id: "child2"),
    ],
    educatedChildren: 1,
    disabledChildren: 0,
    familyIncome: 22000,
    workSituation: "Part-time",
    residenceType: "Owned",
    helpNeeded: "School Supplies",
    lastHelpDate: DateTime.parse("2024-10-20"),
    numberOfReceivedHelp: 1,
    notes: "Needs assistance for school supplies for both kids",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

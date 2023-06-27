import 'package:flutter/cupertino.dart';

class RoomDetail {
  String name;
  TextEditingController adultController;
  TextEditingController childController;
  List<AgeName> adultList;
  List<AgeName> childList;
  RoomDetail(this.name, this.adultController, this.childController,
      this.adultList, this.childList);
}

class AgeName {
  final TextEditingController nameController;
  final TextEditingController ageController;
  AgeName(this.ageController, this.nameController);
}

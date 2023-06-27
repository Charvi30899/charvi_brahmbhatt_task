import 'package:flutter/cupertino.dart';
import 'package:matcher/matcher.dart';
import 'package:get/get.dart';

import '../model/selected_room_model.dart';

class RoomListController extends GetxController {
  List<String> roomList = [
    'Select room',
    'Room 1',
    'Room 2',
    'Room 3',
    'Room 4',
    'Room 5'
  ];
  RxList<String> selectedRooms = <String>[].obs;
  RxList<RoomDetail> mySelectedRooms = <RoomDetail>[].obs;
  RxString selected = 'Select room'.obs;

  void updateSelected(String val) {
    selected.value = val;
    if (selected.value != "Select room") {
      selectedRooms.add(val);
      TextEditingController adultController = TextEditingController();
      TextEditingController childController = TextEditingController();
      mySelectedRooms
          .add(RoomDetail(val, adultController, childController, [], []));
    }
    update();
  }

  updateAdultChildList(int index, int adult, int child) {
    mySelectedRooms[index].adultList.clear();
    mySelectedRooms[index].childList.clear();
    if (adult != 0) {
      for (var i = 0; i < adult; i++) {
        TextEditingController nameController = TextEditingController();
        TextEditingController ageController = TextEditingController();
        mySelectedRooms[index]
            .adultList
            .add(AgeName(nameController, ageController));
      }
    } else {
      mySelectedRooms[index].adultList.clear();
    }
    if (child != 0) {
      for (var i = 0; i < child; i++) {
        TextEditingController nameController = TextEditingController();
        TextEditingController ageController = TextEditingController();
        mySelectedRooms[index]
            .childList
            .add(AgeName(nameController, ageController));
      }
    } else {
      mySelectedRooms[index].childList.clear();
    }
    update();
  }
}

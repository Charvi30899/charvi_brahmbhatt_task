import 'package:charvi_brahmbhatt_task/controller/room_list_view_controller.dart';
import 'package:charvi_brahmbhatt_task/mixin/validator_mixin.dart';
import 'package:charvi_brahmbhatt_task/utilities/app_color.dart';
import 'package:charvi_brahmbhatt_task/utilities/utility.dart';
import 'package:charvi_brahmbhatt_task/view/room_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';

class RoomSelectView extends StatefulWidget {
  const RoomSelectView({super.key});

  @override
  State<RoomSelectView> createState() => _RoomSelectViewState();
}

class _RoomSelectViewState extends State<RoomSelectView> with ValidatorMixin {
  final FormValidate = GlobalKey<FormState>();
  final roomController = Get.put(RoomListController());
  TextStyle hintStyle = TextStyle(
      color: AppColors.darkGrey, fontSize: 15, fontWeight: FontWeight.w400);
  TextStyle errorStyle =
      TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          dropDownView(),
          selectedRoomView(),
          submitButtonView(),
        ],
      ),
    );
  }

  Widget dropDownView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Room",
            style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() => Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(5)),
                      child: DropdownButton<String>(
                        underline: const SizedBox(),
                        isExpanded: true,
                        dropdownColor: AppColors.lightGrey,
                        value: roomController.selected.value,
                        onChanged: (newValue) {
                          roomController.updateSelected(newValue!);
                        },
                        items: roomController.roomList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget submitButtonView() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: CustomButton(
          btnColor: AppColors.pink,
          title: "Submit",
          btnTap: () {
            try {
              if (FormValidate.currentState!.validate()) {
                Get.to(RoomDetailView());
                Utility.snackBar("SuccessFully added");
              } else {
                Utility.snackBar("Some error occured");
              }
            } catch (e) {}
          },
        ));
  }

  Widget selectedRoomView() {
    return Form(
      key: FormValidate,
      child: Column(
        children: [
          GetBuilder<RoomListController>(builder: (controller) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.selectedRooms.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(roomController.selectedRooms[index]),
                              const SizedBox(
                                height: 10,
                              ),
                              adultChildFieldView(
                                  controller
                                      .mySelectedRooms[index].adultController,
                                  controller
                                      .mySelectedRooms[index].childController,
                                  index),
                              const SizedBox(
                                height: 10,
                              ),
                              controller.mySelectedRooms[index].adultList
                                          .isNotEmpty ||
                                      controller.mySelectedRooms[index]
                                          .childList.isNotEmpty
                                  ? Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            adultListWidget(index),
                                            childListWidget(index)
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          })
        ],
      ),
    );
  }

  Widget adultChildFieldView(TextEditingController adultController,
      TextEditingController childController, int index) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(2),
            child: TextFormField(
              controller: adultController,
              maxLength: 2,
              keyboardType: TextInputType.number,
              onChanged: (val) {
                roomController.updateAdultChildList(
                    index,
                    adultController.text.isNotEmpty
                        ? int.parse(adultController.text)
                        : 0,
                    childController.text.isNotEmpty
                        ? int.parse(childController.text)
                        : 0);
              },
              decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.lightGrey,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                  hintText: "Enter Adult",
                  hintStyle: hintStyle),
              validator: (value) {
                return requiredField(
                    adultController.text.trim(), 'number of adult');
              },
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(2),
            child: TextFormField(
              controller: childController,
              maxLength: 2,
              keyboardType: TextInputType.number,
              onChanged: (val) {
                roomController.updateAdultChildList(
                    index,
                    adultController.text.isNotEmpty
                        ? int.parse(adultController.text)
                        : 0,
                    childController.text.isNotEmpty
                        ? int.parse(childController.text)
                        : 0);
              },
              decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.lightGrey,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none),
                  hintText: "Enter Child",
                  hintStyle: hintStyle),
              validator: (value) {
                return requiredField(
                    childController.text.trim(), 'number of child');
              },
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            child: CustomButton(
              btnColor: AppColors.green,
              title: "ADD",
              btnTap: () {
                roomController.updateAdultChildList(
                    index,
                    adultController.text.isNotEmpty
                        ? int.parse(adultController.text)
                        : 0,
                    childController.text.isNotEmpty
                        ? int.parse(childController.text)
                        : 0);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget ageNameFiledView(TextEditingController nameController,
      TextEditingController ageController, int index, String validator) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.lightGrey,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none),
                        hintText: "Enter Name",
                        hintStyle: hintStyle),
                    validator: (value) {
                      return requiredField(nameController.text.trim(), 'name');
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(2),
                  child: TextFormField(
                    controller: ageController,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      errorMaxLines: 2,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none),
                      hintText: "Enter Age",
                      hintStyle: hintStyle,
                    ),
                    validator: ((value) {
                      if (validator == "adult") {
                        return adultAge(ageController.text.trim());
                      } else if (validator == "child") {
                        return childAge(ageController.text.trim());
                      } else {
                        return null;
                      }
                    }),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget adultListWidget(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Adult"),
        const SizedBox(
          height: 5,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: roomController.mySelectedRooms[index].adultList.length,
          itemBuilder: (context, pos) {
            return Column(
              children: [
                ageNameFiledView(
                    roomController
                        .mySelectedRooms[index].adultList[pos].nameController,
                    roomController
                        .mySelectedRooms[index].adultList[pos].ageController,
                    index,
                    "adult"),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget childListWidget(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Child"),
        const SizedBox(
          height: 5,
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: roomController.mySelectedRooms[index].childList.length,
          itemBuilder: (context, pos) {
            return Column(
              children: [
                ageNameFiledView(
                    roomController
                        .mySelectedRooms[index].childList[pos].nameController,
                    roomController
                        .mySelectedRooms[index].childList[pos].ageController,
                    index,
                    "child")
              ],
            );
          },
        ),
      ],
    );
  }

  String? adultAge(String age) {
    return adultAgeValidator(age) ? "Age should be Above 18" : null;
  }

  String? childAge(String age) {
    return childAgeValidator(age) ? "Age should be Below 18" : null;
  }

  String? requiredField(String person, String error) {
    return requiredInput(person) ? "Please enter $error" : null;
  }
}

import 'package:charvi_brahmbhatt_task/utilities/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/room_list_view_controller.dart';
import '../model/selected_room_model.dart';

class RoomDetailView extends StatefulWidget {
  const RoomDetailView({super.key});

  @override
  State<RoomDetailView> createState() => _RoomDetailViewState();
}

class _RoomDetailViewState extends State<RoomDetailView> {
  final roomController = Get.put(RoomListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text(
          "Room Details",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: bodyWidget(),
    );
  }

  Widget bodyWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [selectedRoomView()],
      ),
    );
  }

  Widget selectedRoomView() {
    return Column(
      children: [
        GetBuilder<RoomListController>(builder: (controller) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: controller.mySelectedRooms.length,
            itemBuilder: (context, index) {
              List<AgeName> commonPersonList =
                  controller.mySelectedRooms[index].adultList +
                      controller.mySelectedRooms[index].adultList;
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
                            Text(controller.selectedRooms[index],
                                style: TextStyle(color: AppColors.darkGrey)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Adult: ${controller.mySelectedRooms[index].adultController.text}"),
                            Text(
                                "Child: ${controller.mySelectedRooms[index].childController.text}"),
                            const SizedBox(
                              height: 10,
                            ),
                            controller.mySelectedRooms[index].adultList
                                        .isNotEmpty ||
                                    controller.mySelectedRooms[index].childList
                                        .isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        personListWidget(commonPersonList),
                                      ],
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
    );
  }

  Widget personListWidget(List<AgeName> personList) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: personList.length,
          itemBuilder: (context, pos) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text((pos + 1).toString(),
                      style: TextStyle(color: AppColors.darkGrey)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Name : ${personList[pos].nameController.text}"),
                  Text("Age : ${personList[pos].ageController.text}"),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

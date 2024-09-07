// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todoproject/model/tododm.dart';
import 'package:todoproject/ui/screens/home/tabs/list/todo.dart';
import 'package:todoproject/ui/utils/app_color.dart';
import 'package:todoproject/ui/utils/app_style.dart';
import 'package:todoproject/ui/utils/extension_date.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime selectedCalendarDate = DateTime.now();
  List<ToDoDM> todosList = [];
  @override
  Widget build(BuildContext context) {
    getToDoListFromFireStore();
    return Column(
      children: [
        buildCalendar(),
        Expanded(
          flex: 67,
          child: ListView.builder(
              itemCount: todosList.length,
              itemBuilder: (context, index) {
                return ToDo(item: todosList[index]);
              }),
        ),
      ],
    );
  }

  buildCalendar() {
    return Expanded(
      flex: 13,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.bgColor,
                ),
              ),
            ],
          ),
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            focusDate: selectedCalendarDate,
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateChange: (selectedDate) {},
            showTimelineHeader: false,
            itemBuilder: (context, date, isSelected, ontap) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedCalendarDate = date;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(22)),
                  child: Column(
                    children: [
                      const Spacer(),
                      Text(
                        date.dayName,
                        style: isSelected
                            ? AppStyle.selectedCalendarDayStyle
                            : AppStyle.unSelectedCalendarDayStyle,
                      ),
                      const Spacer(),
                      Text(
                        date.day.toString(),
                        style: isSelected
                            ? AppStyle.selectedCalendarDayStyle
                            : AppStyle.unSelectedCalendarDayStyle,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void getToDoListFromFireStore() async {
    CollectionReference todocollection =
        FirebaseFirestore.instance.collection(ToDoDM.collectionName);
    QuerySnapshot querySnapshot = await todocollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todosList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return ToDoDM.fromjson(json);
    }).toList();
    todosList = todosList
        .where((todo) =>
            todo.date.year == selectedCalendarDate.year &&
            todo.date.month == selectedCalendarDate.month &&
            todo.date.day == selectedCalendarDate.day)
        .toList();
  }
}

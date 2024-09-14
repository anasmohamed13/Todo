import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoproject/ui/providers/list_provider.dart';

import 'package:todoproject/ui/screens/home/tabs/list/todo.dart';
import 'package:todoproject/ui/utils/app_color.dart';
import 'package:todoproject/ui/utils/app_style.dart';
import 'package:todoproject/ui/utils/extension_date.dart';

class TodosList extends StatefulWidget {
  const TodosList({super.key});

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  late ListProvider listProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listProvider.loadTodoFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);

    return Column(
      children: [
        buildCalendar(),
        Expanded(
          flex: 83,
          child: ListView.builder(
              itemCount: listProvider.todos.length,
              itemBuilder: (context, index) {
                return Todo(
                  item: listProvider.todos[index],
                );
              }),
        )
      ],
    );
  }

  Expanded buildCalendar() {
    return Expanded(
      flex: 17,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: Container(
                color: AppColors.primary,
              )),
              Expanded(
                  child: Container(
                color: AppColors.bgColor,
              ))
            ],
          ),
          EasyInfiniteDateTimeLine(
            showTimelineHeader: false,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            focusDate: listProvider.selectedCalendarDate,
            lastDate: DateTime.now().add(const Duration(days: 365)),
            itemBuilder: (context, date, isSelected, onDateTapped) {
              return InkWell(
                onTap: () {
                  setState(() {
                    listProvider.selectedCalendarDate = date;
                    listProvider.loadTodoFromFirestore();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                      const Spacer()
                    ],
                  ),
                ),
              );
            },
            onDateChange: (selectedDate) {
              setState(() {
                listProvider.selectedCalendarDate = selectedDate;
              });
            },
          ),
        ],
      ),
    );
  }

  void onDateTapped() {}
}

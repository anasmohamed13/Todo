import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildCalendar(),
        const Spacer(
          flex: 67,
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
}

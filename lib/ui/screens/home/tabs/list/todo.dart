import 'package:flutter/material.dart';
import 'package:todoproject/model/tododm.dart';
import 'package:todoproject/ui/utils/app_color.dart';
import 'package:todoproject/ui/utils/app_style.dart';

class ToDo extends StatelessWidget {
  final ToDoDM item;
  const ToDo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .12,
      margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          buildVerticalLine(context),
          const SizedBox(
            width: 25,
          ),
          buildToDoInfo(),
          buildToDoState(),
        ],
      ),
    );
  }

  buildVerticalLine(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .07,
      width: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primary,
      ),
    );
  }

  buildToDoInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Text(
            item.title,
            style: AppStyle.bottomSheetTitle.copyWith(color: AppColors.primary),
            maxLines: 1,
          ),
          const Spacer(),
          Text(
            item.description,
            style: AppStyle.bodyTextStyle,
            maxLines: 1,
          ),
          const Spacer(),
        ],
      ),
    );
  }

  buildToDoState() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: const Icon(
        Icons.done,
        color: AppColors.white,
        size: 34,
      ),
    );
  }
}

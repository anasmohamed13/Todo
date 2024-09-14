// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import 'package:todoproject/model/tododm.dart';
import 'package:todoproject/ui/providers/list_provider.dart';
import 'package:todoproject/ui/utils/app_color.dart';
import 'package:todoproject/ui/utils/app_style.dart';

class Todo extends StatelessWidget {
  final TodoDM item;

  Todo({super.key, required this.item});

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);

    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await TodoDM.userTodosCollection.doc(item.id).delete();
              listProvider.loadTodoFromFirestore();
            },
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.red,
            icon: Icons.delete,
            label: "delete",
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          )
        ],
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * .15,
        width: MediaQuery.of(context).size.width * .90,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        child: Row(
          children: [
            buildVerticalLine(context),
            const SizedBox(
              width: 24,
            ),
            buildTodoInfo(),
            const SizedBox(
              width: 16,
            ),
            buildTodoState()
          ],
        ),
      ),
    );
  }

  buildVerticalLine(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * .07,
        width: 4,
        decoration: BoxDecoration(
            color: item.isDone ? Colors.green : AppColors.primary,
            borderRadius: BorderRadius.circular(10)),
      );

  buildTodoInfo() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.bottomSheetTitle.copyWith(
                  color: item.isDone ? Colors.green : AppColors.primary),
            ),
            const Spacer(),
            Text(
              item.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.bodyTextStyle,
            ),
            const Spacer(),
          ],
        ),
      );

  buildTodoState() => InkWell(
        onTap: () async {
          await TodoDM.userTodosCollection
              .doc(item.id)
              .update({"isDone": !item.isDone});
          listProvider.loadTodoFromFirestore();
        },
        child: item.isDone ? buildCheckedState() : buildUnCheckedState(),
      );

  Container buildCheckedState() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.white),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        "Done",
        style: TextStyle(
            fontSize: 30,
            color: item.isDone ? Colors.green : AppColors.primary),
      ),
    );
  }

  Container buildUnCheckedState() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.primary),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: const Icon(
        Icons.done,
        color: AppColors.white,
        size: 30,
      ),
    );
  }
}

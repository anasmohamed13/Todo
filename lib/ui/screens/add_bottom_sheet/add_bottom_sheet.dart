// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoproject/model/tododm.dart';
import 'package:todoproject/ui/providers/list_provider.dart';
import 'package:todoproject/ui/utils/app_color.dart';
import 'package:todoproject/ui/utils/app_style.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  String title = "";
  String description = "";
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * .5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(22)),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Add new task",
            style: AppStyle.bottomSheetTitle,
            textAlign: TextAlign.center,
          ),
          TextField(
            decoration: const InputDecoration(hintText: "Enter task title"),
            onChanged: (text) {
              title = text;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            decoration: const InputDecoration(
              hintText: "Enter task description",
            ),
            onChanged: (text) {
              description = text;
            },
            minLines: 6,
            maxLines: 10,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text("Select time", style: AppStyle.bottomSheetTitle),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {
              showMyDatePicker(context);
            },
            child: Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                textAlign: TextAlign.center,
                style:
                    AppStyle.bottomSheetTitle.copyWith(color: AppColors.grey)),
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                addTodoToFirestore();
              },
              child: const Text("Add"))
        ],
      ),
    );
  }

  showMyDatePicker(BuildContext context) async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }

  void addTodoToFirestore() async {
    CollectionReference todosCollection = TodoDM.userTodosCollection;
    DocumentReference documentReference = todosCollection.doc();
    TodoDM newTodo = TodoDM(
        id: documentReference.id,
        title: title,
        description: description,
        date: selectedDate,
        isDone: false);
    await documentReference.set(newTodo.toJson());
    listProvider.loadTodoFromFirestore();
    Navigator.pop(context);
  }
}

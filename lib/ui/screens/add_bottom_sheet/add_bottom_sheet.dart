// ignore_for_file: non_constant_identifier_names, sized_box_for_whitespace, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoproject/model/tododm.dart';
import 'package:todoproject/ui/utils/app_color.dart';
import 'package:todoproject/ui/utils/app_style.dart';
import 'package:todoproject/ui/utils/extension_date.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  static void ShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const AddBottomSheet(),
        );
      },
    );
  }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'add new task',
            textAlign: TextAlign.center,
            style: AppStyle.bottomSheetTitle,
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'enter task title '),
            controller: titleController,
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            decoration:
                const InputDecoration(hintText: 'enter task description'),
            controller: descriptionController,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'select date',
            style: AppStyle.bottomSheetTitle.copyWith(fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              showMyDatePicker();
            },
            child: Text(
              selectedDate.toFormatteDate,
              style: AppStyle.bottomSheetTitle.copyWith(
                fontSize: 16,
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              addToDoToFireStore();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void addToDoToFireStore() async {
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(ToDoDM.collectionName);
    DocumentReference doc = todoCollection.doc();
    ToDoDM toDoDM = ToDoDM(
        id: doc.id,
        title: titleController.text,
        date: selectedDate,
        description: descriptionController.text,
        isDone: false);
    doc
        .set(
      toDoDM.tojson(),
    )
        .timeout(const Duration(milliseconds: 500), onTimeout: () {
      Navigator.pop(context);
    });
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }
}

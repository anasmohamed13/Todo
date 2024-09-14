// ignore_for_file: must_be_immutable, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoproject/model/tododm.dart';
import 'package:todoproject/ui/providers/list_provider.dart';
import 'package:todoproject/ui/utils/app_color.dart';
import 'package:todoproject/ui/utils/app_style.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({
    super.key,
  });
  static const String routeName = "update";

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TodoDM item;
  DateTime selectedDate = DateTime.now();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late ListProvider listProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((Timestamp) {
      title.text = item.title;
      description.text = item.description;
      selectedDate = item.date;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    item = ModalRoute.of(context)?.settings.arguments as TodoDM;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: const Text(
          "To Do List",
          style: AppStyle.appBarStyle,
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.keyboard_backspace_outlined,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: AppColors.primary,
            height: MediaQuery.of(context).size.height * .1,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 40),
              height: MediaQuery.of(context).size.height * .72,
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Edit",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: title,
                      decoration: InputDecoration(hintText: item.title),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: description,
                      decoration: InputDecoration(
                        hintText: item.description,
                      ),
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
                          style: AppStyle.bottomSheetTitle
                              .copyWith(color: AppColors.grey)),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        item.title = title.text;
                        item.description = description.text;
                        item.date = selectedDate;

                        await TodoDM.userTodosCollection
                            .doc(item.id)
                            .update(item.toJson());
                        listProvider.loadTodoFromFirestore();

                        Navigator.pop(context);
                      },
                      child: const Text("Save Change"),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
}

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('add new task'),
        const TextField(
          decoration: InputDecoration(hintText: 'enter task title '),
        ),
        const TextField(
          decoration: InputDecoration(hintText: 'enter task description'),
        ),
        const Text('select date'),
        const Text('28/8/2024'),
        const Spacer(),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Add'),
        ),
      ],
    );
  }

  static void ShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context, builder: (_) => const AddBottomSheet());
  }
}

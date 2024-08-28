import 'package:flutter/material.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static void ShowBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context, builder: (_) => const AddBottomSheet());
  }
}

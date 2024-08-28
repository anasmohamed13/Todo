import 'package:flutter/material.dart';
import 'package:todoproject/ui/screens/add_bottom_sheet/add_bottom_sheet.dart';
import 'package:todoproject/ui/screens/home/tabs/list/list_tabs.dart';
import 'package:todoproject/ui/screens/home/tabs/settings/settings_tabs.dart';
import 'package:todoproject/ui/utils/app_color.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String routeName = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentindex = 0;
  List<Widget> tabs = const [ListTab(), SettingsTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do list'),
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBar(),
      body: tabs[currentindex],
    );
  }

  Widget buildBottomNavigationBar() => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: currentindex,
          onTap: (tappedindex) {
            currentindex = tappedindex;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'settings'),
          ],
        ),
      );

  buildFloatingActionButton() => FloatingActionButton(
        onPressed: () {
          AddBottomSheet.ShowBottomSheet(context);
        },
        backgroundColor: AppColors.primary,
        shape: const StadiumBorder(
          side: BorderSide(color: AppColors.white, width: 4),
        ),
        child: const Icon(Icons.add),
      );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoproject/ui/providers/list_provider.dart';
import 'package:todoproject/ui/screens/add_bottom_sheet/add_bottom_sheet.dart';
import 'package:todoproject/ui/screens/auth/login/login_screen.dart';
import 'package:todoproject/ui/screens/home/tabs/list/list_tabs.dart';
import 'package:todoproject/ui/screens/home/tabs/settings/settings_tabs.dart';
import 'package:todoproject/ui/utils/app_color.dart';
import 'package:todoproject/ui/utils/app_style.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  List<Widget> screens = [const TodosList(), const SettingsTab()];
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsetsDirectional.only(
            start: 30,
          ),
          child: Text(
            'Todo',
            style: AppStyle.appBarStyle,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              listProvider.reset();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: screens[index],
      bottomNavigationBar: buildBottomAppBar(),
      floatingActionButton: buildFab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  FloatingActionButton buildFab(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.primary,
      shape: const StadiumBorder(
          side: BorderSide(width: 4, color: AppColors.white)),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            isScrollControlled: true,
            builder: (context) => Builder(builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: const AddBottomSheet(),
                  );
                }));
      },
      child: const Icon(Icons.add),
    );
  }

  BottomAppBar buildBottomAppBar() {
    return BottomAppBar(
      notchMargin: 13,
      clipBehavior: Clip.antiAlias,
      shape: const CircularNotchedRectangle(),
      child: BottomNavigationBar(
        currentIndex: index,
        onTap: (currentIndex) {
          index = currentIndex;
          setState(() {});
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              label: '',
              icon: Icon(
                size: 37,
                Icons.list,
              )),
          BottomNavigationBarItem(
              label: '',
              icon: Icon(
                size: 37,
                Icons.settings,
              ))
        ],
        selectedItemColor: AppColors.primary,
      ),
    );
  }
}

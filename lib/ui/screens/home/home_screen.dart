import 'package:flutter/material.dart';
import 'package:todo/ui/screens/home/tabs/list/list_tab.dart';
import 'package:todo/ui/screens/home/tabs/settings/settings_tab.dart';
import 'package:todo/ui/utils/app_colors.dart';

import '../bottom_sheets/add_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: BottomNav(),
      body:
          currentSelectedTabIndex == 0 ? const ListTab() : const SettingsTab(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildFab() => FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: const AddBottomSheet(),
                  ));
        },
        child: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      );

  Widget BottomNav() => BottomAppBar(
        notchMargin: 8,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.hardEdge,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                setState(() {
                  currentSelectedTabIndex = 0;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                setState(() {
                  currentSelectedTabIndex = 1;
                });
              },
            ),
          ],
        ),
      );

  PreferredSizeWidget buildAppBar() => AppBar(
        title: const Text("To Do"),
        toolbarHeight: MediaQuery.of(context).size.height * .1,
        automaticallyImplyLeading: false,
      );
}

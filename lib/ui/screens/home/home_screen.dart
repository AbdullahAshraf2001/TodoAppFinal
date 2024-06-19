import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/app_user.dart';
import 'package:todo/ui/bottom_sheets/add_bottom_sheet.dart';
import 'package:todo/ui/provider/list_provider.dart';
import 'package:todo/ui/screens/auth/login/login_screen.dart';
import 'package:todo/ui/screens/home/tabs/list/list_tab.dart';
import 'package:todo/ui/screens/home/tabs/settings/settings_tab.dart';
import 'package:todo/ui/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedTabIndex = 0;
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: BottomNav(),
      body: currentSelectedTabIndex == 0 ? ListTab() : const SettingsTab(),
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
        title: Text("Welcome ${AppUser.currentUser!.username}"),
        actions: [
          InkWell(
              onTap: () {
                AppUser.currentUser = null;
                provider.todos.clear();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Icon(Icons.logout))
        ],
        toolbarHeight: MediaQuery.of(context).size.height * .1,
        automaticallyImplyLeading: false,
      );
}

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_dm.dart';
import 'package:todo/ui/provider/list_provider.dart';
import 'package:todo/ui/screens/home/tabs/list/todo_widget.dart';

import '../../../../utils/app_colors.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  late ListProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.refreshTodosList();
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .14,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 7,
                      child: Container(
                        color: AppColors.primary,
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: AppColors.accent,
                      ))
                ],
              ),
              CalendarTimeline(
                initialDate: provider.selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateSelected: (date) {
                  provider.selectedDate = date;
                  provider.refreshTodosList();
                },
                leftMargin: 20,
                monthColor: AppColors.white,
                dayColor: AppColors.white,
                activeDayColor: AppColors.primary,
                activeBackgroundDayColor: AppColors.white,
                dotsColor: Colors.transparent,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder: (context, index) => TodoWidget(
                    model:  provider.todos[index],
                  )),
        ),
      ],
    );
  }

}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/models/todo_dm.dart';
import 'package:todo/ui/utils/app_assets.dart';
import 'package:todo/ui/utils/app_colors.dart';
import 'package:todo/ui/utils/app_theme.dart';


class TodoWidget extends StatelessWidget {
  final TodoDM model;
  const TodoWidget({super.key,required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),

      child: Slidable(
        startActionPane: ActionPane(
            motion: DrawerMotion(),
          extentRatio: .3,
          children: [
            Container(
              child: SlidableAction(
                onPressed: (_){},
                backgroundColor: Colors.red,
                foregroundColor: AppColors.white,
                icon: Icons.delete,
                label: 'Delete',
           ),
            )
          ],),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          height: MediaQuery.of(context).size.height * .13,
          child: Row(
            children: [
              const VerticalDivider(),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.title,
                      style: AppTheme.taskTitleTextStyle,
                    ),
                    Text(
                      model.description,
                      style: AppTheme.taskDescriptionTextStyle,
                    )
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primary,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: Image.asset(AppAssets.checkBox),
              )
            ],
          ),
        ),
      ),
    );
  }
}

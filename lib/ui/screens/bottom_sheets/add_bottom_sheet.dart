import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_theme.dart';
import '../widgets/my_text_field.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * .4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Add New Task",
            textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,
          ),
          const SizedBox(height: 16,),
          MyTextField(hintText: "Enter task title", controller: titleController,),
          const SizedBox(height: 8,),
          MyTextField(hintText: "Enter task description", controller: descriptionController,),
          const SizedBox(height: 16,),
          Text(
            "Select date",
            style: AppTheme.bottomSheetTitleTextStyle
                .copyWith(fontWeight: FontWeight.w600),
          ),
          InkWell(
            onTap: (){
              showMyDatePicker();
            },
            child: Text(
              "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              textAlign: TextAlign.center,
              style: AppTheme.bottomSheetTitleTextStyle
                  .copyWith(fontWeight: FontWeight.normal, color: AppColors.grey),
            ),
          ),
          const Spacer(),
          ElevatedButton(onPressed: () {
            addTodoToFirestore();
          }, child: const Text("Add"))
        ],
      ),
    );
  }

  void addTodoToFirestore() {

  }

  Future<void> showMyDatePicker() async {
    selectedDate = await showDatePicker(context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)))?? selectedDate;
    setState(() {});
  }

}


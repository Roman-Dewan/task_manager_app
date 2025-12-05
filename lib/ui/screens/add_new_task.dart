import 'package:flutter/material.dart';
import 'package:task_manage_updated/data/services/network_caller.dart';
import 'package:task_manage_updated/data/utils/urls.dart';
import 'package:task_manage_updated/ui/widgets/show_snackbar.dart';
import '../widgets/screen_background.dart';
import '../widgets/tm_app_bar.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});
  static const String name = "/add-new-task";

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMappBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  const SizedBox(height: 64),
                  Text(
                    "Add New Task",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: InputDecoration(hintText: "title"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter the title";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 5,
                    decoration: InputDecoration(hintText: "Description"),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter the description";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Visibility(
                    visible: _addNewTaskInProgress == false,
                    replacement: Center(child: CircularProgressIndicator()),
                    child: FilledButton(
                      onPressed: _onTapSubmitButton,
                      child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  Future _addNewTask() async {
    _addNewTaskInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createNewTaskUrl,
      body: requestBody,
    );

    _addNewTaskInProgress = false;
    setState(() {});

    if (!mounted) {
      return;
    }

    if (response.isSuccess) {
      clearData();
      FocusScope.of(context).unfocus();
      showSnackBar(context, "added new task");
    } else {
      showSnackBar(context, response.error);
    }
  }

  void clearData() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:module18_19/ui/widgets/task_card.dart';
class CanceledTaskListScreen extends StatefulWidget {
  const CanceledTaskListScreen({super.key});
  @override
  State<CanceledTaskListScreen> createState() => _NewTaskListScreenState();
}
class _NewTaskListScreenState extends State<CanceledTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          children: [
            const SizedBox(),
            _buildTaskSummaryListView(),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 8,
              itemBuilder: (context, index) {
                return TaskCard();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 8);
              },
            ),
          ],
        ),
      ),
    );
  }

  // top locator bar under appbar.
  Widget _buildTaskSummaryListView() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.only(left: 8),

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  Text(
                    "12",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.black),
                  ),
                  Text("New", style: Theme.of(context).textTheme.labelLarge),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}

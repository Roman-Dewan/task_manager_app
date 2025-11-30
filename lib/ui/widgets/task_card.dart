import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        tileColor: Colors.white,
        title: Text("This is Title", style: TextTheme.of(context).titleLarge),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("This is subtitle\nasdfas"),
            Text(
              "date: 13 Nov 2025",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.black),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text("New"),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Colors.green),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

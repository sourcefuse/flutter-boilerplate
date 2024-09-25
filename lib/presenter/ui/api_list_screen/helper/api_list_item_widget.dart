// ignore_for_file: unused_import

import 'package:clean_arch/core/domain/entities/task_model.dart';
import 'package:clean_arch/presenter/ui/firebase_list_screen/data_model/item_view_model.dart';
import 'package:flutter/material.dart';

// coverage:ignore-file
class ApiListItemWidget extends StatelessWidget {
  final Task task;

  const ApiListItemWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      shadowColor: Colors.grey,
      child: ListTile(
        title: Text(
          task.name ?? "",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          task.createdAt ?? "",
        ),
      ),
    );
  }
}

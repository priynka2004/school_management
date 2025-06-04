import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/model/leave_list_model.dart';
import 'package:school_management/model/teacher_leave_list_model.dart';
import 'package:school_management/provider/leave_list_provider.dart';

class TeacherLeaveItem extends StatelessWidget {
  final TeacherLeaveModel leaveItem;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TeacherLeaveItem({
    super.key,
    required this.leaveItem,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelWithValue(label: 'ID', value: leaveItem.id.toString()),
          const SizedBox(height: 6),
          LabelWithValue(label: 'Student', value: leaveItem.studentName),
          const SizedBox(height: 6),
          LabelWithValue(label: 'Date', value: leaveItem.date),
          const SizedBox(height: 6),
          LabelWithValue(label: 'Reason', value: leaveItem.reason),
          const SizedBox(height: 6),
          LabelWithValue(label: 'Status', value: leaveItem.status),
          const SizedBox(height: 6),
          const Text('Action:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          const SizedBox(height: 6),
          Row(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.edit, color: Colors.green, size: 16),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.delete, color: Colors.red, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class LabelWithValue extends StatelessWidget {
  final String label;
  final String value;
  final Color? statusColor;

  const LabelWithValue({
    required this.label,
    required this.value,
    this.statusColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: statusColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}




import 'package:flutter/material.dart';

class StudentDropdown extends StatelessWidget {
  final String? selectedStudent;
  final List<String> students;
  final ValueChanged<String?> onChanged;

  const StudentDropdown({
    super.key,
    required this.selectedStudent,
    required this.students,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedStudent,
      isExpanded: true,
      hint: const Text('Select Student'),
      items: students.map((student) {
        return DropdownMenuItem<String>(
          value: student,
          child: Text(student),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

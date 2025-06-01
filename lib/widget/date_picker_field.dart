import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final String labelText;
  final VoidCallback onTap;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onTap,
    this.labelText = 'Select Date',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? DateFormat('MM/dd/yyyy').format(selectedDate!)
                  : labelText,
              style: const TextStyle(color: Colors.black87),
            ),
            const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

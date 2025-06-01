import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final String hintText;
  final ValueChanged<String?> onChanged;



  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      hint: Text(hintText),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
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

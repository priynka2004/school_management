import 'package:flutter/material.dart';
import 'package:school_management/utils/colors.dart';


class StudentAttendance extends StatefulWidget {
  const StudentAttendance({super.key});

  @override
  State<StudentAttendance> createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  String? selectedStudent;
  String? selectedMonth;
  String? selectedSession;
  String? selectedShowValue;
  TextEditingController searchController = TextEditingController();

  final List<String> students = ['Ayush Sharma', 'Riya Verma', 'Amit Kumar'];
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final List<String> sessions = ['2023-2024', '2024-2025', '2025-2026'];
  final List<String> showOptions = ['10', '20', '50'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance Report'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card with info and dropdowns
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rowWithStar("All fields are mandatory"),
                    const SizedBox(height: 12),
                    rowWithStar("Select Student:"),
                    dropdownField(students, selectedStudent, (value) {
                      setState(() => selectedStudent = value);
                    }),
                    const SizedBox(height: 12),
                    rowWithStar("Month:"),
                    dropdownField(months, selectedMonth, (value) {
                      setState(() => selectedMonth = value);
                    }),
                    const SizedBox(height: 12),
                    rowWithStar("Select Session:"),
                    dropdownField(sessions, selectedSession, (value) {
                      setState(() => selectedSession = value);
                    }),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // handle search logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("Search",style: TextStyle(color: AppColors.white),),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Second card with Show, Search, and Table
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Show and Search - Responsive layout
                    LayoutBuilder(
                      builder: (context, constraints) {
                        bool isSmall = constraints.maxWidth < 400;
                        return isSmall
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            showDropdownRow(),
                            const SizedBox(height: 8),
                            searchField(),
                          ],
                        )
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            showDropdownRow(),
                            searchField(width: 180),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Table Header
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        defaultColumnWidth: IntrinsicColumnWidth(),
                        border: TableBorder.all(color: Colors.grey.shade300),
                        children: [
                          TableRow(
                            decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                            children: [
                              tableHeaderCell("#"),
                              tableHeaderCellWithIcon("Admission No."),
                              tableHeaderCellWithIcon("Name"),
                              tableHeaderCellWithIcon("Mobile Number"),
                              tableHeaderCellWithIcon("Date"),
                              tableHeaderCellWithIcon("Status"),
                            ],
                          ),
                          TableRow(
                            children: List.generate(
                              6,
                                  (index) => tableCell("No data available in table"),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Showing 0 to 0 of 0 entries"),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text("Previous"),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text("Next"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget rowWithStar(String text) {
    return Row(
      children: [
        const Text("*", style: TextStyle(color: Colors.red)),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget dropdownField(List<String> items, String? selectedValue, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        isDense: true,
      ),
    );
  }
  Widget showDropdownRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Show "),
        SizedBox(
          width: 80, // increased from 60 to 80
          child: dropdownField(showOptions, selectedShowValue, (value) {
            setState(() => selectedShowValue = value);
          }),
        ),
        const SizedBox(width: 4), // spacing
        const Text(" entries"),
      ],
    );
  }


  Widget searchField({double? width}) {
    return SizedBox(
      width: width,
      height: 48, // Increased height
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search...",
          prefixIcon: const Icon(Icons.search, size: 20),
          filled: true,
          fillColor: Colors.grey[100], // Light background
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          isDense: true,
        ),
      ),
    );
  }


  Widget tableHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget tableHeaderCellWithIcon(String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 4),
          const Icon(Icons.unfold_more, size: 16),
        ],
      ),
    );
  }

  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, overflow: TextOverflow.ellipsis),
    );
  }
}
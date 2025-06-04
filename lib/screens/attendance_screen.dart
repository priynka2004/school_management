import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/model/Session.dart';
import 'package:school_management/provider/fee_provider.dart';
import 'package:school_management/provider/student_addendance_report_provider.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/string_constants.dart';

import '../model/Student.dart';

class StudentAttendanceReport extends StatefulWidget {
  const StudentAttendanceReport({super.key});

  @override
  State<StudentAttendanceReport> createState() => _StudentAttendanceReportState();
}

class _StudentAttendanceReportState extends State<StudentAttendanceReport> {
  String? selectedMonth;
  String? selectedShowValue;
  TextEditingController searchController = TextEditingController();

  final List<String> months = [
    ' January', ' February', ' March', ' April', ' May', ' June',
    ' July', ' August', 'September', ' October', ' November', ' December',
  ];


  final List<String> showOptions = ['1','2','10', '20', '50'];

  @override
  @override
  @override
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final feeProvider = Provider.of<FeeProvider>(context, listen: false);
      final parentId = 1;

      feeProvider.setParentId(parentId);
      feeProvider.loadSessions();

      if (feeProvider.students.isEmpty) {
        feeProvider.loadStudentNames(parentId);
      }


      if (feeProvider.selectedStudent != null && feeProvider.selectedSession != null) {
        final studentId = feeProvider.selectedStudent!.id;
        final sessionId = feeProvider.selectedSession!.id;
        feeProvider.loadFeeDetails(studentId, sessionId.toString());
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance Report'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: Consumer<FeeProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        DropdownButtonFormField<Student>(
                          hint: const Text(AppStrings.selectStudent),
                          value: provider.students.contains(provider.selectedStudent) ? provider.selectedStudent : null,
                          items: provider.students.map((student) {
                            return DropdownMenuItem<Student>(
                              value: student,
                              child: Text(student.name),
                            );
                          }).toList(),
                          onChanged: (Student? student) async {
                            if (student != null) {
                              final matchedStudent = provider.students.firstWhere((s) => s.id == student.id);
                              provider.setSelectedStudent(matchedStudent);

                              final sessionId = provider.selectedSession?.id.toString();
                              if (sessionId != null) {
                                await provider.loadFeeDetails(matchedStudent.id, sessionId);
                              }
                            }
                          },
                          decoration: dropdownDecoration(),
                        ),

                        const SizedBox(height: 12),
                        rowWithStar("Month:"),
                        DropdownButtonFormField<String>(
                          hint: const Text('Selected Month'),
                          value: selectedMonth,
                          items: months.map((month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(month),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMonth = value;
                            });
                          },
                          decoration: dropdownDecoration(),
                        ),

                        const SizedBox(height: 12),
                        rowWithStar("Select Session:"),
                        DropdownButtonFormField(
                          hint: const Text('Selected Session'),
                          value: provider.selectedSession,
                          items: provider.sessions.map((session) {
                            return DropdownMenuItem(
                              value: session,
                              child: Text(session.name),
                            );
                          }).toList(),

                          onChanged: (Session? session) {
                            setState(() {
                              provider.setSelectedSession(session);
                            });
                          },
                          decoration: dropdownDecoration(),
                        ),


                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              final selectedStudent = provider.selectedStudent;
                              final selectedSession = provider.selectedSession;
                              final selectedMonthIndex = months.indexOf(selectedMonth ?? '') + 1;

                              if (selectedStudent != null && selectedSession != null && selectedMonthIndex > 0) {
                                Provider.of<StudentAttendanceReportProvider>(context, listen: false)
                                    .loadAttendanceReport(
                                  studentID: selectedStudent.id,
                                  month: selectedMonthIndex.toString().padLeft(2, '0'),
                                  sessionID: selectedSession.id,
                                );
                              }


                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("Search", style: TextStyle(color: AppColors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Consumer<StudentAttendanceReportProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (provider.error != null) {
                      return Text(provider.error!);
                    } else {
                      return buildDataCard(provider);
                    }
                  },
                )


              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildDataCard(StudentAttendanceReportProvider provider) {
    final attendanceList = provider.report?.data ?? [];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  if (attendanceList.isEmpty)
                    TableRow(
                      children: List.generate(
                        6,
                            (index) => tableCell("No data available in table"),
                      ),
                    )
                  else
                    ...List.generate(attendanceList.length, (index) {
                      final attendance = attendanceList[index];
                      return TableRow(
                        children: [
                          tableCell("${index + 1}"),
                          tableCell(attendance.admissionNumber),
                          tableCell(attendance.name),
                          tableCell(attendance.mobile),
                          tableCell(attendance.date),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: attendance.status.toLowerCase() == 'present'
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.red.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                attendance.status,
                                style: TextStyle(
                                  color: attendance.status.toLowerCase() == 'present'
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),

                ],
              ),
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Showing 1 to ${attendanceList.length} of ${attendanceList.length} entries",
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: () {}, child: const Text("Previous")),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: () {}, child: const Text("Next")),
              ],
            )
          ],
        ),
      ),
    );
  }


  InputDecoration dropdownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      isDense: true,
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
      decoration: dropdownDecoration(),
    );
  }

  Widget showDropdownRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Show "),
        SizedBox(
          width: 80,
          child: dropdownField(showOptions, selectedShowValue, (value) {
            setState(() => selectedShowValue = value);
          }),
        ),
        const SizedBox(width: 4),
        const Text(" entries"),
      ],
    );
  }

  Widget searchField({double? width}) {
    return SizedBox(
      width: width,
      height: 48,
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search...",
          prefixIcon: const Icon(Icons.search, size: 20),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
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
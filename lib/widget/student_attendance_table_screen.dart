import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/provider/student_addendance_report_provider.dart';

class StudentAttendanceTableScreen extends StatelessWidget {
  const StudentAttendanceTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final report = Provider.of<StudentAttendanceReportProvider>(context).report;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Table'),
      ),
      body: report == null
          ? const Center(child: Text("No report found."))
          : ListView.builder(
        itemCount: report.data?.length ?? 0,
        itemBuilder: (context, index) {
          final entry = report.data![index];
          return ListTile(
            leading: Text("${index + 1}"),
            title: Text(entry.date ?? ''),
            subtitle: Text("Status: ${entry.status ?? 'N/A'}"),
          );
        },
      ),
    );
  }
}

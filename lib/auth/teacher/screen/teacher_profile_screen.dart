import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/teacher/screen/teacher_profile_view_screen.dart';
import 'package:school_management/utils/colors.dart';
import '../provider/teacher_profile_provider.dart';

class TeacherProfileScreen extends StatefulWidget {
  final int teacherId;
  final int branchId;

  const TeacherProfileScreen({
    super.key,
    required this.teacherId,
    required this.branchId,
  });

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final teacherId = widget.teacherId;
      final branchId = widget.branchId;

      if (teacherId != 0 && branchId != 0) {
        Provider.of<TeacherProfileProvider>(context, listen: false)
            .loadTeacher(teacherId, branchId);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('view student'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: Consumer<TeacherProfileProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.teacher.isEmpty) {
            return const Center(child: Text("No view student found"));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "view student Profile List",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Table(
                          border: TableBorder.all(color: Colors.grey.shade300),
                          defaultColumnWidth: IntrinsicColumnWidth(),
                          children: [
                            _buildTableHeader(),
                            ..._buildTableRows(provider.teacher),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
      children: [
        _headerCell("No."),
        _headerCell("Name"),
        _headerCell("Admission No."),
        _headerCell("Class & Section"),
        _headerCell("Mobile No."),
        _headerCell("Date of Birth"),
        _headerCell("Action"),
      ],
    );
  }



  List<TableRow> _buildTableRows(List<dynamic> teacherList) {
    return List.generate(teacherList.length, (index) {
      final teacher = teacherList[index];
      return TableRow(
        children: [
          _tableCell('${index + 1}'),
          _tableCell(teacher.name),
          _tableCell(teacher.admissionNumber),
          _tableCell(teacher.classSection),
          _tableCell(teacher.mobileNumber),
          _tableCell(teacher.dob),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TeacherViewProfileScreen(
                      teacherProfileModel: teacher,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appColor,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: const Text(
                "View",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      );
    });
  }


  static Widget _headerCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }
}
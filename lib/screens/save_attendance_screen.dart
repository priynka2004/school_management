import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/provider/save_attendance_provider.dart';
import 'package:school_management/utils/colors.dart';

class SaveAttendanceScreen extends StatefulWidget {
  const SaveAttendanceScreen({super.key});

  @override
  State<SaveAttendanceScreen> createState() => _SaveAttendanceScreenState();
}

class _SaveAttendanceScreenState extends State<SaveAttendanceScreen> {
  String? selectedSession;
  String? selectedClass;
  String? selectedSection;
  DateTime? selectedDate;

  final Map<String, int> sessionMap = {
    'Session 1': 1,
    'Session 2': 2,
    'Session 3': 3,
  };

  final Map<String, int> classMap = {
    'Class 1': 1,
    'Class 2': 2,
    'Class 3': 3,
  };

  final Map<String, int> sectionMap = {
    'Section A': 1,
    'Section B': 2,
    'Section C': 3,
  };

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget _buildRequiredLabel(String text) {
    return Row(
      children: [
        const Text('*', style: TextStyle(color: Colors.orange, fontSize: 18)),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SaveAttendanceProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Save attendance'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'All fields are mandatory',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.star, color: Colors.orange, size: 18),
                  ],
                ),
                const SizedBox(height: 20),

                _buildRequiredLabel('Select Session :'),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedSession,
                  hint: const Text('Select Session'),
                  items: sessionMap.keys.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedSession = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),

                const SizedBox(height: 16),

                _buildRequiredLabel('Class :'),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedClass,
                  hint: const Text('Select Class'),
                  items: classMap.keys.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedClass = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),

                const SizedBox(height: 16),

                _buildRequiredLabel('Section :'),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: selectedSection,
                  hint: const Text('Select Section'),
                  items: sectionMap.keys.map((sec) => DropdownMenuItem(value: sec, child: Text(sec))).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedSection = val;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),

                const SizedBox(height: 16),

                _buildRequiredLabel('Attendance Date :'),
                const SizedBox(height: 6),
                InkWell(
                  onTap: _pickDate,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade500),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      selectedDate == null
                          ? 'Select Date'
                          : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                      style: TextStyle(
                        fontSize: 16,
                        color: selectedDate == null ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedSession == null ||
                          selectedClass == null ||
                          selectedSection == null ||
                          selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill all mandatory fields')),
                        );
                        return;
                      }

                      final formattedDate = "${selectedDate!.year.toString().padLeft(4,'0')}-${selectedDate!.month.toString().padLeft(2,'0')}-${selectedDate!.day.toString().padLeft(2,'0')}";

                      provider.fetchAttendanceList(
                        sessionID: sessionMap[selectedSession!]!,
                        classID: classMap[selectedClass!]!,
                        sectionID: sectionMap[selectedSection!]!,
                        branchID: 1, // fix as per your need
                        date: formattedDate,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Display results / loading / error
                Expanded(
                  child: provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : provider.error != null
                      ? Center(child: Text('Error: ${provider.error}'))
                      : ListView.builder(
                    itemCount: provider.students.length,
                    itemBuilder: (context, index) {
                      final student = provider.students[index];
                      return ListTile(
                        title: Text(student.name),
                        subtitle: Text('Admission No: ${student.admissionNumber}\nMobile: ${student.mobile}\nHouse: ${student.house}'),
                        trailing: Text(student.status == "0" ? "Absent" : "Present"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

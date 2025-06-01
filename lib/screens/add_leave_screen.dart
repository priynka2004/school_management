// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:school_management/provider/fee_provider.dart';
// import 'package:school_management/utils/colors.dart';
// import 'package:school_management/widget/date_picker_field.dart';
// import 'package:school_management/widget/selected_session_dropdown.dart';
// import 'package:school_management/widget/selected_student_dropdown.dart';
//
// class AddLeaveScreen extends StatefulWidget {
//   const AddLeaveScreen({super.key});
//
//   @override
//   State<AddLeaveScreen> createState() => _AddLeaveScreenState();
// }
//
// class _AddLeaveScreenState extends State<AddLeaveScreen> {
//   String? selectedSession;
//   String? selectedStudent;
//   DateTime? selectedDate;
//
//   final List<String> sessions = ['2022-23', '2023-24'];
//   final List<String> students = ['ABC 1001 / Ayush', 'XYZ 1002 / Monika'];
//
//   Future<void> _pickDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }
//   void initState() {
//     super.initState();
//     final feeProvider = Provider.of<FeeProvider>(context, listen: false);
//     final parentId = 1;
//
//     feeProvider.setParentId(parentId);
//     feeProvider.loadSessions();
//     feeProvider.loadStudentNames(parentId);
//     if (feeProvider.selectedStudent != null &&
//         feeProvider.selectedSession != null) {
//       final studentId = feeProvider.selectedStudent!.id;
//       final sessionId = feeProvider.selectedSession!.id;
//       feeProvider.loadFeeDetails(studentId, sessionId.toString());
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F4F4),
//       appBar: AppBar(
//         title: const Text('Add Leave'),
//         backgroundColor: AppColors.appColor,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.west, color: AppColors.white),
//         ),
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Info banner
//               Row(
//                 children: const [
//                   Icon(Icons.star, color: Colors.orange),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: Text(
//                       "All fields are mandatory",
//                       style: TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 6),
//               Container(height: 4, color: AppColors.appColor),
//
//               const SizedBox(height: 20),
//
//               Row(
//                 children: const [
//                   Icon(Icons.star, color: Colors.orange, size: 16),
//                   SizedBox(width: 4),
//                   Text('Select Session:', style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//               const SizedBox(height: 6),
//               CustomDropdown(
//                 selectedValue: selectedSession,
//                 items: sessions,
//                 hintText: '--Select Session',
//                 onChanged: (value) {
//                   setState(() {
//                     selectedSession = value;
//                   });
//                 },
//               ),
//
//               const SizedBox(height: 16),
//
//               Row(
//                 children: const [
//                   Icon(Icons.star, color: Colors.orange, size: 16),
//                   SizedBox(width: 4),
//                   Text('Select Student:', style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//               const SizedBox(height: 6),
//               StudentDropdown(
//                 selectedStudent: selectedStudent,
//                 students: students,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedStudent = value;
//                   });
//                 },
//               ),
//
//
//               const SizedBox(height: 16),
//
//               // From Date
//               Row(
//                 children: const [
//                   Icon(Icons.star, color: Colors.orange, size: 16),
//                   SizedBox(width: 4),
//                   Text('From Date:', style: TextStyle(fontWeight: FontWeight.bold)),
//                 ],
//               ),
//               const SizedBox(height: 6),
//               DatePickerField(
//                 selectedDate: selectedDate,
//                 labelText: 'mm/dd/yyyy',
//                 onTap: _pickDate,
//               ),
//
//
//               const SizedBox(height: 30),
//
//               // Reason
//               Row(
//                 children: [
//                   const Icon(Icons.star, color: Colors.orange),
//                   const SizedBox(width: 4),
//                   const Text(
//                     'Reason:',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(width: 8),
//
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Type here...',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//
//               const SizedBox(height: 24),
//
//               // Save Button
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                   ),
//                   onPressed: () {
//                     if (selectedSession == null ||
//                         selectedStudent == null ||
//                         selectedDate == null) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please fill all fields'),
//                           backgroundColor: Colors.redAccent,
//                         ),
//                       );
//                       return;
//                     }
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Leave Report Generated'),
//                         backgroundColor: Colors.green,
//                       ),
//                     );
//                   },
//                   child: const Text('Save', style: TextStyle(fontSize: 16, color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/provider/fee_provider.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/widget/date_picker_field.dart';

class AddLeaveScreen extends StatefulWidget {
  const AddLeaveScreen({super.key});

  @override
  State<AddLeaveScreen> createState() => _AddLeaveScreenState();
}

class _AddLeaveScreenState extends State<AddLeaveScreen> {
  DateTime? selectedDate;
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final feeProvider = Provider.of<FeeProvider>(context, listen: false);
    feeProvider.setParentId(1); // Replace with actual parent ID
    feeProvider.loadSessions();
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text('Add Leave'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: feeProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info banner
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text("All fields are mandatory",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(height: 4, color: AppColors.appColor),
              const SizedBox(height: 20),

              // Session Dropdown
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text('Select Session:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField(
                value: feeProvider.selectedSession,
                hint: const Text('--Select Session--'),
                items: feeProvider.sessions.map((session) {
                  return DropdownMenuItem(
                    value: session,
                    child: Text(session.name),
                  );
                }).toList(),
                onChanged: (value) {
                  feeProvider.setSelectedSession(value!);
                },
              ),

              const SizedBox(height: 16),

              // Student Dropdown
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text('Select Student:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField(
                value: feeProvider.selectedStudent,
                hint: const Text('--Select Student--'),
                items: feeProvider.students.map((student) {
                  return DropdownMenuItem(
                    value: student,
                    child: Text(student.name),
                  );
                }).toList(),
                onChanged: (value) {
                  feeProvider.setSelectedStudent(value!);
                },
              ),

              const SizedBox(height: 16),

              // Date Picker
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text('From Date:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              DatePickerField(
                selectedDate: selectedDate,
                labelText: 'mm/dd/yyyy',
                onTap: _pickDate,
              ),

              const SizedBox(height: 16),

              // Reason
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text('Reason:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Type your reason...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Save Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                  ),
                  onPressed: () {
                    if (feeProvider.selectedSession == null ||
                        feeProvider.selectedStudent == null ||
                        selectedDate == null ||
                        _reasonController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Save logic here...
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Leave request submitted'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    setState(() {
                      feeProvider.setSelectedSession(null);
                      feeProvider.setSelectedStudent(null);
                      selectedDate = null;
                      _reasonController.clear();
                    });
                  },

                  child: const Text('Save',
                      style:
                      TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


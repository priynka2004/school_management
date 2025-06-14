// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:school_management/model/Student.dart';
// import 'package:school_management/provider/complain_provider.dart';
// import 'package:school_management/provider/fee_provider.dart';
// import 'package:school_management/screens/view_student_complain.dart';
// import 'package:school_management/utils/app_text_styles.dart';
// import 'package:school_management/utils/colors.dart';
// import 'package:school_management/utils/string_constants.dart';
//
// class AddComplainBoxScreen extends StatefulWidget {
//   const AddComplainBoxScreen({super.key});
//
//   @override
//   State<AddComplainBoxScreen> createState() => _AddComplainBoxScreenState();
// }
//
// class _AddComplainBoxScreenState extends State<AddComplainBoxScreen> {
//   Student? selectedStudent;
//   final TextEditingController _messageController = TextEditingController();
//   final String parentId = "1";
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Delay the provider method until after the first build frame is completed
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<FeeProvider>(context, listen: false).loadStudentNames(1);
//       Provider.of<ComplainProvider>(context, listen: false).fetchComplainList("1");
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final feeProvider = Provider.of<FeeProvider>(context);
//     final complainProvider = Provider.of<ComplainProvider>(context);
//     final List<Student> studentList = feeProvider.students;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(AppStrings.complain),
//         backgroundColor: AppColors.appColor,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.west, color: AppColors.white),
//         ),
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             TextSpan(
//                               text: '*',
//                               style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//                             ),
//                             TextSpan(
//                               text: ' Mandatory fields',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       /// Student Label
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             TextSpan(
//                               text: '* ',
//                               style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//                             ),
//                             TextSpan(
//                               text: AppStrings.students,
//                               style: TextStyle(color: Colors.black, fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//
//                       /// Student Dropdown
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.grey.shade300),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<Student>(
//                             hint: const Text(AppStrings.selectStudent),
//                             value: selectedStudent,
//                             isExpanded: true,
//                             items: studentList.map((student) {
//                               return DropdownMenuItem<Student>(
//                                 value: student,
//                                 child: Text(student.name),
//                               );
//                             }).toList(),
//                             onChanged: (Student? value) {
//                               setState(() {
//                                 selectedStudent = value;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//
//                       /// Message Label with orange star
//                       RichText(
//                         text: const TextSpan(
//                           children: [
//                             TextSpan(
//                               text: '* ',
//                               style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//                             ),
//                             TextSpan(
//                               text: AppStrings.message,
//                               style: TextStyle(color: Colors.black, fontSize: 16),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//
//                       /// Message Box
//                       TextFormField(
//                         controller: _messageController,
//                         maxLines: 4,
//                         style: const TextStyle(color: Colors.black),
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(4),
//                             borderSide: const BorderSide(color: Colors.grey),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(4),
//                             borderSide: const BorderSide(color: Colors.grey),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//
//                       /// Save Button
//                       SizedBox(
//                         width: 100,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.green,
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                           ),
//                           onPressed: complainProvider.isLoading
//                               ? null
//                               : () async {
//                             final studentId = selectedStudent?.id.toString();
//                             final message = _messageController.text.trim();
//
//                             if (studentId == null || message.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(content: Text(AppStrings.pleaseSelect)),
//                               );
//                               return;
//                             }
//
//                             await complainProvider.sendComplain(
//                               studentId: studentId,
//                               parentId: parentId,
//                               message: message,
//                               context: context,
//                             );
//
//                             await complainProvider.fetchComplainList(parentId);
//
//                             _messageController.clear();
//                             setState(() {
//                               selectedStudent = null;
//                             });
//                           },
//                           child: complainProvider.isLoading
//                               ? const CircularProgressIndicator(color: Colors.white)
//                               : const Text(
//                             AppStrings.save,
//                             style: TextStyle(
//                               color: AppColors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // Second Card (View Complaints)
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.appColor,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const ViewStudentComplain()),
//                       );
//                     },
//                     child: const Text(
//                       AppStrings.viewComplain,
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/student/provider/student_login_provider.dart';
import 'package:school_management/model/Student.dart';
import 'package:school_management/provider/complain_provider.dart';
import 'package:school_management/provider/fee_provider.dart';
import 'package:school_management/screens/view_student_complain.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/string_constants.dart';

class AddComplainBoxScreen extends StatefulWidget {
  const AddComplainBoxScreen({super.key});

  @override
  State<AddComplainBoxScreen> createState() => _AddComplainBoxScreenState();
}

class _AddComplainBoxScreenState extends State<AddComplainBoxScreen> {
  Student? selectedStudent;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final parentId = Provider.of<StudentLoginProvider>(context, listen: false).parentData?.id;
      if (parentId != null) {
        Provider.of<FeeProvider>(context, listen: false).loadStudentNames(parentId);
        Provider.of<ComplainProvider>(context, listen: false).fetchComplainList(parentId.toString());
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);
    final complainProvider = Provider.of<ComplainProvider>(context);
    final studentLoginProvider = Provider.of<StudentLoginProvider>(context);
    final parentId = studentLoginProvider.parentData?.id ?? "";
    final List<Student> studentList = feeProvider.students;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.complain),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '*',
                              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ' Mandatory fields',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Student Dropdown
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '* ',
                              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: AppStrings.students,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Student>(
                            hint: const Text(AppStrings.selectStudent),
                            value: studentList.contains(selectedStudent) ? selectedStudent : null,
                            isExpanded: true,
                            items: studentList.map((student) {
                              return DropdownMenuItem<Student>(
                                value: student,
                                child: Text(student.name ?? 'Unnamed'),
                              );
                            }).toList(),
                            onChanged: (Student? value) {
                              setState(() {
                                selectedStudent = value;
                              });
                            },
                          ),

                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Message Field
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: '* ',
                              style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: AppStrings.message,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _messageController,
                        maxLines: 4,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// Save Button
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                            onPressed: complainProvider.isLoading || parentId == null
                                ? null
                                : () async {
                              final studentId = selectedStudent?.id.toString();
                              final message = _messageController.text.trim();

                              if (studentId == null || message.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text(AppStrings.pleaseSelect)),
                                );
                                return;
                              }

                              await complainProvider.sendComplain(
                                studentId: studentId,
                                parentId: parentId.toString(),
                                message: message,
                                context: context,
                              );

                              await complainProvider.fetchComplainList(parentId.toString());

                              _messageController.clear();
                              setState(() {
                                selectedStudent = null;
                              });
                            },
                            child: complainProvider.isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            AppStrings.save,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// View Complaint Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ViewStudentComplain()),
                      );
                    },
                    child: const Text(
                      AppStrings.viewComplain,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

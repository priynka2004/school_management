import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/provider/complain_provider.dart';
import 'package:school_management/provider/fee_provider.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/string_constants.dart';

class AddComplainBoxScreen extends StatefulWidget {
  const AddComplainBoxScreen({super.key});

  @override
  State<AddComplainBoxScreen> createState() => _AddComplainBoxScreenState();
}

class _AddComplainBoxScreenState extends State<AddComplainBoxScreen> {
  String? selectedStudent;
  final TextEditingController _messageController = TextEditingController();
  final String parentId = "1";


  String? getStudentId(String? selected) {
    if (selected == null) return null;
    final parts = selected.split('/');
    if (parts.isNotEmpty) {
      return parts[0].trim();
    }
    return null;
  }



  @override
  void initState() {
    super.initState();
    final parentId = 1;
    Provider.of<FeeProvider>(context, listen: false).loadStudentNames(parentId);
    Provider.of<ComplainProvider>(context, listen: false).fetchComplainList(parentId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);
    final complainProvider = Provider.of<ComplainProvider>(context);
    List<Object> studentList = feeProvider.students ?? [];

    return Scaffold(
      backgroundColor: AppColors.appColorGrey,
      appBar: AppBar(
        title: const Text(
          AppStrings.complain,
          style: AppTextStyles.complain,
        ),
        backgroundColor: AppColors.appColorGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColors.white,
                child: Column(
                  children: [
                    Container(color: AppColors.blue, height: 7),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(AppStrings.mandatory),
                          const SizedBox(height: 5),
                          const Text(AppStrings.students),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: AppColors.appColorGrey,
                              border: Border.all(color: AppColors.appColorGrey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: const Text(AppStrings.selectStudent),
                                value: selectedStudent,
                                isExpanded: true,
                                items: studentList.map((student) {
                                  return DropdownMenuItem<String>(
                                    value: student.toString(),
                                    child: Text(student.toString()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedStudent = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(AppStrings.message),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _messageController,
                            maxLines: 4,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.appColorGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "",
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 74,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.green,
                                padding:
                                const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: complainProvider.isLoading
                                  ? null
                                  : () async {
                                final studentId = getStudentId(selectedStudent);
                                final message = _messageController.text.trim();

                                if (studentId == null || message.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            AppStrings.pleaseSelect)),
                                  );
                                  return;
                                }

                                await complainProvider.sendComplain(
                                  studentId: studentId,
                                  parentId: parentId,
                                  message: message,
                                  context: context,
                                );

                                await complainProvider.fetchComplainList(parentId);

                                _messageController.clear();
                                setState(() {
                                  selectedStudent = null;
                                });
                              },
                              child: complainProvider.isLoading
                                  ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
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
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                height: 200,
                color: AppColors.white,
                child: Column(
                  children: [
                    Container(color: AppColors.blue, height: 7),
                    GestureDetector(
                      onTap: () {
                        final complaints = complainProvider.complains;

                        showDialog(
                          context: context,
                          builder: (context) {
                            if (complaints.isEmpty) {
                              return AlertDialog(
                                title: const Text(AppStrings.complaints),
                                content: const Text(AppStrings.noFound),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(AppStrings.close),
                                  ),
                                ],
                              );
                            } else {
                              return AlertDialog(
                                title: const Text(AppStrings.complaints),
                                content: SizedBox(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: complaints.length,
                                    itemBuilder: (context, index) {
                                      final complaint = complaints[index];
                                      return ListTile(
                                       // title:
                                       // Text("Student ID: ${complaint.studentId}"),
                                        subtitle: Text(complaint.message),
                                      );
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            }
                          },
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 150, top: 8),
                        child: Text(
                          AppStrings.viewComplain,
                          style: AppTextStyles.hintStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

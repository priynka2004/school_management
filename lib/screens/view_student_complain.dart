import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/provider/complain_provider.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/string_constants.dart';
import '../auth/student/provider/student_login_provider.dart';

class ViewStudentComplain extends StatefulWidget {
  const ViewStudentComplain({super.key});

  @override
  State<ViewStudentComplain> createState() => _ViewStudentComplainState();
}

class _ViewStudentComplainState extends State<ViewStudentComplain> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final parentId = Provider.of<StudentLoginProvider>(context, listen: false).parentData?.id;
      if (parentId != null) {
        Provider.of<ComplainProvider>(context, listen: false).fetchComplainList(parentId.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final studentLoginProvider = Provider.of<StudentLoginProvider>(context);
    final complainProvider = Provider.of<ComplainProvider>(context);
    final complaints = complainProvider.complains;
    final parentId = studentLoginProvider.parentData?.id ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.complaints),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: complaints.isEmpty
          ? const Center(
        child: Text(
          AppStrings.noFound,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      )
          : ListView.builder(
        itemCount: complaints.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                      colors: [AppColors.appColor, AppColors.appColor.withOpacity(0.9)],
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          complaint.studentName ?? 'Unknown',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Body
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Message :",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            complaint.message ?? '',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16, color: AppColors.black,),
                              const SizedBox(width: 4),
                              Text(
                                complaint.date ?? '',
                                style: AppTextStyles.hintStyle,
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await complainProvider.deleteComplain(
                                parentId.toString(),
                                complaint.id.toString(),
                                context,
                              );
                              await complainProvider.fetchComplainList(parentId.toString());
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

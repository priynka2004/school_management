import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/provider/complain_provider.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/string_constants.dart';

class ViewStudentComplain extends StatefulWidget {
  const ViewStudentComplain({super.key});

  @override
  State<ViewStudentComplain> createState() => _ViewStudentComplainState();
}

class _ViewStudentComplainState extends State<ViewStudentComplain> {
  final String parentId = "1";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ComplainProvider>(context, listen: false).fetchComplainList(parentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final complainProvider = Provider.of<ComplainProvider>(context);
    final complaints = complainProvider.complains;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.complaints),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),

      body: complaints.isEmpty
          ? const Center(child: Text(AppStrings.noFound))
          : ListView.builder(
        itemCount: complaints.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(complaint.message),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await complainProvider.deleteComplain(
                    parentId,
                    complaint.id,
                    context,
                  );
                  await complainProvider.fetchComplainList(parentId);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

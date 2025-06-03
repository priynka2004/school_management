import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/storage/storage_helper.dart';
import 'package:school_management/model/leave_list_model.dart';
import 'package:school_management/provider/fee_provider.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/widget/date_picker_field.dart';
import 'package:school_management/widget/selected_student_dropdown.dart';

class AddLeaveScreen extends StatefulWidget {
  const AddLeaveScreen({super.key});

  @override
  State<AddLeaveScreen> createState() => _AddLeaveScreenState();
}

class _AddLeaveScreenState extends State<AddLeaveScreen> {
  String? selectedStudent;
  DateTime? selectedDate;
  DateTime? toDate;
  final TextEditingController _reasonController = TextEditingController();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final feeProvider = Provider.of<FeeProvider>(context, listen: false);
      feeProvider.setParentId(1);
      feeProvider.loadStudents();
    });
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

  Future<void> _pickToDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        toDate = picked;
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

              // From Date
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

              // To Date
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.orange, size: 16),
                  SizedBox(width: 4),
                  Text('To Date:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              DatePickerField(
                selectedDate: toDate,
                labelText: 'mm/dd/yyyy',
                onTap: _pickToDate,
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
                  onPressed: () async {
                    if (feeProvider.selectedStudent == null ||
                        selectedDate == null ||
                        toDate == null ||
                        _reasonController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // ✅ Create new LeaveItem for local save
                    final newLeave = LeaveItem(
                      id: DateTime.now().millisecondsSinceEpoch, // dummy ID
                      studentId: feeProvider.selectedStudent!.id.toString(),
                      parentId: '1', // replace with actual if you have it
                      studentName: feeProvider.selectedStudent!.name,
                      fromDate: selectedDate.toString(),
                      toDate: toDate.toString(),
                      reason: _reasonController.text.trim(),
                      status: 'Pending', // default for local
                      date: DateTime.now().toString(),
                    );

                    // ✅ Save to SharedPreferences
                    List<LeaveItem> leaveList = await StorageHelper.getLeaveList();
                    leaveList.add(newLeave);
                    await StorageHelper.saveLeaveList(leaveList);

                    // ✅ Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Leave request submitted'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // ✅ Clear form
                    setState(() {
                      feeProvider.setSelectedStudent(null);
                      selectedDate = null;
                      toDate = null;
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
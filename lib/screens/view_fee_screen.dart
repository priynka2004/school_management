import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/model/Session.dart';
import 'package:school_management/model/Student.dart';
import 'package:school_management/model/fee_detail.dart';
import 'package:school_management/provider/fee_provider.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class ViewFeeScreen extends StatefulWidget {
  const ViewFeeScreen({super.key});

  @override
  State<ViewFeeScreen> createState() => _ViewFeeScreenState();
}

class _ViewFeeScreenState extends State<ViewFeeScreen> {
  @override
  void initState() {
    super.initState();
    final feeProvider = Provider.of<FeeProvider>(context, listen: false);
    final parentId = 1;

    feeProvider.setParentId(parentId);
    feeProvider.loadSessions();
    feeProvider.loadStudentNames(parentId);
  }


  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImagesConst.vectorImagePath,
                  width: 432.34,
                  height: 180,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 22),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.west, color: AppColors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Stack(
                      children: [
                        Image.asset(AppImagesConst.vectorImagePath2),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, left: 40),
                          child: Image.asset(
                            AppImagesConst.rectangleImagePath,
                            height: 108,
                            width: 133,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  // Session Dropdown
                  DropdownButtonFormField<Session>(
                    decoration: InputDecoration(
                      labelText: AppStrings.session,
                      labelStyle: AppTextStyles.labelsText,
                      filled: true,
                      fillColor: AppColors.grey,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors.appColor, width: 1.5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      prefixIcon: Icon(Icons.calendar_today_outlined, color: AppColors.appColor),
                    ),
                    dropdownColor: AppColors.white,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    borderRadius: BorderRadius.circular(12),
                    elevation: 6,
                    value: feeProvider.selectedSession,
                    items: feeProvider.sessions.map((session) {
                      return DropdownMenuItem(
                        value: session,
                        child: Text(session.toString(), style: const TextStyle(fontSize: 16)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      feeProvider.setSelectedSession(value!);
                      if (feeProvider.selectedStudent != null) {
                        feeProvider.loadFeeDetails(
                          feeProvider.selectedStudent!.id,
                          value.id.toString(),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Student Dropdown
                  DropdownButtonFormField<Student>(
                    decoration: InputDecoration(
                      labelText: AppStrings.selectStudent,
                      labelStyle: AppTextStyles.labelsText,
                      filled: true,
                      fillColor: AppColors.grey,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: AppColors.appColor, width: 1.5),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      prefixIcon: Icon(Icons.person_outline, color: AppColors.appColor),
                    ),
                    dropdownColor: AppColors.white,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    borderRadius: BorderRadius.circular(12),
                    elevation: 6,
                    value: feeProvider.selectedStudent,
                    items: feeProvider.students.map((student) {
                      return DropdownMenuItem(
                        value: student,
                        child: Text(student.toString(), style: const TextStyle(fontSize: 16)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      feeProvider.setSelectedStudent(value!);
                      if (feeProvider.selectedSession != null) {
                        feeProvider.loadFeeDetails(
                          value.id,
                          feeProvider.selectedSession!.id.toString(),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  if (feeProvider.selectedStudent != null &&
                      feeProvider.selectedSession != null &&
                      feeProvider.feeDetails.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '📄 Student Wise Fee Report',
                          style: AppTextStyles.labelsText.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Horizontal Scrollable Table in Card
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.blue.shade100,
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                  child: Row(
                                    children: const [
                                      _TableHeaderCell('#'),
                                      _TableHeaderCell('Session'),
                                      _TableHeaderCell('Name'),
                                      _TableHeaderCell('Month'),
                                      _TableHeaderCell('Fee'),
                                      _TableHeaderCell('Transport'),
                                      _TableHeaderCell('Payable'),
                                      _TableHeaderCell('Paid'),
                                      _TableHeaderCell('Mode'),
                                      _TableHeaderCell('Date'),
                                    ],
                                  ),
                                ),
                                ...feeProvider.feeDetails.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  FeeDetail fee = entry.value;
                                  return Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey.shade300),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        _TableCell('${index + 1}'),
                                        _TableCell(fee.session ?? '-'),
                                        _TableCell(fee.name ?? '-'),
                                        _TableCell(fee.month ?? '-'),
                                        _TableCell('₹${double.tryParse(fee.totalFee)?.toStringAsFixed(2) ?? '0.00'}'),
                                        _TableCell('₹${double.tryParse(fee.transportFee)?.toStringAsFixed(2) ?? '0.00'}'),
                                        _TableCell('₹${double.tryParse(fee.payableFee)?.toStringAsFixed(2) ?? '0.00'}'),
                                        _TableCell('₹${double.tryParse(fee.paidAmount)?.toStringAsFixed(2) ?? '0.00'}'),
                                        _TableCell(fee.mode ?? '-'),
                                        _TableCell(fee.date ?? '-'),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Balance Row
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Balance: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '₹${_calculateBalance(feeProvider.feeDetails).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: _calculateBalance(feeProvider.feeDetails) < 0 ? Colors.red : Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateBalance(List<FeeDetail> details) {
    double totalPayable = 0;
    double totalPaid = 0;

    for (var fee in details) {
      totalPayable += double.tryParse(fee.payableFee ?? '') ?? 0.0;
      totalPaid += double.tryParse(fee.paidAmount ?? '') ?? 0.0;
    }

    return totalPaid - totalPayable;
  }


}


class _TableHeaderCell extends StatelessWidget {
  final String text;
  const _TableHeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  const _TableCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 100,
        alignment: Alignment.centerLeft,
        child: Text(text, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}


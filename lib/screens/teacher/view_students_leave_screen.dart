import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/teacher/model/view_student_leave_model.dart';
import 'package:school_management/provider/view_student_leave_provider.dart';
import 'package:school_management/utils/colors.dart';

class ViewStudentsLeave extends StatefulWidget {
  const ViewStudentsLeave({super.key});

  @override
  State<ViewStudentsLeave> createState() => _ViewStudentsLeaveState();
}

class _ViewStudentsLeaveState extends State<ViewStudentsLeave> {
  String selectedValue = 'All';
  String searchQuery = '';
  List<String> dropdownItems = ['All', 'Approved', 'Pending', 'Rejected'];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ViewStudentLeaveProvider>(context, listen: false)
          .loadLeaveList(teacherId: 1, branchId: 1);
    });
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewStudentLeaveProvider>(context);
    final leaveList = provider.leaveData?.data ?? [];

    final filteredList = leaveList.where((item) {
      final matchesStatus = selectedValue == 'All' ||
          (item.status ?? '').toLowerCase() == selectedValue.toLowerCase();
      final matchesSearch = searchQuery.isEmpty ||
          (item.student ?? '').toLowerCase().contains(searchQuery) ||
          (item.reason ?? '').toLowerCase().contains(searchQuery);
      return matchesStatus && matchesSearch;
    }).toList();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Approve Leave List'),
        backgroundColor: AppColors.appColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "View Leave List",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _filterRow(),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      defaultColumnWidth: IntrinsicColumnWidth(),
                      children: [
                        _buildTableHeader(),
                        ..._buildTableRows(filteredList),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Showing 1 to ${filteredList.length} of ${filteredList.length} entries",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Previous",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Next",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterRow() {
    return Row(
      children: [
        Row(
          children: [
            const Text("Show: "),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: selectedValue,
              items: dropdownItems.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              },
            ),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search by name or reason",
                prefixIcon: const Icon(Icons.search, size: 20),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableHeader() {
    return const TableRow(
      decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: Text("#", style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(8.0), child: Text("Class", style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(8.0), child: Text("Student", style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(8.0), child: Text("From", style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(8.0), child: Text("To", style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(8.0), child: Text("Reason", style: TextStyle(fontWeight: FontWeight.bold))),
        Padding(padding: EdgeInsets.all(8.0), child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    );
  }

  List<TableRow> _buildTableRows(List<LeaveEntry> dataList) {
    return List.generate(dataList.length, (index) {
      final item = dataList[index];
      return TableRow(
        children: [
          _tableCell("${index + 1}"),
          _tableCell(item.className),
          _tableCell(item.student),
          _tableCell(item.date),
          _tableCell(item.date),
          _tableCell(item.reason),
          GestureDetector(
            onTap: () async {
              final displayText = (item.status == null || item.status!.isEmpty) ? "Click here" : item.status!;

              if (displayText == "Click here") {
                // Call approve leave API
                final provider = Provider.of<ViewStudentLeaveProvider>(context, listen: false);
                final success = await provider.approveLeave(item.id);


                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? "Leave approved successfully"
                        : "Failed to approve leave"),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Clicked on $displayText")),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (item.status == null || item.status!.isEmpty) ? Colors.orange : _statusColor(item.status),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      (item.status == null || item.status!.isEmpty) ? "Click here" : item.status!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.check_circle, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
          ),





        ],
      );
    });
  }


  Widget _tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }
  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.red;
      case 'rejected':
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

}

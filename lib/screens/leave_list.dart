import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/provider/leave_list_provider.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/widget/student_leave_item.dart';

class LeaveList extends StatefulWidget {
  const LeaveList({super.key});

  @override
  State<LeaveList> createState() => _LeaveListState();
}

class _LeaveListState extends State<LeaveList> {
  String dropdownValue = '10';
  bool _initialized = false;
  final TextEditingController _searchController = TextEditingController();


  List<Map<String, dynamic>> _filteredStudents = [];

  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<LeaveListProvider>(context, listen: false).fetchLeaveList()
    );
  }


  void _filterSearch(String query) {
    final leaveProvider = Provider.of<LeaveListProvider>(context, listen: false);
    final allLeaves = leaveProvider.leaveList;

    if (query.isEmpty) {
      _filteredStudents = allLeaves.map((leave) => leave.toJson()).toList();
    } else {
      _filteredStudents = allLeaves.where((leave) {
        final studentName = leave.studentName.toLowerCase();
        final reason = leave.reason.toLowerCase();
        final searchLower = query.toLowerCase();
        return studentName.contains(searchLower) || reason.contains(searchLower);
      }).map((leave) => leave.toJson()).toList();
    }
    Provider.of<LeaveListProvider>(context);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      Provider.of<LeaveListProvider>(context, listen: false)
          .fetchLeaveList()
          .then((_) {
        _filterSearch(dropdownValue);
      });
      _initialized = true;
    }
  }


  @override
  Widget build(BuildContext context) {
    int maxEntries = int.tryParse(dropdownValue) ?? 10;
    List<Map<String, dynamic>> visibleStudents = _filteredStudents.take(maxEntries).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(

        title: const Text('Leave List',style: TextStyle(color:AppColors.white ),),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        backgroundColor: AppColors.appColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Show'),
                    const SizedBox(width: 6),
                    DropdownButton<String>(
                      value: dropdownValue,
                      items: ['10', '25', '50', '100'].map((String value) {
                        return DropdownMenuItem(value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                    const SizedBox(width: 6),
                    const Text('entries'),
                  ],
                ),
                SizedBox(
                  width: 180,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search...',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: _filterSearch,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              color: const Color(0xFFB3E5FC),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: const Text(
                'Student Leave Record',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Consumer<LeaveListProvider>(
                builder: (context, leaveProvider, child) {
                  if (leaveProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (leaveProvider.leaveList.isEmpty) {
                    return const Center(child: Text("No leave records found"));
                  }

                  return ListView.builder(
                    itemCount: leaveProvider.leaveList.length,
                    itemBuilder: (context, index) {
                      final leaveItem = leaveProvider.leaveList[index];

                      return StudentLeaveItem(
                        leaveItem: leaveItem, // Ensure this is the correct LeaveItem type
                        onEdit: () {
                          // Edit logic here
                        },
                        onDelete: () {
                          // Delete logic here
                        },
                        student: {}, // optional
                      );
                    },
                  );
                },
              ),
            ),



            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Consumer<LeaveListProvider>(
                builder: (context, leaveProvider, child) {
                  final total = leaveProvider.leaveList.length;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Showing $total of $total entries',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Row(
                        children: [
                          TextButton(onPressed: () {}, child: const Text('Previous')),
                          TextButton(onPressed: () {}, child: const Text('Next')),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
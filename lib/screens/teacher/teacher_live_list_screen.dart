import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/model/leave_list_model.dart';
import 'package:school_management/model/teacher_leave_list_model.dart';
import 'package:school_management/provider/teacher_leave_provider.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/widget/teacher_live_item.dart';

class TeacherLeaveListScreen extends StatefulWidget {
  final int teacherID;
  final int branchID;

  const TeacherLeaveListScreen({
    super.key,
    required this.teacherID,
    required this.branchID,
  });

  @override
  State<TeacherLeaveListScreen> createState() => _TeacherLeaveListScreenState();
}

class _TeacherLeaveListScreenState extends State<TeacherLeaveListScreen> {
  String dropdownValue = '10';
  final TextEditingController _searchController = TextEditingController();
  List<TeacherLeaveModel> _filteredList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Provider.of<TeacherLeaveProvider>(context, listen: false)
          .fetchLeaves(widget.teacherID, widget.branchID);
      _filterSearch('');
    });
  }

  void _filterSearch(String query) {
    final provider = Provider.of<TeacherLeaveProvider>(context, listen: false);
    final all = provider.leaveList;

    if (query.isEmpty) {
      _filteredList = all;
    } else {
      _filteredList = all.where((item) {
        final name = item.studentName.toLowerCase();
        final reason = item.reason.toLowerCase();
        return name.contains(query.toLowerCase()) ||
            reason.contains(query.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int maxEntries = int.tryParse(dropdownValue) ?? 10;
    List<TeacherLeaveModel> visibleList = _filteredList.take(maxEntries).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        title: const Text('Leave List', style: TextStyle(color: AppColors.white)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        backgroundColor: AppColors.appColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Show'),
                    const SizedBox(width: 6),
                    DropdownButton<String>(
                      value: dropdownValue,
                      items: ['10', '25', '50', '100']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) {
                        setState(() => dropdownValue = value!);
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

            /// List Section
            Expanded(
              child: Consumer<TeacherLeaveProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_filteredList.isEmpty) {
                    return const Center(child: Text("No leave records found"));
                  }

                  return ListView.builder(
                    itemCount: visibleList.length,
                    itemBuilder: (context, index) {
                      final item = visibleList[index];
                      return TeacherLeaveItem(
                        leaveItem: item,
                        onEdit: () {},
                        onDelete: () {},
                      );
                    },
                  );

                },
              ),
            ),


            /// Pagination Summary
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Showing ${visibleList.length} of ${_filteredList.length} entries',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Row(
                    children: [
                      TextButton(onPressed: () {}, child: const Text('Previous')),
                      TextButton(onPressed: () {}, child: const Text('Next')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

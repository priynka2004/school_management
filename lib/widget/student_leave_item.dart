import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/model/leave_list_model.dart';
import 'package:school_management/provider/leave_list_provider.dart';

class StudentLeaveItem extends StatelessWidget {
  final Map<String, dynamic> student;
  final LeaveItem leaveItem;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const StudentLeaveItem({
    super.key,
    required this.student,
    required this.leaveItem,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
  final leaveProvider = Provider.of<LeaveListProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelWithValue(label: 'ID', value: leaveItem.id.toString()),
          const SizedBox(height: 6),
          LabelWithValue(label: 'Student', value: leaveItem.studentName),
          const SizedBox(height: 6),
          LabelWithValue(label: 'Date', value: leaveItem.date),
          const SizedBox(height: 6),
          LabelWithValue(label: 'Reason', value: leaveItem.reason),
          const SizedBox(height: 6),
          LabelWithValue(label: 'Status', value: leaveItem.status),
          const SizedBox(height: 6),
          const Text('Action:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
          const SizedBox(height: 6),
          Row(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.edit, color: Colors.green, size: 16),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.delete, color: Colors.red, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class LabelWithValue extends StatelessWidget {
  final String label;
  final String value;
  final Color? statusColor;

  const LabelWithValue({
    required this.label,
    required this.value,
    this.statusColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: statusColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:school_management/auth/ModelClass/leave_list_model.dart';
// import 'package:school_management/auth/provider/leave_list_provider.dart';
//
// class StudentLeaveItem extends StatefulWidget {
//   final Map<String, dynamic> student;
//   final LeaveItem leaveItem;
//   final VoidCallback onEdit;
//   final VoidCallback onDelete;
//   final String parentId;
//
//
//   const StudentLeaveItem({
//     super.key,
//     required this.leaveItem,
//     required this.student,
//     required this.onEdit,
//     required this.onDelete, required this.parentId,
//   });
//
//   @override
//   State<StudentLeaveItem> createState() => _StudentLeaveItemState();
// }
//
// class _StudentLeaveItemState extends State<StudentLeaveItem> {
//
//   Widget build(BuildContext context) {
//     final leaveProvider = Provider.of<LeaveListProvider>(context, listen: false);
//
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: Colors.grey)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           LabelWithValue(label: 'ID', value: leaveItem.id.toString()),
//           const SizedBox(height: 6),
//           LabelWithValue(label: 'Student', value: leaveItem.studentName),
//           const SizedBox(height: 6),
//           LabelWithValue(label: 'Date', value: leaveItem.date),
//           const SizedBox(height: 6),
//           LabelWithValue(label: 'Reason', value: leaveItem.reason),
//           const SizedBox(height: 6),
//           LabelWithValue(label: 'Status', value: leaveItem.status),
//           const SizedBox(height: 6),
//           const Text('Action:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
//           const SizedBox(height: 6),
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: onEdit,
//                 child: Container(
//                   decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(6)),
//                   padding: const EdgeInsets.all(10),
//                   child: const Icon(Icons.edit, color: Colors.green, size: 16),
//                 ),
//               ),
//               const SizedBox(width: 10),
//               GestureDetector(
//                 onTap: onDelete,
//                 child: Container(
//                   decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(6)),
//                   padding: const EdgeInsets.all(10),
//                   child: const Icon(Icons.delete, color: Colors.red, size: 16),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class LabelWithValue extends StatelessWidget {
//   final String label;
//   final String value;
//   final Color? statusColor;
//
//   const LabelWithValue({
//     required this.label,
//     required this.value,
//     this.statusColor,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       text: TextSpan(
//         text: '$label: ',
//         style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12),
//         children: [
//           TextSpan(
//             text: value,
//             style: TextStyle(
//               fontWeight: FontWeight.normal,
//               color: statusColor ?? Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:school_management/auth/provider/leave_list_provider.dart';
// import 'student_leave_item.dart';
//
// class StudentLeaveScreen extends StatefulWidget {
//   const StudentLeaveScreen({super.key});
//
//   @override
//   State<StudentLeaveScreen> createState() => _StudentLeaveScreenState();
// }
//
// class _StudentLeaveScreenState extends State<StudentLeaveScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<LeaveListProvider>(context, listen: false).fetchLeaveList('1');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<LeaveListProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Student Leave List")),
//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: provider.leaveList.length,
//         itemBuilder: (context, index) {
//           final item = provider.leaveList[index];
//           return StudentLeaveItem(
//             student: {
//               '#': item.id,
//               'Student': item.studentName,
//               'Date': item.date,
//               'Reason': item.reason,
//               'Status': item.status,
//               'StatusColor': item.status == 'Pending'
//                   ? Colors.orange
//                   : item.status == 'Approved'
//                   ? Colors.green
//                   : Colors.red,
//             },
//             onEdit: () {
//               print('Edit: ${item.id}');
//             },
//             onDelete: () {
//               print('Delete: ${item.id}');
//             },
//           );
//         },
//       ),
//     );
//   }
// }


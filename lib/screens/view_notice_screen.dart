import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/model/view_notice_model.dart';
import 'package:school_management/provider/view_notice_provider.dart';
import 'package:school_management/utils/colors.dart';

class ViewNoticeScreen extends StatefulWidget {
  const ViewNoticeScreen({Key? key}) : super(key: key);

  @override
  State<ViewNoticeScreen> createState() => _ViewNoticeScreenState();
}

class _ViewNoticeScreenState extends State<ViewNoticeScreen> {
  final List<String> showOptions = ["5", "10", "20", "50"];
  String selectedShowValue = "10";

  final TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  void initState() {
    super.initState();
    // Load notices for parentId = 1 (change as needed)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ViewNoticeProvider>(context, listen: false).loadNotices(1);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewNoticeProvider>(context);
    final List<ViewNoticeModel> noticeList = provider.notices;

    // Filter based on search text
    final filteredList = noticeList.where((notice) {
      final searchLower = searchText.toLowerCase();
      return notice.forWhom.toLowerCase().contains(searchLower) ||
          notice.className.toLowerCase().contains(searchLower) ||
          notice.branch.toLowerCase().contains(searchLower) ||
          notice.notice.toLowerCase().contains(searchLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('View Notice'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.error != null
              ? Center(child: Text('Error: ${provider.error}'))
              : buildDataCard(filteredList, noticeList.length),
        ),
      ),
    );
  }

  Widget buildDataCard(List<ViewNoticeModel> filteredList, int totalCount) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "View Notice List",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerLeft,
              child: showDropdownRow(),
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 338,
                child: TextField(
                  controller: searchController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    labelText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    suffixIcon: searchText.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          searchText = "";
                        });
                      },
                    )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: IntrinsicColumnWidth(),
                border: TableBorder.all(color: Colors.grey.shade300),
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
                    children: const [
                      _TableHeaderCell("#"),
                      _TableHeaderCell("For"),
                      _TableHeaderCell("Class"),
                      _TableHeaderCell("Branch"),
                      _TableHeaderCell("Notice"),
                    ],
                  ),
                  if (filteredList.isEmpty)
                    TableRow(
                      children: List.generate(
                        5,
                            (index) => const _TableCell("No data available in table"),
                      ),
                    )
                  else
                    ...List.generate(filteredList.length, (index) {
                      final notice = filteredList[index];
                      return TableRow(
                        children: [
                          _TableCell("${index + 1}"),
                          _TableCell(notice.forWhom),
                          _TableCell(notice.className),
                          _TableCell(notice.branch),
                          _TableCell(notice.notice),
                        ],
                      );
                    }),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Showing 1 to ${filteredList.length} of $totalCount entries",
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: () {}, child: const Text("Previous")),
                const SizedBox(width: 8),
                OutlinedButton(onPressed: () {}, child: const Text("Next")),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget showDropdownRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Show "),
        SizedBox(
          width: 70,
          height: 38,
          child: dropdownField(showOptions, selectedShowValue, (value) {
            setState(() => selectedShowValue = value!);
          }),
        ),
        const SizedBox(width: 4),
        const Text(" entries"),
      ],
    );
  }

  Widget dropdownField(
      List<String> options, String selected, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selected,
      items: options
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}

class _TableHeaderCell extends StatelessWidget {
  final String text;
  const _TableHeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
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
      child: Text(text),
    );
  }
}

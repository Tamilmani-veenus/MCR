//
// import 'package:get/get.dart';
//
// import '../../../../controller/comman_controller.dart';
// import '../../../../home/menu/daily_entries/subcontractor_attendance_site/subattendance_site_entry.dart';
// import '../../../../home/menu/daily_entries/subcontractor_attendance_site/subattendance_site_entry_list.dart';
// import 'package:flutter/material.dart';
//
//
// class SubContractorSiteAttendance extends StatefulWidget {
//   int selectedPage;
//
//   SubContractorSiteAttendance(this.selectedPage);
//
//   @override
//   State<SubContractorSiteAttendance> createState() =>
//       _SubContractorSiteAttendanceState();
// }
//
// class _SubContractorSiteAttendanceState extends State<SubContractorSiteAttendance>
//     with SingleTickerProviderStateMixin {
//
//   CommanController commanController=Get.put(CommanController());
//   @override
//   void initState() {
//     var duration = Duration(seconds: 0);
//     Future.delayed(duration,() async {
//      // await commanController.getControllEntryListRights();
//     });
//     super.initState();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       initialIndex: widget.selectedPage,
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).primaryColor,
//           title: const Text('SubContractor Attendance'),
//           bottom: TabBar(
//             indicatorColor: Colors.white,
//             tabs: [
//
//               Tab(text: 'Entry'),
//               Tab(text: 'Entry List'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             SubattendanceSiteEntry(),
//             SubAttendanceSiteEntryList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
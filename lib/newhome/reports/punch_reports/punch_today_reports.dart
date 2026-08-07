import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/punch_in_controller.dart';
import 'package:intl/intl.dart';
import '../../../utilities/baseutitiles.dart';


class PunchTodayReports extends GetView<PunchInController> {
  // const PunchTodayReports({super.key});

  LoginController loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return controller.obx((state) => SafeArea(
      top: false,
      child: Scaffold(
        body: Container(
          color: Setmybackground,
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16.r, left: 8.r, right: 8.r, bottom: 8.r),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: TextFormField(
                            readOnly: true,
                            controller: controller.todayDate,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Today Date",
                              labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: Icon(Icons.calendar_month,
                                      color: Theme.of(context).primaryColor)),
                            ),
                            onTap: () async {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.r, right: 16.r),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            side: const BorderSide(width: 3, color: Colors.white),
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            await controller.todayPunchInController(controller.todayDate.text);
                          },
                          child: const Text("Show"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              loginController.user.value.userType=="A"? Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 8.r),
                child: Container(
                  // margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 3,
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: controller.todayRpteditingController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 12),
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 5, left: 15),
                          child: ConstIcons.list_Search,
                        ),
                        hintText: "Search..",
                        hintStyle: TextStyle(color: Colors.black),
                        isDense: true,
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        controller.filterSearchTodayReport(value);
                      },
                    ),
                  ),
                ),
              ):SizedBox(),
              Padding(
                padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 8.r),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.white,
                  child: SizedBox(
                    height: 30.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.r, right: 8.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Staff name",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.filteredList?.length,
                  itemBuilder: (context, i) {
                    var employee = controller.filteredList?[i];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        elevation: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  (employee!.staffName != "" && employee!.staffName != "null")
                                      ? employee!.staffName!
                                      : "-",
                                  style:  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 15),
                              ...(employee.punchDetails != null && employee.punchDetails!.isNotEmpty
                                  ? employee.punchDetails!.map((detail) {
                                bool isLastItem = detail == employee.punchDetails!.last;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(detail.punchInProjectName.toString()=="0"?"On Duty":detail.punchInProjectName.toString(),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black),),

                                      SizedBox(height: 5,),

                                      Text("In Time    : ${detail.punchInTime.toString() != "" && detail.punchInTime.toString() != "null" ? DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(detail.punchInTime.toString())): "        -   "}",style: const TextStyle(fontSize: 12.0),),

                                      detail.punchInOnDutyStatus=='Y' ? Text("In Address  : ${detail.punchInOnDutyAddress.toString() != "-" && detail.punchInOnDutyAddress.toString() != "null" ? detail.punchInOnDutyAddress.toString(): "        -   "}",style: const TextStyle(fontSize: 12.0),):SizedBox(),
                                      SizedBox(height: 5,),

                                      (detail.punchInOnDutyStatus=='Y' && detail.punchOutOnDutyStatus=="Y" || detail.punchInProjectName == detail.punchOutProjectName) ?
                                      SizedBox(height: 5,):Text(detail.punchOutProjectName.toString()=="0" && detail.punchOutOnDutyStatus=="N"?"":detail.punchOutProjectName.toString()=="0" && detail.punchOutOnDutyStatus=="Y"?"On Duty":detail.punchOutProjectName.toString(),style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black)),

                                      // detail.punchOutOnDutyStatus=='Y' && detail.punchInProjectName == detail.punchOutProjectName ? SizedBox():SizedBox(height: 5),

                                      Text("Out Time : ${detail.punchOutTime.toString() != "" && detail.punchOutTime.toString() != "null" ? DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(detail.punchOutTime.toString())): "        -    "}",style: const TextStyle(fontSize: 12.0),),

                                      detail.punchOutOnDutyStatus=='Y' ? Text("Out Address  : ${detail.punchOutOnDutyAddress.toString() != "-" && detail.punchOutOnDutyAddress.toString() != "null" ? detail.punchOutOnDutyAddress.toString(): "        -   "}",style: const TextStyle(fontSize: 12.0),):SizedBox(),

                                      SizedBox(height: 5,),

                                      if (!isLastItem) Divider(),
                                    ],
                                  ),
                                );
                              }).toList()
                                  : [
                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: const Center(
                                    child: Text(
                                      "No details found",
                                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

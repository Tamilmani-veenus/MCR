import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_theme/app_colors.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../controller/bottomsheet_Controllers.dart';
import '../../../controller/logincontroller.dart';
import '../../../controller/punch_in_controller.dart';
import '../../../controller/staffcontroller.dart';
import '../../../models/punch_filter_response.dart';


class PunchSearchReports extends GetView<PunchInController> {
  PunchSearchReports({super.key});

  final PunchInController punchInController = Get.put(PunchInController());
  final LoginController loginController = Get.put(LoginController());
  final StaffController staffController = Get.put(StaffController());
  final BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return controller.obx((state) => StatefulBuilder(builder: (BuildContext context, setState) {
      return SafeArea(
        top: false,
        child: Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: Setmybackground,
            body: SizedBox(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.r),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: TextFormField(
                                readOnly: true,
                                controller: punchInController.fromDate,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "From Date",
                                  labelStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints: const BoxConstraints(
                                      minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  var fromDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2010),
                                      lastDate: DateTime.now(),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary:
                                              Theme.of(context).primaryColor,
                                              onPrimary: Colors.white,
                                              onSurface: Colors.black,
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.black,
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      });
                                  if (fromDate != null) {
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(fromDate);
                                    punchInController.fromDate.text =
                                        formattedDate;
                                  } else {
                                    if (kDebugMode) {
                                      print("Date is not selected");
                                    }
                                  }
                                },
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
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: TextFormField(
                                readOnly: true,
                                controller: punchInController.toDate,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "To Date",
                                  labelStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints: const BoxConstraints(
                                      minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Icon(Icons.calendar_month,
                                          color: Theme.of(context).primaryColor)),
                                ),
                                onTap: () async {
                                  var todate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2010),
                                      lastDate: DateTime.now(),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary:
                                              Theme.of(context).primaryColor,
                                              onPrimary: Colors.white,
                                              onSurface: Colors.black,
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors
                                                    .black, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      });
                                  if (todate != null) {
                                    String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(todate);
                                    punchInController.toDate.text = formattedDate;
                                  } else {
                                    if (kDebugMode) {
                                      print("Date is not selected");
                                    }
                                  }
                                },
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
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.r),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                          readOnly: true,
                          controller: staffController.Staffname,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Staff Name *",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.siteName,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (loginController.user.value.userType == "A") {
                                bottomsheetControllers.StaffName(context, staffController.getStaffDropdownvalue.value);
                                FocusScope.of(context).unfocus();
                              } else {
                                null;
                              }
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == "SELECT") {
                              return '\u26A0 Please select staff name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.r, right: 16.r),
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          side: const BorderSide(width: 3, color: Colors.white),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await punchInController.punchFilterController(
                                punchInController.fromDate.text,
                                punchInController.toDate.text,
                                staffController.selectedstaffId.value);
                          }else{
                            punchInController.punchFilterRxList.value=[];
                          }
                        },
                        child: const Text("Show"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(() => (punchInController.punchFilterRxList.length!=0) ?
                    ListView.builder(
                      itemCount: punchInController.punchFilterRxList.length,
                      itemBuilder: (context, index) {
                        EmployeeTiming listItem = punchInController.punchFilterRxList[index];

                        return Container(
                          padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 10.r),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 3,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      listItem.staffName.toString().isNotEmpty && listItem.staffName != "null"
                                          ? listItem.staffName.toString()
                                          : "-",
                                      style:  TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 15),

                                  ...(listItem.punchDetails != null && listItem.punchDetails!.isNotEmpty
                                      ? listItem.punchDetails!.map((index) {
                                    bool isLastItem = index == listItem.punchDetails!.last;
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(index.punchInProjectName.toString()=="-"?"On Duty":index.punchInProjectName.toString(),style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),

                                          SizedBox(height: 5,),

                                          Text("In Time    : ${index.punchInTime.toString() != "" && index.punchInTime.toString() != "null" ?  DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(index.punchInTime.toString())): "        -   "}",style: const TextStyle(fontSize: 12.0),),

                                          Text("In Date     : ${index.punchInDate.toString() != "" && index.punchInDate.toString() != "null" ? index.punchInDate.toString(): "        -   "}",style: const TextStyle(fontSize: 12.0),),

                                          index.punchInOnDutyStatus=='Y' ?
                                          Text("In Address      : ${index.punchInOnDutyAddress.toString() != "-" && index.punchInOnDutyAddress.toString() != "null" ? index.punchInOnDutyAddress.toString(): "        -   "}",style: const TextStyle(fontSize: 12.0),):SizedBox(),
                                          SizedBox(height: 5,),

                                          (index.punchInOnDutyStatus=='Y' && index.punchOutOnDutyStatus=="Y" || index.punchInProjectName == index.punchOutProjectName) ?
                                          SizedBox(height: 5,): Text(index.punchOutProjectName.toString()=="-" && index.punchOutOnDutyStatus=="N"?"":index.punchOutProjectName.toString()=="-" && index.punchOutOnDutyStatus=="Y"?"On Duty":index.punchOutProjectName.toString(),style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),

                                          // index.punchOutOnDutyStatus=='Y' && index.punchInProjectName == index.punchOutProjectName ? SizedBox():SizedBox(height: 5),

                                          Text("Out Time : ${index.punchOutTime.toString() != "" && index.punchOutTime.toString() != "null" ? DateFormat("hh:mm a").format(DateFormat("HH:mm:ss").parse(index.punchOutTime.toString())): "        -    "}",style: const TextStyle(fontSize: 12.0),),

                                          Text("Out Date  : ${index.punchOutDate.toString() != "" && index.punchOutDate.toString() != "null" ? index.punchOutDate.toString(): "        -   "}",style: const TextStyle(fontSize: 12.0),),

                                          index.punchOutOnDutyStatus=='Y'? Text("Out Address  : ${index.punchOutOnDutyAddress.toString() != "-" && index.punchOutOnDutyAddress.toString() != "null" ? index.punchOutOnDutyAddress.toString(): "        -   "}",style: const TextStyle(fontSize: 12.0),):SizedBox(),

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
                    ):SizedBox()
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }),
    );
  }

}
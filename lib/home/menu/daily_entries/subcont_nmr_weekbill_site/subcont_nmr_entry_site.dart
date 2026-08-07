import 'package:mcr/home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_deduction_site.dart';

import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/bottomsheet_Controllers.dart';
import '../../../../controller/dailyentries_controller.dart';
import '../../../../controller/nmrweeklybill_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Subcont_Nmr_EntryScreen_Site extends StatefulWidget {
  const Subcont_Nmr_EntryScreen_Site({Key? key}) : super(key: key);

  @override
  State<Subcont_Nmr_EntryScreen_Site> createState() => _Subcont_Nmr_EntryScreenState_Site();
}

class _Subcont_Nmr_EntryScreenState_Site extends State<Subcont_Nmr_EntryScreen_Site> {

  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController=Get.put(AutoYearWiseNoController());
  NMRWklyController nmrWklyController= Get.put(NMRWklyController());
  // HDTRefreshController _hdtRefreshController = HDTRefreshController();
  DailyEntriesController dailyEntriesController = Get.put(DailyEntriesController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());


  @override
  void initState(){
    var duration = Duration(seconds: 0);
    Future.delayed(duration,() async {
      await autoYearWiseNoController.NMR_AutoYearWise();
      await projectController.getProjectList(context, 0);
      await subcontractorController.getSubcontList(context, projectController.selectedProjectId.value, subcontractorController.checkScreen);
      nmrWklyController.autoYearWiseNoController.text=autoYearWiseNoController.NMR_autoYrsWise.value;
      if(nmrWklyController.editCheck==1){
        nmrWklyController.EditListSaveDatas.value.forEach((element) {
          siteController.Sitename.text=element.siteName.toString();
          projectController.projectname.text=element.projectName.toString();
          subcontractorController.Subcontractorname.text=element.subContName.toString();

          siteController.selectedsiteId.value=element.siteId;
          projectController.selectedProjectId.value=element.projectId;
          subcontractorController.selectedSubcontId.value=element.subContId;

          nmrWklyController.NmritemList.value= element.nmrBillDet;
          nmrWklyController.autoYearWiseNoController.text=element.workNo!;
          nmrWklyController.NmrentryDateController.text =element.workDate!;
          nmrWklyController.FromdateController.text=element.fromDate!;
          nmrWklyController.TodateController.text=element.toDate!;
          nmrWklyController.RemarksController.text=element.remarks!;
        });
      }
      else if(nmrWklyController.submitCheck==1){
        nmrWklyController.NmritemList.value;
      }
      else{
        nmrWklyController.NmritemList.value.clear();
        projectController.projectname.text="--Select--";
        projectController.selectedProjectId.value=0;
        siteController.Sitename.text=RequestConstant.SELECT;
        siteController.selectedsiteId.value=0;
        subcontractorController.Subcontractorname.text="--Select--";
        subcontractorController.selectedSubcontId.value=0;
        nmrWklyController.RemarksController.clear();
        nmrWklyController.NmrentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
        nmrWklyController.FromdateController.text=BaseUtitiles.initiateCurrentDateFormat();
        nmrWklyController.TodateController.text=BaseUtitiles.initiateCurrentDateFormat();
        nmrWklyController.autoYearWiseNoController.text=autoYearWiseNoController.NMR_autoYrsWise.value;
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 100/100;
    final double height = MediaQuery.of(context).size.height * 50/100;
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: BaseUtitiles.getheightofPercentage(context, 2)),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("NMR Wkeely Bill - Generation",
                            style: TextStyle(
                                fontSize: RequestConstant.Heading_Font_SIZE,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Back", style: TextStyle(color: Colors.grey, fontSize: 18)))
                        ],
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: nmrWklyController.autoYearWiseNoController,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Request No",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                        RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: ConstIcons.requestNo),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: const EdgeInsets.only(top: 5, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 10, bottom: 5),
                                child: TextFormField(
                                  readOnly: false,
                                  controller: nmrWklyController.NmrentryDateController,
                                  cursorColor: Colors.black,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "Date",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                        child: ConstIcons.date),
                                  ),
                                  onTap: () async {
                                    if(nmrWklyController.editCheck==1){}
                                    else{
                                      var entryDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                          builder: (context, child) {
                                            return Theme(data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context).primaryColor, // header background color
                                                onPrimary: Colors.white, // header text color
                                                onSurface: Colors.black, // body text color
                                              ),
                                              textButtonTheme: TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.black, // button text color
                                                ),
                                              ),
                                            ),
                                              child: child!,
                                            );
                                          });
                                      nmrWklyController.NmrentryDateController.text =BaseUtitiles.selectDateFormat(entryDate!);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container (
                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                            readOnly: true,
                            controller: projectController.projectname,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Project Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.projectName),
                            ),
                            onTap: () {
                              if(nmrWklyController.editCheck==1 || nmrWklyController.NmritemList.value.length>0){
                              }
                              else{
                                setState(() {
                                  bottomsheetControllers.ProjectName(context, projectController.getdropDownvalue.value);
                                });
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '\u26A0 Enter user name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                            readOnly: true,
                            controller: siteController.Sitename,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Site Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  child: ConstIcons.siteName),
                            ),
                            onTap: () async {
                              if(nmrWklyController.editCheck==1|| nmrWklyController.NmritemList.value.length>0){

                              }
                              else{
                                setState(() {
                                  bottomsheetControllers.SiteName(context, siteController.getSiteDropdownvalue.value);
                                });
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '\u26A0 Enter user name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
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
                            readOnly: true,
                            controller: subcontractorController.Subcontractorname,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "SubContractor Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.subcontractorName),
                            ),
                            onTap: () {
                              if(nmrWklyController.editCheck==1 || nmrWklyController.NmritemList.value.length>0||projectController.selectedProjectId.value==0||siteController.selectedsiteId.value==0){

                              }
                              else{
                                bottomsheetControllers.SubcontractorName(context, subcontractorController.getdropDownvalue.value);
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '\u26A0 Enter user name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      width: BaseUtitiles.getWidthtofPercentage(context, 55),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).primaryColor,
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 35,
                              color: Colors.grey
                          ),
                        ],
                      ),
                      child: const Text("Sub Contractor Work Done Details",style: TextStyle(color: Colors.white),),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: BaseUtitiles.getWidthtofPercentage(context, 45),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: nmrWklyController.FromdateController,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "From Date",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.date,
                                    ),
                                  ),
                                  onTap: () async {
                                    if(nmrWklyController.editCheck==1){

                                    }
                                    else if(nmrWklyController.NmritemList.value.isNotEmpty){

                                    }
                                    else{
                                      var Frdate = await showDatePicker(
                                          fieldHintText: "From",
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                          builder: (context, child) {
                                            return Theme(data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: Theme.of(context).primaryColor, // header background color
                                                onPrimary: Colors.white, // header text color
                                                onSurface: Colors.black, // body text color
                                              ),
                                              textButtonTheme: TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  primary: Colors.black, // button text color
                                                ),
                                              ),
                                            ),
                                              child: child!,
                                            );
                                          });
                                      nmrWklyController.FromdateController.text = BaseUtitiles.selectDateFormat(Frdate!);
                                      nmrWklyController.TodateController.text= BaseUtitiles.NMR_After_OneWeekDate(Frdate);
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
                          Container(
                            width: BaseUtitiles.getWidthtofPercentage(context, 45),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: TextFormField(
                                  readOnly: true,
                                  controller: nmrWklyController.TodateController,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    labelText: "To Date",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: RequestConstant.Lable_Font_SIZE),
                                    prefixIconConstraints:
                                    BoxConstraints(minWidth: 0, minHeight: 0),
                                    prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: Icon(Icons.calendar_month,
                                            color: Theme.of(context).primaryColor)),
                                  ),
                                  onTap: () async {

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
                      margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                          child: TextFormField(
                            controller: nmrWklyController.RemarksController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "Remarks",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                              BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.remarks),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: BaseUtitiles.getheightofPercentage(context, 1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Setmybackground,
                            ),
                            onPressed: () {
                           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Subcont_NMR_Deduction_Site() ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.add, color: Theme.of(context).primaryColor),
                                const SizedBox(width: 5),
                                Text("Deduction", style: TextStyle(color: Theme.of(context).primaryColor)),
                              ],)),
                      ],
                    ),
                    SizedBox(height: height),

                    // Container(
                    //   padding: EdgeInsets.only(left: 20, bottom: 8),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 1,
                    //         child: Container(
                    //           height: BaseUtitiles.getheightofPercentage(context, 4),
                    //           child: TextField(
                    //             controller: nmrWklyController.autoYearWiseNoController,
                    //             readOnly: true,
                    //             textAlign: TextAlign.center,
                    //             decoration: InputDecoration(
                    //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(color:Theme.of(context).primaryColor, width: 1.0),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //               ),
                    //               border: OutlineInputBorder(),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Expanded(
                    //         flex: 1,
                    //         child: Container(
                    //           height: BaseUtitiles.getheightofPercentage(context, 4),
                    //           margin: EdgeInsets.only(left: 10, right: 20),
                    //           decoration: BoxDecoration(),
                    //           child: TextField(
                    //             readOnly: true,
                    //             controller: nmrWklyController.NmrentryDateController,
                    //             decoration: InputDecoration(
                    //               contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //               ),
                    //               border: OutlineInputBorder(),
                    //               prefixIcon: Icon(Icons.date_range_sharp,
                    //                   color: Theme.of(context).primaryColor),
                    //             ),
                    //             onTap: () async {
                    //               if(nmrWklyController.editCheck==1){
                    //
                    //               }
                    //               else{
                    //                 var Entrydate = await showDatePicker(
                    //                     context: context,
                    //                     initialDate: DateTime.now(),
                    //                     firstDate: DateTime(1900),
                    //                     lastDate: DateTime(2100),
                    //                     builder: (context, child) {
                    //                       return Theme(data: Theme.of(context).copyWith(
                    //                         colorScheme: ColorScheme.light(
                    //                           primary: Theme.of(context).primaryColor, // header background color
                    //                           onPrimary: Colors.white, // header text color
                    //                           onSurface: Colors.black, // body text color
                    //                         ),
                    //                         textButtonTheme: TextButtonThemeData(
                    //                           style: TextButton.styleFrom(
                    //                             primary: Colors.black, // button text color
                    //                           ),
                    //                         ),
                    //                       ),
                    //                         child: child!,
                    //                       );
                    //                     });
                    //                 nmrWklyController.NmrentryDateController.text =BaseUtitiles.selectDateFormat(Entrydate!);
                    //               }
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 10,bottom: 10),
                    //   height: BaseUtitiles.getheightofPercentage(context, 5),
                    //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    //   child: TextField(
                    //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                    //     readOnly: true,
                    //     controller: projectController.projectname,
                    //     decoration: new InputDecoration(
                    //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    //       labelText: RequestConstant.PROJECT_NAME,
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //       ),
                    //     ),
                    //     onTap: () {
                    //       if(nmrWklyController.editCheck==1|| nmrWklyController.NmritemList.value.length>0){
                    //       }
                    //       else{
                    //         projectController.getProjectList(context,0);
                    //       }
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(bottom: 10),
                    //   height: BaseUtitiles.getheightofPercentage(context, 5),
                    //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    //   child: TextField(
                    //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                    //     readOnly: true,
                    //     controller: siteController.Sitename,
                    //     decoration: new InputDecoration(
                    //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    //       labelText:RequestConstant.SITE_NAME,
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //       ),
                    //     ),
                    //     onTap: () {
                    //       if(nmrWklyController.editCheck==1|| nmrWklyController.NmritemList.value.length>0){
                    //
                    //       }
                    //       else{
                    //         siteController.subcontEntry_siteDropdowntList(context,0);
                    //       }
                    //
                    //     },
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(bottom: 10),
                    //   height: BaseUtitiles.getheightofPercentage(context, 5),
                    //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    //   child: TextField(
                    //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
                    //     readOnly: true,
                    //     controller: subcontractorController.Subcontractorname,
                    //     decoration: new InputDecoration(
                    //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    //       labelText: RequestConstant.SUBCONTRACTOR_NAME,
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //       ),
                    //
                    //     ),
                    //
                    //     onTap: () async{
                    //       if(nmrWklyController.editCheck==1 || nmrWklyController.NmritemList.value.length>0||projectController.selectedProjectId.value==0||siteController.selectedsiteId.value==0){
                    //
                    //       }
                    //       else{
                    //         await subcontractorController.getSubcontList(context,projectController.selectedProjectId.value);
                    //       }
                    //     },
                    //   ),
                    //
                    // ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   margin: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
                    //   height: BaseUtitiles.getheightofPercentage(context, 4),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(50),
                    //     color: Theme.of(context).primaryColor,
                    //     boxShadow: [
                    //       BoxShadow(
                    //           offset: Offset(0, 10),
                    //           blurRadius: 35,
                    //           color: Colors.grey
                    //       ),
                    //     ],
                    //   ),
                    //   child: Text("Sub Contractor Work Done Details",style: TextStyle(color: Colors.white),),
                    // ),
                    // Container(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: <Widget>[
                    //       Container(
                    //         height: BaseUtitiles.getheightofPercentage(context, 4),
                    //         width: BaseUtitiles.getWidthtofPercentage(context, 40),
                    //         margin: EdgeInsets.only(left: 5, right: 5),
                    //         decoration: BoxDecoration(),
                    //         child: TextField(
                    //           readOnly: true,
                    //           controller: nmrWklyController.FromdateController,
                    //           decoration: InputDecoration(
                    //             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    //             focusedBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //             ),
                    //             enabledBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //             ),
                    //             border: OutlineInputBorder(),
                    //             prefixIcon: Icon(Icons.date_range_sharp,
                    //                 color: Theme.of(context).primaryColor),
                    //           ),
                    //           onTap: () async {
                    //             if(nmrWklyController.editCheck==1){
                    //
                    //             }
                    //             else if(nmrWklyController.NmritemList.value.isNotEmpty){
                    //
                    //             }
                    //             else{
                    //               var Frdate = await showDatePicker(
                    //                   fieldHintText: "From",
                    //                   context: context,
                    //                   initialDate: DateTime.now(),
                    //                   firstDate: DateTime(1900),
                    //                   lastDate: DateTime(2100),
                    //                   builder: (context, child) {
                    //                     return Theme(data: Theme.of(context).copyWith(
                    //                       colorScheme: ColorScheme.light(
                    //                         primary: Theme.of(context).primaryColor, // header background color
                    //                         onPrimary: Colors.white, // header text color
                    //                         onSurface: Colors.black, // body text color
                    //                       ),
                    //                       textButtonTheme: TextButtonThemeData(
                    //                         style: TextButton.styleFrom(
                    //                           primary: Colors.black, // button text color
                    //                         ),
                    //                       ),
                    //                     ),
                    //                       child: child!,
                    //                     );
                    //                   });
                    //               nmrWklyController.FromdateController.text = BaseUtitiles.selectDateFormat(Frdate!);
                    //               nmrWklyController.TodateController.text= BaseUtitiles.NMR_After_OneWeekDate(Frdate);
                    //             }
                    //           },
                    //         ),
                    //       ),
                    //
                    //       Container(
                    //         height: BaseUtitiles.getheightofPercentage(context, 4),
                    //         width: BaseUtitiles.getWidthtofPercentage(context, 40),
                    //         margin: EdgeInsets.only(left: 5, right: 5),
                    //         decoration: BoxDecoration(),
                    //         child: TextField(
                    //           readOnly: true,
                    //           controller: nmrWklyController.TodateController,
                    //           decoration: InputDecoration(
                    //             contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    //             focusedBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //             ),
                    //             enabledBorder: OutlineInputBorder(
                    //               borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //             ),
                    //             border: OutlineInputBorder(),
                    //             prefixIcon: Icon(Icons.date_range_sharp,
                    //                 color: Theme.of(context).primaryColor),
                    //           ),
                    //           onTap: () async {
                    //
                    //             // if(nmrWklyController.editCheck==1){
                    //             //
                    //             // }
                    //             // else{
                    //             //   var Todate = await showDatePicker(
                    //             //       context: context,
                    //             //       initialDate: DateTime.now(),
                    //             //       firstDate: DateTime(1900),
                    //             //       lastDate: DateTime(2100));
                    //             //   nmrWklyController.FromdateController.text =BaseUtitiles.selectDateFormat(Todate!);
                    //             // }
                    //           },
                    //
                    //         ),
                    //       ),
                    //
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 10,bottom: 10),
                    //   height: BaseUtitiles.getheightofPercentage(context, 5),
                    //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
                    //   child: TextField(
                    //     controller: nmrWklyController.RemarksController,
                    //     textAlign: TextAlign.center,
                    //     decoration: InputDecoration(
                    //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                    //       labelText: RequestConstant.REMARKS,
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1.0),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   height: BaseUtitiles.getheightofPercentage(context, 4),
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       primary: Theme.of(context).primaryColor,
                    //       //background color of button
                    //       side: BorderSide(width: 3, color: Colors.black),
                    //       //border width and color
                    //       elevation: 3,
                    //       //elevation of button
                    //       shape: RoundedRectangleBorder(
                    //         //to set border radius to button
                    //           borderRadius: BorderRadius.circular(30)),),
                    //     child: Text(RequestConstant.SUBMIT),
                    //     onPressed: () async {
                    //       if(nmrWklyController.editCheck==1){
                    //       }
                    //       else{
                    //         if(projectController.selectedProjectId.value!=0 && siteController.selectedsiteId.value!=0 && subcontractorController.selectedSubcontId.value!=0){
                    //           await  nmrWklyController.getNmrcheckstatusCount(projectController.selectedProjectId.value,subcontractorController.selectedSubcontId.value.toString(),siteController.selectedsiteId.value,nmrWklyController.FromdateController.text,nmrWklyController.TodateController.text);
                    //           await  nmrWklyController.getNmrcheckstatus(projectController.selectedProjectId.value,subcontractorController.selectedSubcontId.value.toString(),siteController.selectedsiteId.value,nmrWklyController.FromdateController.text,nmrWklyController.TodateController.text,context);
                    //         }
                    //       //  nmrWklyController.submit_getNmrItemList_Site();
                    //       }
                    //
                    //     },
                    //   ),
                    // ),
                    // Obx(()=>Visibility(
                    //     visible: nmrWklyController.NmritemList.value.isEmpty?false:true,
                    //     child: ListDetails())),

                  ],
                ),
              ),
              Obx(()=>Visibility(
                  visible: nmrWklyController.NmritemList.value.isEmpty?false:true,
                  child: SizedBox(
                    height: BaseUtitiles.getheightofPercentage(context, 100),
                    child: DraggableScrollableSheet(
                      minChildSize: 0.1,
                      maxChildSize: 0.9,
                      initialChildSize: 0.3,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Setmybackground,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(40.0),
                              topRight: const Radius.circular(40.0),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        // ListDetails(context, scrollController),
                                        ListDetails(),
                                      ],
                                    ),
                                  )),
                              IgnorePointer(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(40.0),
                                      topRight: const Radius.circular(40.0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 20, bottom: 20),
                                        height: 5,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),)),
            ],
          ),
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Visibility(
                //   visible: dailyEntriesController.screenCheck == "PendingScreen" ? false : true,
                //   child:
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: dailyEntriesController.checkColor == 0
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: dailyEntriesController.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                      ),
                    ),
                    onTap: () {
                      dailyEntriesController.checkColor = 1;
                      ResetAlert(context);
                    },
                  ),
                ),
                // ),
                Expanded(
                  child: InkWell(
                    child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: dailyEntriesController.checkColor == 0
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Obx(()=> Text(
                          nmrWklyController.saveButton.value,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                              color: dailyEntriesController.checkColor == 0
                                  ? Colors.white
                                  : Theme.of(context).primaryColor),
                        ),)
                    ),
                    onTap: () {
                      nmrWklyController.checkColor = 0;
                      SubmitAlert(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Are you sure to Reset?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    //color of divider
                    width: 5,
                    //width space of divider
                    thickness: 2,
                    //thickness of divier line
                    indent: 15,
                    //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          nmrWklyController.NmritemList.value.clear();
                          projectController.projectname.text="--Select--";
                          projectController.selectedProjectId.value=0;
                          siteController.Sitename.text=RequestConstant.SELECT;
                          siteController.selectedsiteId.value=0;
                          subcontractorController.Subcontractorname.text="--Select--";
                          subcontractorController.selectedSubcontId.value=0;
                          nmrWklyController.RemarksController.clear();
                          nmrWklyController.NmrentryDateController.text = BaseUtitiles.initiateCurrentDateFormat();
                          nmrWklyController.FromdateController.text=BaseUtitiles.initiateCurrentDateFormat();
                          nmrWklyController.TodateController.text=BaseUtitiles.initiateCurrentDateFormat();
                          nmrWklyController.autoYearWiseNoController.text=autoYearWiseNoController.NMR_autoYrsWise.value;
                        },
                        child: Text("Reset",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future SubmitAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text(nmrWklyController.editCheck == 1
            ? 'Are you sure to Re-Submit?'
            : 'Are you sure to Submit?'),
        actions: [
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    //color of divider
                    width: 5,
                    //width space of divider
                    thickness: 2,
                    //thickness of divier line
                    indent: 15,
                    //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () async {
                          if (nmrWklyController.buttonControl == 0) {
                            if (nmrWklyController.editCheck == 1) {
                            } else {
                              if (projectController.selectedProjectId.value !=
                                      0 &&
                                  siteController.selectedsiteId.value != 0 &&
                                  subcontractorController
                                          .selectedSubcontId.value !=
                                      0) {
                                await nmrWklyController.getNmrcheckstatusCount(
                                    projectController.selectedProjectId.value,
                                    subcontractorController
                                        .selectedSubcontId.value
                                        .toString(),
                                    siteController.selectedsiteId.value,
                                    nmrWklyController.FromdateController.text,
                                    nmrWklyController.TodateController.text);
                                await nmrWklyController.getNmrcheckstatus(
                                    projectController.selectedProjectId.value,
                                    subcontractorController
                                        .selectedSubcontId.value
                                        .toString(),
                                    siteController.selectedsiteId.value,
                                    nmrWklyController.FromdateController.text,
                                    nmrWklyController.TodateController.text,
                                    context);
                              }
                            }
                          } else {
                            nmrWklyController.buttonControl = 1;
                            BaseUtitiles.showToast(
                                "Already Submited Please wait...");
                          }
                        },
                        child: Text(RequestConstant.SUBMIT,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  // Widget ListDetails(BuildContext context, ScrollController scrollController) {
  //   return
  //     Column(
  //       children: <Widget>[
  //         SizedBox(height: MediaQuery.of(context).size.height * 5/100),
  //         Container(
  //             height: MediaQuery.of(context).size.height * 75/100,
  //             child: Obx(()=> ListView.builder(
  //               shrinkWrap: true,
  //               padding: EdgeInsets.zero,
  //               physics: ScrollPhysics(),
  //               itemCount: mrn_request_controller.Material_itemview_GetDbList.value.length,
  //               itemBuilder: (BuildContext context, int index) {
  //                 mrn_request_controller.Material_itemlist_textControllersInitiate();
  //                 return Card(
  //                   color: Colors.white,
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: <Widget>[
  //                       Container(
  //                         margin: EdgeInsets.only(left: 10, top: 10),
  //                         child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: <Widget>[
  //                             Text(
  //                               mrn_request_controller.Material_itemview_GetDbList.value[index].material.toString() +
  //                                   " (" + mrn_request_controller.Material_itemview_GetDbList.value[index].scale.toString() + ")",
  //                               //textAlign: TextAlign.left,
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                   color: Theme.of(context).primaryColor),
  //                             ),
  //                             Container(
  //                               height: BaseUtitiles.getheightofPercentage(context, 2),
  //                               width: BaseUtitiles.getWidthtofPercentage(context, 10),
  //                               child: InkWell(
  //                                   onTap: () {
  //                                     showDialog(
  //                                       context: context,
  //                                       builder: (context) => AlertDialog(
  //                                         title: Text(
  //                                           RequestConstant.DO_YOU_WANT_DELETE,
  //                                           style: TextStyle(color: Colors.black),
  //                                         ),
  //                                         actions: <Widget>[
  //                                           Container(
  //                                             margin: EdgeInsets.only(
  //                                                 left: 20, right: 20),
  //                                             child: IntrinsicHeight(
  //                                               child: Row(
  //                                                 mainAxisAlignment:
  //                                                 MainAxisAlignment
  //                                                     .spaceBetween,
  //                                                 children: [
  //                                                   Expanded(
  //                                                     child: TextButton(
  //                                                         onPressed: () {
  //                                                           Navigator.pop(
  //                                                               context);
  //                                                         },
  //                                                         child: Text("Cancel",
  //                                                             style: TextStyle(
  //                                                                 color:
  //                                                                 Colors.grey,
  //                                                                 fontWeight:
  //                                                                 FontWeight
  //                                                                     .bold,
  //                                                                 fontSize:
  //                                                                 RequestConstant
  //                                                                     .Lable_Font_SIZE))),
  //                                                   ),
  //                                                   VerticalDivider(
  //                                                     color: Colors.grey.shade400,
  //                                                     width: 5,
  //                                                     thickness: 2,
  //                                                     indent: 15,
  //                                                     endIndent: 15,
  //                                                   ),
  //                                                   Expanded(
  //                                                     child: TextButton(
  //                                                         onPressed: () {
  //                                                           mrn_request_controller
  //                                                               .deleteParticularList(
  //                                                               mrn_request_controller
  //                                                                   .Material_itemview_GetDbList[
  //                                                               index]);
  //                                                           mrn_request_controller
  //                                                               .Material_itemview_GetDbList
  //                                                               .remove(mrn_request_controller
  //                                                               .Material_itemview_GetDbList[
  //                                                           index]);
  //                                                           mrn_request_controller
  //                                                               .getMaterialTablesDatas();
  //                                                           Navigator.pop(
  //                                                               context);
  //                                                         },
  //                                                         child: Text("Delete",
  //                                                             style: TextStyle(
  //                                                                 color: Colors.red,
  //                                                                 fontWeight: FontWeight.bold,
  //                                                                 fontSize: RequestConstant.Lable_Font_SIZE))),
  //                                                   )
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     );
  //                                   },
  //                                   child: Icon(Icons.remove_circle,
  //                                       color: Colors.red
  //                                     // color: Theme.of(context).primaryColor
  //                                   )
  //                                 // Image.asset('assets/cancle.png'),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       Container(
  //                         margin: EdgeInsets.only(top: 10),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 // Expanded(
  //                                 //   flex: 3,
  //                                 //   child: Container(
  //                                 //       margin: EdgeInsets.only(left: 15, bottom: 10),
  //                                 //       child: Text( "BalQty:  ",
  //                                 //           style: TextStyle(
  //                                 //               fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                 //               color: Theme.of(context).primaryColor))),
  //                                 // ),
  //                                 // Expanded(
  //                                 //   flex: 5,
  //                                 //   child: Container(
  //                                 //       margin: EdgeInsets.only(bottom: 10),
  //                                 //       child: Text( mrn_request_controller.Material_itemview_GetDbList.value[index].balqty.toString(),
  //                                 //           style: TextStyle(
  //                                 //               fontWeight: FontWeight.bold,
  //                                 //               fontSize: RequestConstant.ALERT_Font_SIZE,
  //                                 //               color: Colors.black))),
  //                                 // ),
  //
  //                                 Expanded(
  //                                   flex: 3,
  //                                   child: Container(
  //                                       margin:
  //                                       EdgeInsets.only(left: 10, bottom: 10),
  //                                       child: Text(
  //                                         "Quantity",
  //                                         style: TextStyle(
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize:
  //                                             RequestConstant.ALERT_Font_SIZE,
  //                                             color: Colors.black),
  //                                       )),
  //                                 ),
  //
  //                                 Expanded(
  //                                   flex: 5,
  //                                   child: Container(
  //                                     margin: EdgeInsets.only(
  //                                         top: 5, right: 10, bottom: 10),
  //                                     height: BaseUtitiles.getheightofPercentage(context, 3),
  //                                     width: BaseUtitiles.getWidthtofPercentage(context, 20),
  //                                     child: TextField(
  //                                       cursorColor: Theme.of(context).primaryColor,
  //                                       textAlign: TextAlign.center,
  //                                       controller: mrn_request_controller.Addwork_qtyControllers[index],
  //                                       keyboardType: TextInputType.number,
  //                                       decoration: InputDecoration(
  //                                         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
  //                                         focusedBorder: OutlineInputBorder(
  //                                             borderSide: BorderSide(color: Theme.of(context).primaryColor),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(5))),
  //                                         enabledBorder: OutlineInputBorder(
  //                                             borderSide:
  //                                             BorderSide(color: Colors.grey),
  //                                             borderRadius: BorderRadius.all(
  //                                                 Radius.circular(5))),
  //                                       ),
  //                                       style: TextStyle(color: Colors.black),
  //                                       onChanged: (value) {
  //                                         mrn_request_controller.MaterialItemlist_clickEdit();
  //                                       },
  //                                     ),
  //                                   ),
  //                                 ),
  //
  //                                 Expanded(
  //                                     flex: 5,
  //                                     child: Container())
  //                               ],
  //                             ),
  //                             Container(
  //                               margin:
  //                               EdgeInsets.only(top: 5, right: 10, left: 10),
  //                               height: BaseUtitiles.getheightofPercentage(
  //                                   context, 3),
  //                               child: TextFormField(
  //                                 cursorColor: Theme.of(context).primaryColor,
  //                                 textAlign: TextAlign.center,
  //                                 controller: mrn_request_controller.Addwork_descControllers[index],
  //                                 keyboardType: TextInputType.multiline,
  //                                 decoration: InputDecoration(
  //                                   labelText: 'Description',
  //                                   labelStyle: TextStyle(color: Colors.black),
  //                                   contentPadding:
  //                                   EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
  //                                   focusedBorder: OutlineInputBorder(
  //                                       borderSide: BorderSide(
  //                                           color:
  //                                           Theme.of(context).primaryColor),
  //                                       borderRadius:
  //                                       BorderRadius.all(Radius.circular(5))),
  //                                   enabledBorder: OutlineInputBorder(
  //                                       borderSide:
  //                                       BorderSide(color: Colors.grey),
  //                                       borderRadius:
  //                                       BorderRadius.all(Radius.circular(5))),
  //                                 ),
  //                                 style: TextStyle(color: Colors.black),
  //                                 onChanged: (value) {
  //                                   mrn_request_controller.MaterialItemlist_clickEdit();
  //                                 },
  //                               ),
  //                             ),
  //                             Container(
  //                               margin: EdgeInsets.only(
  //                                   top: 10, right: 10, left: 10, bottom: 5),
  //                               height: BaseUtitiles.getheightofPercentage(
  //                                   context, 3),
  //                               child: TextField(
  //                                 cursorColor: Theme.of(context).primaryColor,
  //                                 textAlign: TextAlign.center,
  //                                 controller: mrn_request_controller.Addwork_remarksControllers[index],
  //                                 keyboardType: TextInputType.multiline,
  //                                 decoration: InputDecoration(
  //                                   labelText: 'Remarks',
  //                                   labelStyle: TextStyle(color: Colors.black),
  //                                   contentPadding:
  //                                   EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
  //                                   focusedBorder: OutlineInputBorder(
  //                                       borderSide: BorderSide(
  //                                           color:
  //                                           Theme.of(context).primaryColor),
  //                                       borderRadius:
  //                                       BorderRadius.all(Radius.circular(5))),
  //                                   enabledBorder: OutlineInputBorder(
  //                                       borderSide:
  //                                       BorderSide(color: Colors.grey),
  //                                       borderRadius:
  //                                       BorderRadius.all(Radius.circular(5))),
  //                                 ),
  //                                 style: TextStyle(color: Colors.black),
  //                                 onChanged: (value) {
  //                                   mrn_request_controller.MaterialItemlist_clickEdit();
  //                                 },
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),)
  //         ),
  //       ],
  //     );
  // }








//------------Need for references----------


  Widget ListDetails(){
    return Container(
      margin: EdgeInsets.only(top: 10,left: 5,right: 5),
      child: Container(),
      // HorizontalDataTable(
      //   leftHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context, 40),
      //   rightHandSideColumnWidth: BaseUtitiles.getWidthtofPercentage(context,115),
      //   isFixedHeader: true,
      //   headerWidgets: _getTitleWidget(),
      //   leftSideItemBuilder: _generateFirstColumnRow,
      //   rightSideItemBuilder: _generateRightHandSideColumnRow,
      //   itemCount: nmrWklyController.NmritemList.value.length,
      //   rowSeparatorWidget: const Divider(
      //     color: Colors.black54,
      //     height: 1.0,
      //     thickness: 0.0,
      //   ),
      //   leftHandSideColBackgroundColor: Colors.white24,
      //   rightHandSideColBackgroundColor: Colors.white24,
      //   verticalScrollbarStyle: const ScrollbarStyle(
      //     thumbColor: Colors.yellow,
      //     isAlwaysShown: true,
      //     thickness: 4.0,
      //     radius: Radius.circular(5.0),
      //   ),
      //   horizontalScrollbarStyle: const ScrollbarStyle(
      //     thumbColor: Colors.white24,
      //     isAlwaysShown: true,
      //     thickness: 4.0,
      //     radius: Radius.circular(5.0),
      //   ),
      //   enablePullToRefresh: false,
      //   refreshIndicator: const WaterDropHeader(),
      //   refreshIndicatorHeight: 60,
      //   onRefresh: () async {
      //     //Do sth
      //     await Future.delayed(const Duration(milliseconds: 500));
      //     _hdtRefreshController.refreshCompleted();
      //   },
      //   enablePullToLoadNewData: false,
      //   loadIndicator: const ClassicFooter(),
      //   onLoad: () async {
      //     //Do sth
      //     await Future.delayed(const Duration(milliseconds: 500));
      //     _hdtRefreshController.loadComplete();
      //   },
      //   htdRefreshController: _hdtRefreshController,
      // ),
      height: BaseUtitiles.getheightofPercentage(context, 55),
      width: BaseUtitiles.getheightofPercentage(context, 100)
    );

  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Site Name', BaseUtitiles.getWidthtofPercentage(context, 40)),
      _getTitleItemWidget('Category Name', BaseUtitiles.getWidthtofPercentage(context,40)),
      _getTitleItemWidget('Nos', BaseUtitiles.getWidthtofPercentage(context,25)),
      _getTitleItemWidget('OT Amt', BaseUtitiles.getWidthtofPercentage(context, 25)),
      _getTitleItemWidget('Net Amt', BaseUtitiles.getWidthtofPercentage(context, 25)),
    ];
  }


  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.red,  // red as border color
        ),
      ),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColorLight)),
      width: width,
      height: BaseUtitiles.getheightofPercentage(context, 6),
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    if(nmrWklyController.editCheck==1) {
      return  Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,  // red as border color
          ),
        ),
        child: Text(nmrWklyController.NmritemList.value[index].siteName.toString()),
        height: BaseUtitiles.getheightofPercentage(context,9),
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      );
    }
    else{
      return  Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,  // red as border color
          ),
        ),
        child: Text(nmrWklyController.NmritemList.value[index].sitename.toString()),
        height: BaseUtitiles.getheightofPercentage(context,9),
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        alignment: Alignment.centerLeft,
      );
    }

  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    if(nmrWklyController.editCheck==1){
      return Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,  // red as border color
              ),
            ),
            child: Text(nmrWklyController.NmritemList.value[index].categoryName.toString()),
            width: BaseUtitiles.getWidthtofPercentage(context,40),
            height: BaseUtitiles.getheightofPercentage(context,9),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,  // red as border color
              ),
            ),
            child: Text(nmrWklyController.NmritemList.value[index].totnos.toString()),
            width: BaseUtitiles.getWidthtofPercentage(context,25),
            height: BaseUtitiles.getheightofPercentage(context,9),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,  // red as border color
              ),
            ),
            child: Text(nmrWklyController.NmritemList.value[index].totalOtamt.toString()),
            width:  BaseUtitiles.getWidthtofPercentage(context,25),
            height: BaseUtitiles.getheightofPercentage(context,9),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,  // red as border color
              ),
            ),
            child: Text(nmrWklyController.NmritemList.value[index].nmrAmt.toString()),
            width:  BaseUtitiles.getWidthtofPercentage(context,25),
            height: BaseUtitiles.getheightofPercentage(context,9),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ],
      );
    }

    else{
      return Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,  // red as border color
              ),
            ),
            child: Text(nmrWklyController.NmritemList.value[index].categoryName.toString()),
            width: BaseUtitiles.getWidthtofPercentage(context,40),
            height: BaseUtitiles.getheightofPercentage(context,9),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,  // red as border color
              ),
            ),
            child: Text(nmrWklyController.NmritemList.value[index].totnos.toString()),
            width: BaseUtitiles.getWidthtofPercentage(context,25),
            height: BaseUtitiles.getheightofPercentage(context,9),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,  // red as border color
              ),
            ),
            child: Text(nmrWklyController.NmritemList.value[index].totalOtamt.toString()),
            width:  BaseUtitiles.getWidthtofPercentage(context,25),
            height: BaseUtitiles.getheightofPercentage(context,9),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,  // red as border color
              ),
            ),
            child: Text(nmrWklyController.NmritemList.value[index].netAmt.toString()),
            width:  BaseUtitiles.getWidthtofPercentage(context,25),
            height: BaseUtitiles.getheightofPercentage(context,9),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
          ),
        ],
      );
    }

  }


}

import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/stocksite_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/bottomsheet_Controllers.dart';
import '../../controller/reports_controller.dart';

class PrjectWise extends StatefulWidget {
  const PrjectWise({Key? key}) : super(key: key);

  @override
  State<PrjectWise> createState() => _PrjectWiseState();
}

class _PrjectWiseState extends State<PrjectWise> {
  final StockSiteController stockSiteController=Get.put(StockSiteController());
  final ProjectController projectController=Get.put(ProjectController());
  final SiteController siteController =Get.put(SiteController());
  final BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());
  ReportsController reportsController = Get.put(ReportsController());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {


      await siteController.subcont_SiteEntry_SiteDropdowntList(context,0);
      await stockSiteController.getProjectWisesubmaterialDropdownList(context);

      await reportsController.getProjectReportList(context);
      reportsController.projectname.text = "--ALL--";
      reportsController.selectedProjectId.value = 0;
      reportsController.selectedsiteId.value = 0;
      reportsController.sitename.text = "--ALL--";

      stockSiteController.setSelectedSubMatListName(0);
      stockSiteController.matDropdowntId.value=0;
      siteController.siteDropdownName.clear();
      setState(() {
        stockSiteController.projectShowList.value.clear();
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 2/100,),

              Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                    child: TextFormField(
                      readOnly: true,
                      controller: reportsController.projectname,
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
                            child: ConstIcons.projectName

                        ),
                      ),
                      onTap: () {
                        // await projectController.getProjectList(context, 0);
                        setState(() {
                          bottomsheetControllers.projectNameReport(context, reportsController.getProjectdropDownvalue.value);
                          textclear();
                        });

                      },
                      validator: (value) {
                        if (value!.isEmpty || value == "--Select--") {
                          return '\u26A0 Please select project name.';
                        }
                        return null;
                      },

                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                    child: TextFormField(
                      readOnly: true,
                      controller: reportsController.sitename,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        labelText: "Site Name",
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: RequestConstant.Lable_Font_SIZE),
                        prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: ConstIcons.siteName

                        ),
                      ),
                      onTap: () {
                        setState(() {
                          bottomsheetControllers.siteNameReport(context, reportsController.getSiteDropdownvalue.value );
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '\u26A0 Please select site name.';
                        }
                        return null;
                      },

                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 3, left: 10, bottom: 5),
                    child: TextFormField(
                      readOnly: true,
                      controller: stockSiteController.Materialsubname,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        labelText: "Material Sub Item",
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: RequestConstant.Lable_Font_SIZE),
                        prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            child: ConstIcons.siteName),
                      ),
                      onTap: () {
                        setState(() {
                          bottomsheetControllers.MaterialSubItem(context, stockSiteController.getmaterialSubdropDownvalue.value);
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty || value == "--Select--") {
                          return '\u26A0 Please select site name';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),



      // -----------Need for reference------------

            //   Container(
            //     alignment: Alignment.center,
            //     margin:
            //     EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            //     height: BaseUtitiles.getheightofPercentage(context, 5),
            //     width: BaseUtitiles.getWidthtofPercentage(context, 90),
            //     child: TextField(
            //       style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
            //       readOnly: true,
            //       controller: projectController.projectname,
            //       decoration: new InputDecoration(
            //         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            //         labelText: "ProjectName",
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.black, width: 1.0),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.black, width: 1.0),
            //         ),
            //
            //       ),
            //
            //       onTap: () {
            //         projectController.getProjectList(context,0);
            //         textclear();
            //       },
            //     ),
            //
            //   ),
            //   Container(
            //     alignment: Alignment.center,
            //     margin:
            //     EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            //     height: BaseUtitiles.getheightofPercentage(context, 5),
            //     width: BaseUtitiles.getWidthtofPercentage(context, 90),
            //     child: TextField(
            //       style: TextStyle(fontSize:RequestConstant.Dropdown_Font_SIZE),
            //       readOnly: true,
            //       controller: siteController.Sitename,
            //       decoration: new InputDecoration(
            //         contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            //         labelText: "SiteName",
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.black, width: 1.0),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.black, width: 1.0),
            //         ),
            //
            //       ),
            //
            //       onTap: () {
            //         siteController.subcont_SiteEntry_SiteDropdowntList(context,0);
            //       },
            //     ),
            //
            //   ),
            //   Container(
            //   alignment: Alignment.center,
            //   margin:
            //   EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            //   height: BaseUtitiles.getheightofPercentage(context, 5),
            //   width: BaseUtitiles.getWidthtofPercentage(context, 90),
            //   child: TextField(
            //     style: TextStyle(fontSize: RequestConstant.Dropdown_Font_SIZE),
            //     readOnly: true,
            //     controller: stockSiteController.Materialsubname,
            //     decoration: new InputDecoration(
            //       contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
            //       labelText: "Material Sub Item",
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black, width: 1.0),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(color: Colors.black, width: 1.0),
            //       ),
            //     ),
            //
            //     onTap: () {
            //       stockSiteController.getProjectWisesubmaterialDropdownList(context);
            //     },
            //   ),
            //
            // ),


              Container(
                margin:
                EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: BaseUtitiles.getWidthtofPercentage(context, 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            side: BorderSide(width: 3, color: Colors.white),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                           if(reportsController.selectedProjectId.value==0&&reportsController.selectedsiteId.value==0){

                           }
                            else{
                              stockSiteController.getProjectShowList();
                            }

                          },
                          child: Text("Show"),
                        ),
                      ),

                      Container(
                        width: BaseUtitiles.getWidthtofPercentage(context, 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            side: BorderSide(width: 3, color: Colors.white),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            if(reportsController.selectedProjectId.value==0&&reportsController.selectedsiteId.value==0){

                            }
                            else{
                              stockSiteController.getProjectDetailisList(context,reportsController.projectname.text);
                            }
                          },
                          child: Text("Details"),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              ListDetails(),
            ],
          ),
        ),
      ),
    );
  }

  void textclear() {
    siteController.siteDropdownName.clear();
    siteController.setSelectedMRNListName(0);
  }

  Widget ListDetails(){
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      height:BaseUtitiles.getheightofPercentage(context,60),
      width: BaseUtitiles.getWidthtofPercentage(context,100),
      child: Obx(()=>ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: stockSiteController.projectShowList.value.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(1),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          width: BaseUtitiles.getWidthtofPercentage(context,75),
                          child: Text(stockSiteController.projectShowList.value[index].header.toString()+" ( "+stockSiteController.projectShowList.value[index].footer.toString()+" )",style: TextStyle(color: Theme.of(context).primaryColor),)),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: Text("Unit:",style: TextStyle(color: Colors.black),),
                              ),
                            Expanded(
                              flex: 9,
                              child: Text(
                                stockSiteController.projectShowList.value[index].unit.toString(),style: TextStyle(color: Colors.black)),
                              ),
                            Expanded(
                              flex: 8,
                              child: Text("Stock Qty:",style: TextStyle(color: Colors.black),),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                (stockSiteController.projectShowList.value[index].stockQty.toString()),style: TextStyle(color: Colors.black),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      ),
    );

  }
}


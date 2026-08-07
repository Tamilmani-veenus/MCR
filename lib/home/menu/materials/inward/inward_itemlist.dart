import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcr/utilities/image_view.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../controller/inward_pending_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/requestconstant.dart';
import '../../../punch_in_out/camera_screen.dart';

class Inward_Itemlist extends StatefulWidget {
  const Inward_Itemlist({Key? key}) : super(key: key);

  @override
  State<Inward_Itemlist> createState() => _Subcont_Nmr_EntryScreenState_Site();
}

class _Subcont_Nmr_EntryScreenState_Site extends State<Inward_Itemlist> {
  InwardPending_Controller inwardPendingcontroller = Get.put(InwardPending_Controller());
  ProjectController projectController = Get.put(ProjectController());
  SiteController siteController = Get.put(SiteController());

  Color imageBackgroundColor = const Color.fromARGB(128, 172, 181, 255);

  Future<void> getImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          inwardPendingcontroller.imageFiles.add(File(pickedFile.path));
          inwardPendingcontroller.count = inwardPendingcontroller.count! + 1;
          inwardPendingcontroller.pickedImageCount = inwardPendingcontroller.pickedImageCount + 1;
        });
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error picking image: $error");
      }
    }
  }

  @override
  void initState() {
    inwardPendingcontroller.buttonControl = 0;
    int i = 0;
    if (inwardPendingcontroller.editvalue == 1) {
      inwardPendingcontroller.checkImgList.value = true;
    } else {
      inwardPendingcontroller.checkImgList.value = false;
    }
    inwardPendingcontroller.count.value = 0;
    inwardPendingcontroller.pickedImageCount.value = 0;
    inwardPendingcontroller.imageFiles.value = [];

    if (inwardPendingcontroller.entryvalue == 0) {
      inwardPendingcontroller.entryvalue = 1;
      inwardPendingcontroller.save_checked = false;
      inwardPendingcontroller.ischecked = List<bool>.filled(inwardPendingcontroller.ItemGetTableListdata.value.length, false);
    }

    if (inwardPendingcontroller.editvalue == 1) {
      i = 0;
      inwardPendingcontroller.editListApiDatas.forEach((element) {
        element.inwardEditDet.forEach((value) {
          //inwardPendingcontroller.ischecked=List<bool>.filled(inwardPendingcontroller.ItemGetTableListdata.value.length,value.amdCheck==1?true:false);
          if (value.amdCheck == 1) {
            inwardPendingcontroller.ischecked![i] = true;
          } else {
            inwardPendingcontroller.ischecked![i] = false;
          }
          i++;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(top: false,
        child: Scaffold(
          backgroundColor: Setmybackground,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add Items",
                        style: TextStyle(
                            fontSize: RequestConstant.Heading_Font_SIZE,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Obx(()=>
                inwardPendingcontroller.checkImgList.value == true
                    ? Container(
                  margin: EdgeInsets.all(8.r),
                  height: 150.h,
                  child: inwardPendingcontroller.editvalue == 1
                      ? netWorkImageList()
                      : imageList(),
                  // child: netWorkImageList()
                )
                    : InkWell(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.r),
                    child: CircleAvatar(
                      backgroundColor: const Color(0XFFeff9fb),
                      radius: 70.r,
                      child: Image.asset(
                        "assets/images/camera.png",
                        height: 80.h,
                        width: 80.w,
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CameraCapturePage(
                            fromScreen:
                            "Inward",
                          )),
                    );
                  },
                )),
                listDetails(),
                SizedBox(height: 20.r)
              ],
            ),
          ),


          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 70.h,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                            width: 1.0,
                            // color: Colors.white
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        checkColor: Colors.white,
                        activeColor: Theme.of(context).primaryColor,
                        value: inwardPendingcontroller.save_checked,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              inwardPendingcontroller.save_checked = value!;
                            } else {
                              inwardPendingcontroller.save_checked = value!;
                            }
                          });
                        },
                      ),
                      // ),
                      const Text("Save & Amendment")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(left: 20, right: 20),
                                width: BaseUtitiles.getWidthtofPercentage(context, 25),
                                height: BaseUtitiles.getheightofPercentage(context, 4),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  color: inwardPendingcontroller.checkColor == 0
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  inwardPendingcontroller.saveButton.value,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                    color: inwardPendingcontroller.checkColor == 0
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                if (inwardPendingcontroller.projectId == 0) {
                                  BaseUtitiles.showToast("Please select Project Name");
                                } else if (inwardPendingcontroller.siteId == 0) {
                                  BaseUtitiles.showToast("Please select Site Name");
                                } else if (inwardPendingcontroller.InwardInvoiceNoText.text == "") {
                                  BaseUtitiles.showToast("Please select Invoice No");
                                } else if (inwardPendingcontroller.InwardVechileNoText.text == "") {
                                  BaseUtitiles.showToast("Please select Vehicle No");
                                } else {
                                  // if (inwardPendingcontroller.buttonControl == 0) {
                                  await inwardPendingcontroller.getItemlistTablesDatas();
                                  if (await BaseUtitiles.checkNetworkAndShowLoader(context)) {
                                    await inwardPendingcontroller
                                        .Save_EntryScreen(context,
                                        inwardPendingcontroller.inwardID);
                                  }
                                }}

                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listDetails() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: BaseUtitiles.getheightofPercentage(context, 78),
          child: Obx(
                () => ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const ScrollPhysics(),
              itemCount: inwardPendingcontroller.ItemGetTableListdata.length,
              itemBuilder: (BuildContext context, int index) {
                inwardPendingcontroller.itemlist_textControllersInitiate();
                return Container(
                  margin:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.only(left: 3, right: 3),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: BaseUtitiles.getWidthtofPercentage(
                                        context, 66),
                                    child: Text(
                                      "${inwardPendingcontroller.ItemGetTableListdata[index].materialName} (${inwardPendingcontroller.ItemGetTableListdata[index].unit})",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(2.0),
                                      ),
                                      side: MaterialStateBorderSide.resolveWith(
                                            (states) => BorderSide(
                                          width: 1.0,
                                          // color: Colors.white
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      checkColor: Colors.white,
                                      activeColor:
                                      Theme.of(context).primaryColor,
                                      value: inwardPendingcontroller
                                          .ischecked![index],
                                      onChanged: (val) {
                                        setState(() {
                                          if (inwardPendingcontroller
                                              .ItemGetTableListdata[index]
                                              .balQty >
                                              double.parse(inwardPendingcontroller
                                                  .Itemlist_Inward_QtyListController[
                                              index]
                                                  .value
                                                  .text
                                                  .toString())) {
                                            inwardPendingcontroller
                                                .ischecked![index] = val!;
                                            inwardPendingcontroller
                                                .updateItemlistTable();
                                          }
                                        });
                                      }),
                                  // ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 4, right: 4, bottom: 4),
                              child: Row(
                                children: <Widget>[
                                  const Expanded(
                                      flex: 5,
                                      child: Text(
                                        "PO Qty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                      flex: 5,
                                      child: Text(
                                        inwardPendingcontroller
                                            .ItemGetTableListdata[index].poQty
                                            .toString(),
                                      )),
                                  const Expanded(
                                      flex: 5,
                                      child: Text(
                                        "Bal Qty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                      flex: 5,
                                      child: Center(
                                          child: Text(
                                            inwardPendingcontroller
                                                .ItemGetTableListdata[index].balQty
                                                .toString(),
                                          ))),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 4, right: 4, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Expanded(
                                      flex: 5,
                                      child: Text(
                                        "Rate",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                      flex: 5,
                                      child: Text(
                                        inwardPendingcontroller
                                            .ItemGetTableListdata[index].rate
                                            .toString(),
                                      )),
                                  const Expanded(
                                      flex: 5,
                                      child: Text(
                                        "Inward Qty",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                      flex: 5,
                                      child: Container(
                                        margin:
                                        const EdgeInsets.only(right: 11),
                                        height:
                                        BaseUtitiles.getheightofPercentage(
                                            context, 4),
                                        child: TextField(
                                          cursorColor:
                                          Theme.of(context).primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: inwardPendingcontroller
                                              .Itemlist_Inward_QtyListController[
                                          index],
                                          // keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          onTap: (){
                                            if(inwardPendingcontroller.Itemlist_Inward_QtyListController[index].text=='0.0'){
                                              inwardPendingcontroller.Itemlist_Inward_QtyListController[index].text='';
                                            }
                                          },
                                          // style: TextStyle(color: Colors.white),
                                          onChanged: (value) {
                                            setState(() {
                                              inwardPendingcontroller
                                                  .editClick(value);
                                            });
                                          },
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 4, right: 4, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Expanded(
                                      flex: 5,
                                      child: Text(
                                        "Qty ++",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                      flex: 6,
                                      child: Container(
                                        margin:
                                        const EdgeInsets.only(right: 11),
                                        height:
                                        BaseUtitiles.getheightofPercentage(
                                            context, 4),
                                        child: TextField(
                                          readOnly: true,
                                          cursorColor:
                                          Theme.of(context).primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: inwardPendingcontroller
                                              .Itemlist_Qty_PlusListController[
                                          index],
                                          // keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                      )),
                                  const Expanded(
                                      flex: 5,
                                      child: Text(
                                        "Qty --",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Expanded(
                                      flex: 6,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 11, left: 8),
                                        height:
                                        BaseUtitiles.getheightofPercentage(
                                            context, 4),
                                        child: TextField(
                                          readOnly: true,
                                          cursorColor:
                                          Theme.of(context).primaryColor,
                                          textAlign: TextAlign.center,
                                          controller: inwardPendingcontroller
                                              .Itemlist_Qty_MinusListController[
                                          index],
                                          // keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 8.0, 0.0),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          onChanged: (value) {},
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget imageList() {
    return SizedBox(
      height: 200.h,
      width: ScreenUtil().screenWidth,
      child: Obx(()=>
          ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: inwardPendingcontroller.count.value + 1,
              itemBuilder: (context, index) {
                if (index < inwardPendingcontroller.count.value) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => ImageViewPage(imagePath: inwardPendingcontroller.imageFiles[index],netUrl: false,)));
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 8.r, right: 8.r, bottom: 16.r),
                          child: Material(
                            color: Colors.white,
                            elevation: 1.0,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              padding: EdgeInsets.all(8.r),
                              child: SizedBox(
                                height: 150.h,
                                width: 120.w,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    inwardPendingcontroller.imageFiles[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          height: 50.h,
                          width: 50.h,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if(inwardPendingcontroller.imageFiles!.length == 1){
                                  inwardPendingcontroller.checkImgList.value = false;
                                }
                                inwardPendingcontroller.imageFiles.remove(inwardPendingcontroller.imageFiles[index]);
                                inwardPendingcontroller.count = inwardPendingcontroller.count! - 1;
                              });
                            },
                            child: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (inwardPendingcontroller.count! == 0) {
                  return InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.r),
                      child: CircleAvatar(
                        backgroundColor: const Color(0XFFeff9fb),
                        radius: 70.r,
                        child: Image.asset(
                          "assets/images/camera.png",
                          height: 80.h,
                          width: 80.w,
                        ),
                      ),
                    ),
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CameraCapturePage(
                              fromScreen:
                              "Inward",
                            )),
                      );
                    },
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(left: 16.4, bottom: 24.r),
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CameraCapturePage(
                                  fromScreen:
                                  "InwardAddButton",
                                )));
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey.shade300,
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  );
                }
              }),
      ),
    );
  }

  // Widget netWorkImageList(){
  //   return  SizedBox(
  //     height: 200.h,
  //     width: ScreenUtil().screenWidth,
  //     child: Padding(
  //       padding: EdgeInsets.zero,
  //       child: ListView.builder(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: inwardPendingcontroller.netWorkImageCount + inwardPendingcontroller.pickedImageCount + 1,
  //           itemBuilder: (context, index) {
  //             if (index < inwardPendingcontroller.netWorkImageCount) {
  //               return GestureDetector(
  //                 onTap: () {},
  //                 child: Stack(
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 16.r),
  //                       child: Material(
  //                         color: Colors.white,
  //                         elevation: 1.0,
  //                         borderRadius: const BorderRadius.all(Radius.circular(20.0)),
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(25.r),
  //                           ),
  //                           padding: EdgeInsets.all(8.r),
  //                           child: SizedBox(
  //                             height: 150.h,
  //                             width: 120.w,
  //                             child: ClipRRect(
  //                               borderRadius: BorderRadius.circular(15),
  //                               child: Image.network(inwardPendingcontroller.gettingNetworkImageList![index].toString()),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       alignment: Alignment.topLeft,
  //                       height: 50.h,
  //                       width: 50.h,
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           setState(() {
  //                             inwardPendingcontroller.gettingNetworkImageList!.remove(inwardPendingcontroller.gettingNetworkImageList![index].toString());
  //                             inwardPendingcontroller.netWorkImageCount = inwardPendingcontroller.netWorkImageCount - 1;
  //                           });
  //                         },
  //                         child: const Icon(
  //                           Icons.cancel,
  //                           color: Colors.red,
  //                           size: 30,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }
  //             else if (index < inwardPendingcontroller.pickedImageCount) {
  //               return GestureDetector(
  //                 onTap: () {},
  //                 child: Stack(
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 16.r),
  //                       child: Material(
  //                         color: Colors.white,
  //                         elevation: 1.0,
  //                         borderRadius: const BorderRadius.all(Radius.circular(20.0)),
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(25.r),
  //                           ),
  //                           padding: EdgeInsets.all(8.r),
  //                           child: SizedBox(
  //                             height: 150.h,
  //                             width: 120.w,
  //                             child: ClipRRect(
  //                               borderRadius: BorderRadius.circular(15),
  //                               child: Image.file(inwardPendingcontroller.imageFiles[index],
  //                                 fit: BoxFit.fill,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       alignment: Alignment.topLeft,
  //                       height: 50.h,
  //                       width: 50.h,
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           setState(() {
  //                             inwardPendingcontroller.imageFiles.remove(inwardPendingcontroller.imageFiles[index]);
  //                             inwardPendingcontroller.count = inwardPendingcontroller.count! - 1;
  //                           });
  //                         },
  //                         child: const Icon(
  //                           Icons.cancel,
  //                           color: Colors.red,
  //                           size: 30,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             }
  //             else {
  //               return Padding(
  //                 padding: EdgeInsets.only(left: 16.4,bottom: 24.r),
  //                 child: GestureDetector(
  //                   onTap: () async {
  //                     await getImage(ImageSource.camera);
  //                   },
  //                   child: CircleAvatar(
  //                     radius: 25,
  //                     backgroundColor: Colors.grey.shade300,
  //                     child: const Icon(
  //                       Icons.add,
  //                       color: Colors.black,
  //                       size: 30,
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             }
  //           }),
  //     ),
  //   );
  //
  // }

  Widget netWorkImageList() {
    return SizedBox(
      height: 200.h,
      width: ScreenUtil().screenWidth,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Obx(() {
          final networkCount =
              inwardPendingcontroller.gettingNetworkImageList.length;
          final pickedCount =
              inwardPendingcontroller.imageFiles.length;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: networkCount + pickedCount + 1,
            itemBuilder: (context, index) {

              /// NETWORK IMAGE
              if (index < networkCount) {
                return buildNetworkImageItem(index);
              }

              /// PICKED IMAGE
              if (index < networkCount + pickedCount) {
                final pickedIndex = index - networkCount;
                return buildPickedImageItem(pickedIndex);
              }

              /// CAMERA / ADD BUTTON
              if (networkCount == 0 && pickedCount == 0) {
                return InkWell(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.r, left: 100.r),
                      child: CircleAvatar(
                        backgroundColor: const Color(0XFFeff9fb),
                        radius: 70.r,
                        child: Image.asset(
                          "assets/images/camera.png",
                          height: 80.h,
                          width: 80.w,
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CameraCapturePage(
                              fromScreen:
                              "Inward",
                            )));
                    // setState(() {
                    //   inwardPendingcontroller.checkImgList.value = true;
                    // });
                    // await getImage(ImageSource.camera);
                  },
                );
              }
              return buildAddImageButton();
            },
          );
        }),
      ),
    );
  }

  Widget buildNetworkImageItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ImageViewPage(imageUrl: "${inwardPendingcontroller.gettingNetworkImageList![index]}?time=${DateTime.now().millisecondsSinceEpoch}"
            .toString(),netUrl: true,)));
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 16.r),
            child: Material(
              color: Colors.white,
              elevation: 1.0,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                padding: EdgeInsets.all(8.r),
                child: SizedBox(
                  height: 150.h,
                  width: 120.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "${inwardPendingcontroller.gettingNetworkImageList![index]}?time=${DateTime.now().millisecondsSinceEpoch}"
                          .toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            height: 50.h,
            width: 50.h,
            child: GestureDetector(
              onTap: () async {
                final imageId =
                inwardPendingcontroller.imageId[index];

                await inwardPendingcontroller.deletingImage(imageId);

                inwardPendingcontroller.gettingNetworkImageList.removeAt(index);
                inwardPendingcontroller.imageId.removeAt(index);

                if (inwardPendingcontroller.gettingNetworkImageList.isEmpty &&
                    inwardPendingcontroller.imageFiles.isEmpty) {
                  inwardPendingcontroller.checkImgList.value = false;
                }
              },
              child: const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPickedImageItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) => ImageViewPage(imagePath: inwardPendingcontroller.imageFiles[index],netUrl: false,)));
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.r, right: 8.r, bottom: 16.r),
            child: Material(
              color: Colors.white,
              elevation: 1.0,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                ),
                padding: EdgeInsets.all(8.r),
                child: SizedBox(
                  height: 150.h,
                  width: 120.w,
                  child: Obx(()=>
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          inwardPendingcontroller.imageFiles[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                inwardPendingcontroller.imageFiles.removeAt(index);

                if (inwardPendingcontroller.imageFiles.isEmpty &&
                    inwardPendingcontroller.gettingNetworkImageList.isEmpty) {
                  inwardPendingcontroller.checkImgList.value = false;
                }
              },
              child: const Icon(
                Icons.cancel,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddImageButton() {
    return Padding(
      padding: EdgeInsets.only(left: 16.4, bottom: 24.r),
      child: GestureDetector(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CameraCapturePage(
                  fromScreen:
                  "InwardAddButton",
                )),
          );        },
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey.shade300,
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    );
  }
}

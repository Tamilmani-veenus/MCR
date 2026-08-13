import 'dart:io';

import '../provider/common_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubcontractorController extends GetxController {
  final Subcontractorname=new TextEditingController();
  RxList getdropDownvalue = [].obs;
  RxList SubcontDropdownName = [].obs;
  RxList mainlist=[].obs;
  RxInt selectedSubcontId = 0.obs;
  RxString selectedSubconttName = "".obs;
  RxInt labourId=0.obs;
  RxString labourName="".obs;
  RxList labourList=[].obs;
  RxList labourmainList=[].obs;
  RxList getInvoiceNoValue = [].obs;
  RxList getdpDnWrkOrderValue = [].obs;
  final InvoiceNo=new TextEditingController();
  final WorkOrderNo=new TextEditingController();

  List<File> imageFiles = [];
  int? count = 0;
  int pickedImageCount = 0;
  RxInt selectedWorkOrderId = 0.obs;
  RxString selectedWorkOdrName = "".obs;


  final LabournameText=new TextEditingController();

  Future getLabourList(BuildContext context) async {
    labourList.value = await CommonProvider.getLabour();
  }

  Future getWorkOrderNoList(int pid, int sid, int subid,type) async {
    getdpDnWrkOrderValue.value = await CommonProvider.getWorkOrderNoList(pid, sid,subid,type);
  }

  setSelectedLabourID(String value) {
    if (labourList.value.length>0) {
      labourList.forEach((element) {
        if (value == element.labourName) {
          labourId(element.labourId);
        }
      });
    }
    setSelectedLabourName(labourId.value);
  }

  setSelectedLabourName(int? id) {
    if (labourList.value != null) {
      labourList.value.forEach((element) {
        if (id == element.labourId) {
          labourName(element.labourName.toString());
        }
      });
    }
    LabournameText.text=labourName.value;
  }

  int checkScreen = 0;

  checkSubcontList(){
   return checkScreen = 0;
  }


  Future getSubcontList(BuildContext context,int pid,int sid,checkScreen) async {
    getdropDownvalue.value = await CommonProvider.getSubcontrator(pid,sid, checkScreen);
    getdropDownvalue.value.forEach((element) {
      return SubcontDropdownName.value.add(element.subContName);
    });
  }

  setSelectedSubcontID(String value) {
    if (getdropDownvalue.value.length>0) {
      getdropDownvalue.forEach((element) {
        if (value == element.subContName) {
          selectedSubcontId(element.subContId);
        }
      });
    }
    setSelectedsubcontListName(selectedSubcontId.value);
  }

  setSelectedsubcontListName(int? id) {
    if (getdropDownvalue.value != null) {
      getdropDownvalue.value.forEach((element) {
        if (id == element.subContId) {
          selectedSubconttName(element.subContName.toString());
        }
      });
    }
    Subcontractorname.text=selectedSubconttName.value;
  }

  Future getInvoiceNoList(int pid,  int subid) async {
    getInvoiceNoValue.value = await CommonProvider.getInvoiceNoList(pid,subid);
    getInvoiceNoValue.value.forEach((element){
      InvoiceNo.text=element.entryAutoNo.toString();
    });
  }


}

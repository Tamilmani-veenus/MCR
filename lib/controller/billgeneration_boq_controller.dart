import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db_services/bill_boq_itemlist_service.dart';
import '../provider/billgenerationBoq_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class BillGenerationBoqController extends GetxController{

  final EntrylistFrDate = TextEditingController();
  final EntrylistToDate = TextEditingController();

  LoginController loginController = Get.put(LoginController());

  var directBillGen_ItemlistService = BillGenBoq_ItemlistService();

  RxList main_entryList = [].obs;
  RxList bill_entryList = [].obs;

  RxList ItemGetTableListdata = [].obs;

  RxString saveButton=RequestConstant.SUBMIT.obs;

  Future BillGenBoq_EntryList() async {
    main_entryList.value.clear();
    bill_entryList.value.clear();
    await BillGenerationBoqProvider.getBillBoqEntry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        EntrylistFrDate.text,
        EntrylistToDate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        main_entryList.value = value;
        bill_entryList.value = main_entryList.value;
        return main_entryList.value;
      } else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

  billgen_itemlistTable_Delete() async {
    await directBillGen_ItemlistService.DirectBillGen_ItemlistTable_delete();
  }

  Future EntryList_DeleteApi(int WorkId,int subId,String WorkNo) async {
    await BillGenerationBoqProvider.entryList_deleteAPI(WorkId,subId,WorkNo,loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  Future DeleteAlert(BuildContext context, int index ) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Alert!'),
        content: Text('Do you want to Delete?'),
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
                    color: Colors.grey.shade400, //color of divider
                    width: 5, //width space of divider
                    thickness: 2, //thickness of divier line
                    indent: 15, //Spacing at the top of divider.
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          billgen_itemlistTable_Delete();
                          ItemGetTableListdata.value.clear();
                          EntryList_DeleteApi(bill_entryList[index].workId,bill_entryList[index].subContId,bill_entryList[index].workNo);
                          bill_entryList.removeAt(index);
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
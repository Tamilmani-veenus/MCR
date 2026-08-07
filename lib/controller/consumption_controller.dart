
import '../controller/projectcontroller.dart';
import '../controller/sitecontroller.dart';
import '../controller/subcontcontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../db_model/consumptionitemlist_model.dart';
import '../db_services/consumptionitemlist_service.dart';
import '../home/menu/materials/consumption/consumption_entryscreen.dart';
import '../home/menu/materials/consumption/consumption_list.dart';
import '../models/consumption_save_model.dart';
import '../provider/consumption_provider.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
import 'logincontroller.dart';

class Consumption_Controller extends GetxController{
  final ConsumEntrylistFrDate = TextEditingController();
  final ConsumEntrylistToDate = TextEditingController();
  final ConsumDate = TextEditingController();
  final autoYearWiseNoController = TextEditingController();
  final Consum_preparedbyController = TextEditingController();
  final Consum_RemarksController = TextEditingController();
  final expenseTypeController = TextEditingController();
  final UsageqtyController = TextEditingController();

  RxString saveButton=RequestConstant.SUBMIT.obs;
  String expenseType = "";

  int editCheck = 0;
  int submitCheck = 0;
  int itemCheck = 0;
  int checkColor = 0;
  int buttonControl = 0;


  LoginController loginController = Get.put(LoginController());
  ProjectController projectController=Get.put(ProjectController());
  SiteController siteController=Get.put(SiteController());
  SubcontractorController subcontractorController=Get.put(SubcontractorController());


  RxList<UsageDet> getusageDetList = <UsageDet>[].obs;

  List<TextEditingController> Itemlist_materialControllers = [];
  List<TextEditingController> Itemlist_scaleControllers = [];
  List<TextEditingController> Itemlist_stockqtyControllers = [];
  List<TextEditingController> Itemlist_UsageqtyControllers = [];

  List<TextEditingController> Addwork_materialControllers = [];
  List<TextEditingController> Addwork_scaleControllers = [];
  List<TextEditingController> Addwork_stockqtyControllers = [];
  List<TextEditingController> Addwork_UsageqtyControllers = [];

  late List<ConsumptionItemlist> consumItemListTableList = <ConsumptionItemlist>[];
  late List<ConsumptionItemlist> updateListDatas = <ConsumptionItemlist>[];
  late List<ConsumptionItemlist> deleteModelList = <ConsumptionItemlist>[];
  var conumptionItemListTableModel = ConsumptionItemlist();
  var consumptionItemlistService = ConsumptionItemlistService();

  RxList ConsumEtyList = [].obs;
  RxList mainEtyList = [].obs;
  RxList Stock_List = [].obs;
  RxList mainlist=[].obs;
  RxList Consum_itemview_GetDbList = [].obs;
  RxList Consum_EditListApiValue=[].obs;


  int UsageId=0;

//---Entry List Call---
  Future getConsum_EntryList() async {
    mainEtyList.value.clear();
    ConsumEtyList.value.clear();
    await Consumption_provider.getConsumption_Entry_List(
        loginController.user.value.userId,
        loginController.UserType(),
        ConsumEntrylistFrDate.text,
        ConsumEntrylistToDate.text)
        .then((value) async {
      if (value != null && value.length > 0) {
        mainEtyList.value = value;
        ConsumEtyList.value = mainEtyList.value;
        return mainEtyList.value;
      }
      else {
        BaseUtitiles.showToast(RequestConstant.NORECORD_FOUND);
      }
    });
  }

//---------StockMaterial List--------
  Future getStock_Material() async {
    Stock_List.value.clear();
    await Consumption_provider.getStockmaterial(
        projectController.selectedProjectId.value,
        siteController.selectedsiteId.value).then((value) async {
      if (value != null && value.length > 0) {
        Stock_List.value = value;
        return Stock_List.value;
      }
    });
  }

  Consumption_itemlist_textControllersInitiate() {
    Itemlist_materialControllers.add(new TextEditingController());
    Itemlist_scaleControllers.add(new TextEditingController());
    Itemlist_stockqtyControllers.add(new TextEditingController());
    Itemlist_UsageqtyControllers.add(new TextEditingController());
    Addwork_materialControllers.add(new TextEditingController());
    Addwork_scaleControllers.add(new TextEditingController());
    Addwork_stockqtyControllers.add(new TextEditingController());
    Addwork_UsageqtyControllers.add(new TextEditingController());

  }

  currQtyAndAmntZerovalueset(list) {
    int index = 0;
    list.forEach((element) {
      Consumption_itemlist_textControllersInitiate();
      Addwork_materialControllers[index].text=element.material!.toString();
      Addwork_scaleControllers[index].text=element.scale!.toString();
      Addwork_stockqtyControllers[index].text=element.stockQty!.toString();
      Addwork_UsageqtyControllers[index].text = "0.0";
      index++;
    });
  }

  popupChaneEdit(String value) {
    int i=0;
    mainlist.value.forEach((element) {
      Consumption_itemlist_textControllersInitiate();
      if(element.stockQty<double.parse(Addwork_UsageqtyControllers[i].text)){
        //BaseUtitiles.showToast("True");
        Addwork_UsageqtyControllers[i].text = "0.0";
      }
      i++;
    });
  }


//---ItemList DB Save ----
  consum_itemlist_Save_DB(BuildContext context) async {
    consumItemListTableList.clear();
    int i = 0;
    int j = 0;
    Stock_List.forEach((element) {
      Consumption_itemlist_textControllersInitiate();
      if(element.check==true){
        conumptionItemListTableModel =new ConsumptionItemlist();
        conumptionItemListTableModel.materialid = element.materialId!;
        conumptionItemListTableModel.material = element.material!;
        conumptionItemListTableModel.scale = element.scale!;
        conumptionItemListTableModel.Stockqty = element.stockQty!;
        conumptionItemListTableModel.Usageqty = double.parse("0");
        Consum_itemview_GetDbList.forEach((element) {
          if (element.materialid == conumptionItemListTableModel.materialid) {
            j = 1;
            BaseUtitiles.showToast("Entries already exist");
          }
        });
        if (j == 0) {
          consumItemListTableList.add(conumptionItemListTableModel);
        }
        else{
          j=0;
        }
      }
      i++;
    });
    var savedatas = await consumptionItemlistService.ConsumItemlist_table_Save(consumItemListTableList);
    return Navigator.pop(context, savedatas);

  }

  //Get Values

  Future getConumTablesDatas() async {
    // for (final c in Itemlist_UsageqtyControllers) {
    //   c.dispose();
    // }
    Consum_itemview_GetDbList.clear();
    var ConumItem = await consumptionItemlistService.ConumItemlist_table_readAll();
    ConumItem.forEach((user) {
      var consumptionItemlist =ConsumptionItemlist();
      consumptionItemlist.materialid = user['materialid'];
      consumptionItemlist.material = user['material'];
      consumptionItemlist.scale = user['scale'];
      consumptionItemlist.Stockqty = user['stockqty'];
      consumptionItemlist.Usageqty = user['usageqty'];
      Consum_itemview_GetDbList.add(consumptionItemlist);
    });
    setTextControllersValue();
  }

  double usageQty(){
    double value=0;
    List data=[];
    data.clear();
    Consum_itemview_GetDbList.forEach((element) {
      if(element.Usageqty==0){
        data.add(element);
      }
    });
    if(data.isEmpty){
      value=1;
    }else{
      value=0;
    }
    return value;
  }
  //Set Value
  setTextControllersValue() async {
    for (var index = 0; index < Consum_itemview_GetDbList.length; index++) {
      Consumption_itemlist_textControllersInitiate();
      Itemlist_materialControllers[index].text =
          Consum_itemview_GetDbList.value[index].material.toString();
      Itemlist_scaleControllers[index].text =
          Consum_itemview_GetDbList.value[index].scale.toString();
      Itemlist_stockqtyControllers[index].text =
          Consum_itemview_GetDbList.value[index].Stockqty.toString();
      Itemlist_UsageqtyControllers[index].text =
          Consum_itemview_GetDbList.value[index].Usageqty.toString();
    }
  }
  //Usageqty edit
  ConsumItemlist_clickEdit() {
    for (var index = 0; index < Consum_itemview_GetDbList.value.length; index++) {
      if (Itemlist_UsageqtyControllers[index].value.text == "0.0" ||Itemlist_UsageqtyControllers[index].value.text == "0.0") {

        // Itemlist_UsageqtyControllers[index].text=Consum_itemview_GetDbList.value[index].Usageqty.toString();

      } else {
        if(Consum_itemview_GetDbList.value[index].Stockqty<double.parse(Itemlist_UsageqtyControllers[index].text)){
          Itemlist_UsageqtyControllers[index].text="0.0";
          BaseUtitiles.showToast("Usage qty is higher than the Stock qty");
        }
        else{
          updateConsumTables();
        }
      }
    }
  }
  //Usage Update to db
  updateConsumTables() async {
    int i = 0;
    updateListDatas.clear();
    Consum_itemview_GetDbList.forEach((element) {
      conumptionItemListTableModel = new ConsumptionItemlist();
      conumptionItemListTableModel.materialid = element.materialid!;
      conumptionItemListTableModel.material = element.material!;
      conumptionItemListTableModel.scale = element.scale!;
      conumptionItemListTableModel.Stockqty = element.Stockqty!;
      conumptionItemListTableModel.Usageqty = double.parse(Itemlist_UsageqtyControllers[i].value.text);

      updateListDatas.add(conumptionItemListTableModel);
      i++;
    });
    await consumptionItemlistService.ConumItemlist_table_Update(updateListDatas);

  }

  //Particular delete
  Future deleteParticularList(ConsumptionItemlist data) async {
    deleteModelList.clear();
    conumptionItemListTableModel = new ConsumptionItemlist();

    conumptionItemListTableModel.materialid = data.materialid;

    deleteModelList.add(conumptionItemListTableModel);
    await consumptionItemlistService.consumdeleteById(deleteModelList);
  }

  delete_Consum_itemlist_Table() async {
    await consumptionItemlistService.ConsumItemlist_table_delete();
  }


  clearDatas(){
    UsageId=0;
    saveButton.value = RequestConstant.SUBMIT;
    projectController.projectname.text = "--Select--";
    projectController.selectedProjectId.value=0;
    subcontractorController.selectedSubcontId.value=0;
    subcontractorController.Subcontractorname.text = "--Select--";
    ConsumDate.text = BaseUtitiles.initiateCurrentDateFormat();
    Consum_preparedbyController.text = loginController.EmpName();
    siteController.selectedsiteId = 0.obs;
    siteController.selectedsitedropdownName = "--Select--".obs;
    expenseTypeController.text = "Usage";
    siteController.getSiteDropdownvalue.value.clear();
    siteController.Sitename.text = RequestConstant.SELECT;
    siteController.siteDropdownName.clear();
    expenseType = "EXP";
    Consum_RemarksController.text = "";
    editCheck=0;
    itemCheck=0;
    Consum_EditListApiValue.value.clear();
    delete_Consum_itemlist_Table();
    Consum_itemview_GetDbList.clear();
  }

//----- POST and PUT JSON Values----
  Future SaveButton_ItemlistScreen(BuildContext context, int id) async {
    buttonControl=1;
    int i = 0;
    await getConumTablesDatas();
      getusageDetList.value.clear();
      await Future.delayed(const Duration(seconds:0));
      String body = conumSaveRequestToJson(ConumSaveRequest(
        usageId: id != 0 ? id.toString() : "0",
        usageNo: autoYearWiseNoController.text,
        usageDate: ConsumDate.text,
        projectId: projectController.selectedProjectId.value.toString(),
        siteId: siteController.selectedsiteId.toString(),
        SubContId: subcontractorController.selectedSubcontId.value.toString(),
        usageType:expenseType.toString(),
        remarks: Consum_RemarksController.text,
        preparedby: loginController.EmpId(),
        userId: loginController.UserId(),
        deviceName: BaseUtitiles.deviceName,
        entryMode:saveButton.value=="Submit"?"ADD":saveButton.value=="Re-Submit"?"UPDATE":saveButton.value=="Verify"?"VERIFY":saveButton.value=="Approve"?"APPROVE":"",
        usageDet: getusageDetList.value.length == 0
            ? getConumDet()
            : getusageDetList.value,
      ));
      if(Itemlist_UsageqtyControllers[i].value.text == "0.0" || Itemlist_UsageqtyControllers[i].value.text == "0" || Itemlist_UsageqtyControllers[i].value.text == ""){
        BaseUtitiles.showToast("Please check usage qty is zero is not allowed to submit");
        Navigator.pop(context);
        Navigator.pop(context);
      }
    else{
        final list = await Consumption_provider.SaveConumScreenEntryAPI(body, id,context);
        if (list != null) {
          if (id != 0) {
            buttonControl = 0;
            BaseUtitiles.showToast(list);
            clearDatas();
            delete_Consum_itemlist_Table();
            Consum_itemview_GetDbList.clear();
            await getConsum_EntryList();
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            return;
          }
          else {
            if (list == RequestConstant.DUPLICATE_OCCURED) {
              buttonControl = 0;
              Navigator.pop(context);
              Navigator.pop(context);
              return BaseUtitiles.showToast(list);
            }
            else {
              buttonControl = 0;
              BaseUtitiles.showToast(list);
              clearDatas();
              itemCheck = 2;
              delete_Consum_itemlist_Table();
              Consum_itemview_GetDbList.clear();
              await getConsum_EntryList();
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              return;
            }
          }
        }
    }
  }

  List<UsageDet>? getConumDet() {

    Consum_itemview_GetDbList.value.forEach((element) {
      var list = new UsageDet(
        materialId: element.materialid.toString(),
        qty: element.Usageqty.toString(),
        rate:"0",
        amount: "0",
        detRemarks: "-",
      );
      getusageDetList.value.add(list);
    });
    return getusageDetList.value;
  }
  // ---------Edit Call API----------


  Future Consum_entrylist_editSaveDetTable() async {
    consumItemListTableList.clear();
    Consum_EditListApiValue.forEach((element) {
      element.usageEditDet.forEach((val) {
        conumptionItemListTableModel =new ConsumptionItemlist();
        conumptionItemListTableModel.materialid = val.materialId!;
        conumptionItemListTableModel.material = val.materialName!;
        conumptionItemListTableModel.scale = val.unit!;
        conumptionItemListTableModel.Stockqty = val.stockQty!;
        conumptionItemListTableModel.Usageqty = val.qty;
        consumItemListTableList.add(conumptionItemListTableModel);
      });
    });
    var savedatas = await consumptionItemlistService.ConsumItemlist_table_Save(consumItemListTableList);
    return  savedatas;
  }

  Future ConsumEntryList_EditApi(int expenseId, BuildContext context) async {

    await Consumption_provider.Consum_entryList_editAPI(expenseId).then((value) async {
      if (value != null && value.length > 0) {
        delete_Consum_itemlist_Table();
        editCheck = 1;
        Consum_EditListApiValue.value = value;
        Consum_entrylist_editSaveDetTable();
        getConumTablesDatas();
        return
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Consumption_Entry()),
          );

        //   Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => Material_Consumption(0)),
        // );
      }
    });
  }
// ----------Delete call API --------------
  Future Consum_EntryList_DeleteApi(int UsageId, String UsageNo) async {
    await Consumption_provider.Consum_entryList_deleteAPI(UsageId,UsageNo, loginController.UserId(), BaseUtitiles.deviceName)
        .then((value) async {
      if (value != null && value.length > 0) {
        return value;
      }
    });
  }

  //------Button Changes-----

  String ButtonChanges(int id,int aproval){
    if(id!=0){
      if(aproval!=0)
        return saveButton.value=RequestConstant.APPROVAL;
      else
        return saveButton.value=RequestConstant.RESUBMIT;
    }
    else
      return saveButton.value=RequestConstant.SUBMIT;
  }

  setCheck(int id,bool value){
    Stock_List.value.forEach((element) {
      if(element.materialId==id){
        element.check = value;
      }
    });
  }

  serachsetCheck(int id,bool value){
    mainlist.forEach((element) {
      if(element.materialId==id){
        element.check = value;
      }
    });
  }



}
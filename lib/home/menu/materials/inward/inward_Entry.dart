import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../controller/inward_pending_controller.dart';
import '../../../../controller/logincontroller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'inward_itemlist.dart';

class Inward_entry extends StatefulWidget {
  const Inward_entry({Key? key}) : super(key: key);

  @override
  State<Inward_entry> createState() => _InwardState();
}

class _InwardState extends State<Inward_entry> {

  InwardPending_Controller inward_controller = Get.put(InwardPending_Controller());
  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  CommanController commanController = Get.put(CommanController());

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var duration = const Duration(seconds:0);
    Future.delayed(duration,() async {
      await autoYearWiseNoController.InwardPending_AutoYearWise();
      await projectController.getProjectList(context, 0);
      inward_controller.buttonControl == 0;
      inward_controller.saveButton.value=RequestConstant.SUBMIT;
      inward_controller.InwardAutoyearText.text=autoYearWiseNoController.InwardPendingautoYrsWise.value.toString();

      inward_controller.ischecked = List<bool>.filled(inward_controller.ItemGetTableListdata.value.length, false);
      inward_controller.save_checked = false;
      int i=0;
      if(inward_controller.editvalue==1){
        inward_controller.saveButton.value = RequestConstant.RESUBMIT;
        await inward_controller.gettingImage();
        inward_controller.editListApiDatas.value.forEach((element) {
          inward_controller.ButtonChanges(inward_controller.editListApiDatas[i].inwardId);
          inward_controller.inwardID = inward_controller.editListApiDatas[i].inwardId;
          inward_controller.InwardAutoyearText.text = element.inwardNo.toString();
          inward_controller.InwardEntryDateText.text = element.inwardDate.toString();
          inward_controller.InwardSupplierNameText.text = element.supplier.toString();
          inward_controller.InwardProjectNameText.text = element.project.toString();
          inward_controller.InwardSiteNameText.text = element.siteName.toString();
          inward_controller.InwardInvoiceNoText.text = element.invNo.toString();
          inward_controller.InwardInvoiceDateText.text = element.invDate.toString();
          inward_controller.InwardDCNoText.text = element.dcNo.toString();
          inward_controller.InwardDCDateText.text = element.dcDate.toString();
          inward_controller.InwardManualNoText.text = "";
          inward_controller.InwardTypeText.text = element.type== "P" ? "Against PO" : "Against Request";
          inward_controller.InwardNoText.text = element.no.toString();
          inward_controller.InwardVechileNoText.text = element.vehicleNo.toString();
          inward_controller.InwardDriverNameText.text = element.driverName.toString();
          inward_controller.InwardFreightChargesText.text = element.frieght.toString();
          inward_controller.InwardLabourChargesText.text = "";
          inward_controller.InwardRoundoffText.text = element.roff.toString();
          inward_controller.InwardNetAmtText.text = element.netAmt.toString();
          inward_controller.projectId = element.projectId;
          inward_controller.siteId = element.siteId;
          inward_controller.supId = element.supplierId;
          inward_controller.InwardSupplierNameText.text = element.supplier.toString();
          inward_controller.InwardProjectNameText.text = element.project.toString();
          inward_controller.InwardSiteNameText.text = element.siteName.toString();
          i++;
        });
      }

      if(inward_controller.entryvalue == 0){
        inward_controller.InwardAutoyearText.text = autoYearWiseNoController.InwardPendingautoYrsWise.value.toString();
        inward_controller.saveButton.value = RequestConstant.SUBMIT;
        inward_controller.inwardID = 0;
        inward_controller.InwardSupplierNameText.text = "--Select--";
        inward_controller.InwardProjectNameText.text = "--Select--";
        inward_controller.InwardSiteNameText.text = "--Select--";
        inward_controller.projectId = 0;
        inward_controller.siteId = 0;
        inward_controller.supId = 0;
        inward_controller.InwardNoText.text ="";
        inward_controller.InwardFreightChargesText.text = "0";
        inward_controller.InwardLabourChargesText.text = "0";
        inward_controller.InwardRoundoffText.text = "0";
        inward_controller.InwardNetAmtText.text = "0";
        inward_controller.InwardInvoiceNoText.text = "";
        inward_controller.InwardDCNoText.text = "";
        inward_controller.InwardManualNoText.text = "";
        inward_controller.InwardVechileNoText.text = "";
        inward_controller.InwardDriverNameText.text = "";
        inward_controller.InwardRemarksText.text = "";
        inward_controller.Zerovalueset(inward_controller.ItemGetTableListdata);
        inward_controller.entryvalue = 1;
      }

      if(inward_controller.inwardAllDatasList.value!=null){
        int i=0;
        inward_controller.inwardAllDatasList.value.forEach((element) {
          inward_controller.InwardSupplierNameText.text = element.supplier.toString();
          inward_controller.InwardProjectNameText.text = element.project.toString();
          inward_controller.InwardSiteNameText.text = element.siteName.toString();
          inward_controller.InwardTypeText.text = element.type=="P"?"Against PO":"Against Request";
          inward_controller.InwardNoText.text = element.no.toString();
          inward_controller.siteId = element.siteId;
          inward_controller.projectId = element.projectId;
          inward_controller.supId = element.supplierid;
        });

        inward_controller.ItemGetTableListdata.forEach((element) {
          inward_controller.ischecked![i] = element.amdCheck == 1 ? true : false;
          i++;
        });

        // inward_controller.InwardAutoyearText.text = autoYearWiseNoController.InwardPendingautoYrsWise.value.toString();
        inward_controller.InwardEntryDateText.text = BaseUtitiles.initiateCurrentDateFormat();
        inward_controller.InwardInvoiceDateText.text = BaseUtitiles.initiateCurrentDateFormat();
        inward_controller.InwardDCDateText.text = BaseUtitiles.initiateCurrentDateFormat();
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  const SizedBox(height: 40),

                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Inward",
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

                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
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
                          controller: inward_controller.InwardAutoyearText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "GRN No",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              child: ConstIcons.requestNo,
                            ),
                          ),
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
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: inward_controller.InwardEntryDateText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Date",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.date),
                          ),
                          onTap: () async {
                            var Entrydate = await showDatePicker(
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
                            inward_controller.InwardEntryDateText.text =
                                BaseUtitiles.selectDateFormat(Entrydate!);
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
                          controller: inward_controller.InwardSupplierNameText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Supplier Name",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.supplierName),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
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
                          controller: inward_controller.InwardProjectNameText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Project Name *",
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
                          controller: inward_controller.InwardSiteNameText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Site Name *",
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
                          onChanged: (value){
                            //nmrWklyController.deduction_paymentCalculation();
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: inward_controller.InwardInvoiceNoText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Invoice No *",
                            labelStyle: TextStyle(
                                color: inward_controller.editvalue == 1 ? Colors.grey : inward_controller.InwardInvoiceNoText.text == "" ? Colors.red : Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.dcNo),
                          ),
                          onChanged: (value){
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter Invoice No';
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
                          controller: inward_controller.InwardInvoiceDateText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText:  "Invoice Date",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.date),
                          ),
                          onTap: () async {
                            var Entrydate = await showDatePicker(
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
                            inward_controller.InwardInvoiceDateText.text = BaseUtitiles.selectDateFormat(Entrydate!);
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
                          // keyboardType: TextInputType.number,
                          controller: inward_controller.InwardDCNoText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText:  "DC No",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.dcNo),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
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
                          controller: inward_controller.InwardDCDateText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Dc Date ",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.date),
                          ),
                          onTap: () async {
                            var Entrydate = await showDatePicker(
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
                            inward_controller.InwardDCDateText.text = BaseUtitiles.selectDateFormat(Entrydate!);
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
                          controller: inward_controller.InwardManualNoText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Manual Inward No",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.dcNo),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return '\u26A0 Enter user name';
                          //   }
                          //   return null;
                          // },
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
                          controller: inward_controller.InwardTypeText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Type",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.types),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
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
                          controller: inward_controller.InwardNoText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "No",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.requestNo),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: inward_controller.InwardVechileNoText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Vehicle No *",
                            labelStyle: TextStyle(
                                color: inward_controller.editvalue == 1 ? Colors.grey : inward_controller.InwardVechileNoText.text == "" ? Colors.red : Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.vehicleNo),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter vehicle no';
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: inward_controller.InwardDriverNameText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Driver Name *",
                            labelStyle: TextStyle(
                                color: inward_controller.editvalue == 1 ? Colors.grey : inward_controller.InwardDriverNameText.text == "" ? Colors.red : Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 8),
                                child: ConstIcons.driverName),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter driver name';
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
                          keyboardType: TextInputType.number,
                          controller: inward_controller.InwardNetAmtText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Net Amount",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: ConstIcons.rate),
                          ),
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
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
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),),
                      elevation: 3,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          controller: inward_controller.InwardRemarksText,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
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
                          onChanged: (value) {
                            //nmrWklyController.deduction_paymentCalculation();
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //           primary: Setmybackground,
                  //         ),
                  //         onPressed: () {
                  //           //   if(projectController.selectedProjectId.value==0){
                  //           //     BaseUtitiles.showToast("Please select Project Name");
                  //           //   }
                  //           //   else if(siteController.selectedsiteId.value==0){
                  //           //     BaseUtitiles.showToast("Please select Site Name");
                  //           //   }
                  //           //   else{
                  //           //     mrn_request_controller.getMaterialList(context);
                  //           //   }
                  //           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Inward_Itemlist()));
                  //         },
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           children: [
                  //             Icon(Icons.add, color: Theme.of(context).primaryColor,),
                  //             SizedBox(width: 5),
                  //             Text("Add Items", style: TextStyle(color: Theme.of(context).primaryColor),),
                  //           ],
                  //         )),
                  //   ],
                  // ),

                ],
              ),
            ),
          ),

          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Visibility(
                  visible: inward_controller.screenCheck == "PendingScreen" ? true : false,
                  child: Expanded(
                    child: InkWell(
                      child: Container(
                        margin: EdgeInsets.only(left: 20,right: 20),
                        height: BaseUtitiles.getheightofPercentage(context, 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color:  inward_controller.checkColor == 0 ? Colors.white : Theme.of(context).primaryColor ,
                        ),
                        alignment: Alignment.center,
                        child: Text("Reset",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                              color:  inward_controller.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white ),
                        ),
                      ),
                      onTap: (){
                        setState(() {
                          inward_controller.checkColor = 1;

                          inward_controller.InwardAutoyearText.text=autoYearWiseNoController.InwardPendingautoYrsWise.value.toString();
                          inward_controller.inwardID=0;
                          inward_controller.InwardSupplierNameText.text ="--Select--";
                          inward_controller.InwardProjectNameText.text ="--Select--";
                          inward_controller.InwardSiteNameText.text ="--Select--";
                          inward_controller. projectId=0;
                          inward_controller. siteId=0;
                          inward_controller. supId=0;
                          inward_controller.InwardNoText.text ="";
                          inward_controller.InwardFreightChargesText.text="0";
                          inward_controller.InwardLabourChargesText.text="0";
                          inward_controller.InwardRoundoffText.text="0";
                          inward_controller.InwardNetAmtText .text="0";
                          inward_controller.InwardInvoiceNoText.text="";
                          inward_controller.InwardDCNoText.text="";
                          inward_controller.InwardManualNoText.text="";
                          inward_controller.InwardVechileNoText.text="";
                          inward_controller.InwardDriverNameText.text="";
                          inward_controller.InwardRemarksText.text="";
                          inward_controller.Zerovalueset(inward_controller.ItemGetTableListdata);
                          inward_controller.entryvalue=1;

                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: inward_controller.checkColor == 0 ?  Theme.of(context).primaryColor : Colors.white  ,
                      ),
                      alignment: Alignment.center,
                      child: Text("Next",  style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: RequestConstant.Lable_Font_SIZE,
                          color:  inward_controller.checkColor == 0 ? Colors.white :  Theme.of(context).primaryColor ),),
                    ),
                    onTap: (){
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();
                        setState(() {
                          inward_controller.checkColor = 0;
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Inward_Itemlist()));
                        });
                      }

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
}

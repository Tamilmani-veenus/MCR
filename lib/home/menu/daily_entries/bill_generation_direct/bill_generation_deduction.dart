import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/auto_yrwise_no_controller.dart';
import '../../../../controller/billgenerationdirect_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../controller/subcontcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class Bill_Generation_direct_deduction extends StatefulWidget {
  const Bill_Generation_direct_deduction({Key? key}) : super(key: key);

  @override
  State<Bill_Generation_direct_deduction> createState() => _Bill_Generation_direct_deductionState();
}

class _Bill_Generation_direct_deductionState extends State<Bill_Generation_direct_deduction> {

  BillGenerationDirectController billGenerationDirectController = Get.put(BillGenerationDirectController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  SiteController siteController = Get.put(SiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      billGenerationDirectController.entrycheck = 1;
      if (billGenerationDirectController.editCheck != 1) {
        billGenerationDirectController.tobededadv.text =
            billGenerationDirectController.to_be_dection_advance;
      }
      billGenerationDirectController.Advded.text = "0";
      await billGenerationDirectController.deductionPaymentCalculation();
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

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
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Bill Generation Direct Deduction",
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
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: billGenerationDirectController.billamount,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Bill Amount",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                            ),
                            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              child: ConstIcons.discription,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value == "0.0") {
                              return '\u26A0 can not allow to bill amount is 0';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                onTap: (){
                                  if(billGenerationDirectController.Creditamt.text != "" && billGenerationDirectController.Creditamt.text != "0" && billGenerationDirectController.Creditamt.text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationDirectController.Creditamt.text = "";
                                      billGenerationDirectController.deductionPaymentCalculation();
                                    });
                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: billGenerationDirectController.Creditamt,
                                cursorColor: Colors.black,
                                style: const  TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Credit-Amount",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.creditAmt,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    billGenerationDirectController.deductionPaymentCalculation();
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 Enter a credit amount';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                controller: billGenerationDirectController.CreditRemarksController,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Remarks",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      child: ConstIcons.remarks),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                onTap: (){
                                  if(billGenerationDirectController.Debitamt.text != "" && billGenerationDirectController.Debitamt.text != "0" && billGenerationDirectController.Debitamt.text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationDirectController.Debitamt.text = "";
                                      billGenerationDirectController.deductionPaymentCalculation();
                                    });
                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: billGenerationDirectController.Debitamt,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Debit-Amount",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      child: ConstIcons.debitAmt),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    billGenerationDirectController.deductionPaymentCalculation();
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 Enter a debit amount';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                controller: billGenerationDirectController.DebitRemarksController,
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
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.remarks,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          readOnly: true,
                          controller: billGenerationDirectController.tobededadv,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "To Be Deduction in Advance",
                            labelStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: RequestConstant.Lable_Font_SIZE),
                            prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8,
                              ),
                              child: ConstIcons.deduction,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          readOnly: billGenerationDirectController.advance(billGenerationDirectController.tobededadv.text),
                          controller: billGenerationDirectController.Advded,
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            labelText: "Advance Deduction Amt",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                            ),
                            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                              child: ConstIcons.advancededuction,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              billGenerationDirectController.deductionPaymentCalculation();
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '\u26A0 Enter advance deduction amount';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3, left: 10, bottom: 5),
                              child: TextFormField(
                                onTap: () {
                                  if(billGenerationDirectController.Roundoff.text != "" && billGenerationDirectController.Roundoff.text != "0" && billGenerationDirectController.Roundoff.text != "0.0"){
                                    return;
                                  } else {
                                    setState(() {
                                      billGenerationDirectController.Roundoff.text = "";
                                      billGenerationDirectController.deductionPaymentCalculation();
                                    });
                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: billGenerationDirectController.Roundoff,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Round off",
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: RequestConstant.Lable_Font_SIZE,
                                  ),
                                  prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: ConstIcons.roundoff,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    billGenerationDirectController.deductionPaymentCalculation();
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return '\u26A0 Enter a round off amount';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                controller:
                                billGenerationDirectController.netpayamt,
                                cursorColor: Colors.black,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  labelText: "Net Pay Amt",
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: RequestConstant.Lable_Font_SIZE),
                                  prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: ConstIcons.netAmt),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: BaseUtitiles.getheightofPercentage(context, 4),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: billGenerationDirectController.checkColor == 0
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Reset",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: billGenerationDirectController.checkColor == 0
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        billGenerationDirectController.checkColor = 1;
                        ResetAlert(context);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      height: BaseUtitiles.getheightofPercentage(context, 4),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: billGenerationDirectController.checkColor == 0
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        billGenerationDirectController.editCheck == 1
                            ? RequestConstant.RESUBMIT
                            : RequestConstant.SUBMIT,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: RequestConstant.Lable_Font_SIZE,
                            color: billGenerationDirectController.checkColor == 0
                                ? Colors.white
                                : Theme.of(context).primaryColor),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        billGenerationDirectController.checkColor = 0;
                        SubmitAlert(context);
                      });
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

  Future SubmitAlert(BuildContext context) async {
    billGenerationDirectController.buttonControl = 0;
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: Text(billGenerationDirectController.editCheck == 1
            ? 'Are you sure to Re-Submit?'
            : 'Are you sure to Submit?',
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: RequestConstant.Lable_Font_SIZE,
                        ),
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15,
                  ),

                  Expanded(
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return TextButton(
                          onPressed:  () async {
                            if (_formKey.currentState!.validate() &&
                                projectController.selectedProjectId.value != 0 &&
                                siteController.selectedsiteId.value != 0 &&
                                subcontractorController.selectedSubcontId.value != 0) {

                              // Check for credit and debit amount remarks
                              if (billGenerationDirectController.Creditamt.text != "0.0") {
                                BaseUtitiles.showToast("Please enter a credit Remarks");
                              } else if (billGenerationDirectController.Debitamt.text != "0.0") {
                                BaseUtitiles.showToast("Please enter a Debit Remarks");
                              } else {
                                if (await BaseUtitiles
                                    .checkNetworkAndShowLoader(context)) {
                                  await billGenerationDirectController
                                      .SaveButton_DeductionScreen(
                                      context,
                                      billGenerationDirectController.workid
                                  );
                                }
                              }
                            } else if (double.parse(billGenerationDirectController.netpayamt.text) < 0) {
                              BaseUtitiles.showToast("Net pay amount must be greater than 0");
                            } else {
                              BaseUtitiles.showToast("Please check all details once again");
                          }
                          },
                          child: Text(
                            billGenerationDirectController.editCheck == 1
                                ? RequestConstant.RESUBMIT
                                : RequestConstant.SUBMIT,
                            style: TextStyle(
                              color: billGenerationDirectController.buttonControl == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey, // Change color when disabled
                              fontWeight: FontWeight.bold,
                              fontSize: RequestConstant.Lable_Font_SIZE,
                            ),
                          ),
                        );
                      },
                    ),
                  )


                  ///--------old code
                  // Expanded(
                  //   child: TextButton(
                  //       onPressed: () async {
                  //         if (_formKey.currentState!.validate() &&
                  //             projectController.selectedProjectId.value != 0 &&
                  //             siteController.selectedsiteId.value != 0 &&
                  //             subcontractorController.selectedSubcontId.value != 0) {
                  //           if (billGenerationDirectController.Creditamt.text != "0.0") {
                  //             BaseUtitiles.showToast("Please enter a credit Remarks");
                  //           } else if (billGenerationDirectController.Debitamt.text != "0.0") {
                  //             BaseUtitiles.showToast("Please enter a Debit Remarks");
                  //           } else {
                  //           }
                  //           if(billGenerationDirectController.buttonControl == 0){
                  //             BaseUtitiles.showLoadingDialog(context, Theme.of(context).primaryColor);
                  //             await billGenerationDirectController.SaveButton_DeductionScreen(context, billGenerationDirectController.workid);
                  //             billGenerationDirectController.buttonControl = 0;
                  //           } else if (billGenerationDirectController.buttonControl == 1) {
                  //             billGenerationDirectController.buttonControl = 0;
                  //             BaseUtitiles.showToast("Please wait... processing.");
                  //           }
                  //         } else if (double.parse(billGenerationDirectController.netpayamt.text) < 0) {
                  //           BaseUtitiles.showToast("Net pay amount must be in greater than 0");
                  //         } else {
                  //           BaseUtitiles.showToast("Please Check all details once again");
                  //         }
                  //       },
                  //       child: Text(
                  //           billGenerationDirectController.editCheck == 1 ? RequestConstant.RESUBMIT : RequestConstant.SUBMIT,
                  //           style: TextStyle(
                  //               color: Theme.of(context).primaryColor,
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: RequestConstant.Lable_Font_SIZE))),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future ResetAlert(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Are you sure to Reset?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
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
                          billGenerationDirectController.to_be_dection_advance =
                          "0";
                          billGenerationDirectController.saveButton.value =
                              RequestConstant.SUBMIT;
                          billGenerationDirectController.workid = 0;
                          projectController.projectname.text = "--Select--";
                          projectController.selectedProjectId.value = 0;
                          subcontractorController.Subcontractorname.text =
                          "--Select--";
                          subcontractorController.selectedSubcontId.value = 0;
                          billGenerationDirectController.RemarksController
                              .clear();
                          billGenerationDirectController.billentryDateController
                              .text = BaseUtitiles.initiateCurrentDateFormat();
                          billGenerationDirectController.FromdateController
                              .text = BaseUtitiles.initiateCurrentDateFormat();
                          billGenerationDirectController.TodateController.text =
                              BaseUtitiles.initiateCurrentDateFormat();
                          billGenerationDirectController
                              .autoYearWiseNoController.text =
                              autoYearWiseNoController
                                  .DirectBillautoYrsWise.value;
                          siteController.selectedsiteId = 0.obs;
                          siteController.selectedsitedropdownName =
                              "--Select--".obs;
                          siteController.getSiteDropdownvalue.value.clear();
                          siteController.Sitename.text = RequestConstant.SELECT;
                          siteController.siteDropdownName.clear();

                          billGenerationDirectController
                              .billgen_itemlistTable_Delete();
                          billGenerationDirectController
                              .ItemGetTableListdata.value
                              .clear();

                          billGenerationDirectController.billamount.text =
                          "0.0";
                          billGenerationDirectController.Creditamt.text = "0.0";
                          billGenerationDirectController.Debitamt.text = "0.0";
                          billGenerationDirectController
                              .CreditRemarksController.text = "";
                          billGenerationDirectController
                              .DebitRemarksController.text = "";
                          billGenerationDirectController.Advded.text =
                              billGenerationDirectController.tobededadv.text;
                          billGenerationDirectController.Roundoff.text = "0";
                          billGenerationDirectController.netpayamt.text = "0.0";
                          billGenerationDirectController.tobededadv.text =
                              billGenerationDirectController
                                  .to_be_dection_advance;
                          Navigator.pop(context);
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
}


import '../../../../controller/stocksite_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_theme/app_colors.dart';
import '../../constants/ui_constant/icons_const.dart';
import '../../controller/bottomsheet_Controllers.dart';

class MaterialWise extends StatefulWidget {
  const MaterialWise({Key? key}) : super(key: key);

  @override
  State<MaterialWise> createState() => _MaterialWiseState();
}

class _MaterialWiseState extends State<MaterialWise> {
  StockSiteController stockSiteController = Get.put(StockSiteController());
  BottomsheetControllers bottomsheetControllers = Get.put(BottomsheetControllers());

  @override
  void initState() {
    var duration = Duration(seconds: 0);
    Future.delayed(duration, () async {
      await stockSiteController.getProjectWisesubmaterialDropdownList(context);
      await stockSiteController.getmaterialDropdowntList(context);
      await stockSiteController.selectedMaterialName(0);

      stockSiteController.setSelectedSubMatListName(0);
      stockSiteController.matDropdowntId.value=0;
      stockSiteController.Subheadername.text="--Select--";
      stockSiteController.materialDropdowntId.value = 0;
      setState(() {
        stockSiteController.materialWiseShowList.value.clear();
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
                        labelText: "Material Sub Head",
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
                        setState(() {
                          bottomsheetControllers.MaterialSubItem(context, stockSiteController.getmaterialSubdropDownvalue.value);
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
                      controller: stockSiteController.Subheadername,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        labelText: "Material Name",
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
                        setState(() {
                          bottomsheetControllers.MaterialName_stockatSite(context, stockSiteController.getMaterialdropDownvalue.value);
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



              Center(
                child: Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 30),
                  margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      side: BorderSide(width: 3, color: Colors.white),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () async {
                      stockSiteController.getMaterialShowList();
                    },
                    child: Text("Show"),
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


  void textclear(){
    stockSiteController.projectShowList.value.clear();
    stockSiteController.getMaterialDropdownName.clear();
    stockSiteController.Subheadername.text="--Select--";
  }

  Widget ListDetails(){
    return Container(
      height:BaseUtitiles.getheightofPercentage(context,60),
      width: BaseUtitiles.getWidthtofPercentage(context,100),
      child: Obx(()=>ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: stockSiteController.materialWiseShowList.value.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){

              },
              child: Container(
                margin: EdgeInsets.all(3),
                child: Card(
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Material: ", style: TextStyle(color:Theme.of(context).primaryColor,fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 5,
                                child: Text(stockSiteController.materialWiseShowList.value[index].header.toString(),style: TextStyle(color: Colors.black),)),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Project Name: ", style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 5,
                                child: Text(stockSiteController.materialWiseShowList.value[index].footer.toString(),style: TextStyle(color: Colors.black),)),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Text("Site Name: ", style: TextStyle(color:Theme.of(context).primaryColor,fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 5,
                                child: Text(stockSiteController.materialWiseShowList.value[index].siteName.toString(),style: TextStyle(color: Colors.black),)),
                          ],
                        ),

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
                                    stockSiteController.materialWiseShowList.value[index].unit.toString(),style: TextStyle(color: Colors.black)),
                              ),
                              Expanded(
                                flex: 8,
                                child: Text("Stock Qty:",style: TextStyle(color: Colors.black),),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  (stockSiteController.materialWiseShowList.value[index].stockQty.toString()),style: TextStyle(color: Colors.black),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
      ),
    );

  }

}

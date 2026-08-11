import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../app_theme/app_colors.dart';
import '../../controller/comman_controller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/menu_controller.dart';
import '../../utilities/baseutitiles.dart';
import '../maindashboard/dashboard.dart';
import '../maindashboard/dashboard_otheruser.dart';

class MainManusList extends StatefulWidget {
  const MainManusList({Key? key}) : super(key: key);

  @override
  State<MainManusList> createState() => _MainManusListState();
}

class _MainManusListState extends State<MainManusList> {
  CommanController commanController = Get.put(CommanController());
  //MenuController menuController = Get.put(MenuController());
  Menu_Controller menuController = Get.put(Menu_Controller());
  LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () async {
      await menuController.getMenuList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Setmybackground,
      body: WillPopScope(
        onWillPop: () => homeScreen(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(child: rowDetails()),
            )
          ],
        ),
      ),
    );
  }

  homeScreen() {
    if(loginController.user.value.userType=="A"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard_screen()));
    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen_OtherUser()));
    }
  }

  Widget rowDetails() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: menuController.menuListDatas.value.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
                        child: Text(
                            menuController.menuListDatas.value[index].headName == "Materials"
                                ? "Materials"
                                : menuController.menuListDatas.value[index].headName == "Daily Entries"
                                    ? "Daily Entries"
                                    : menuController.menuListDatas.value[index].headName == "Main Menu"
                                        ? "Main Menu"
                                        : menuController.menuListDatas.value[index].headName == "Accounts"
                                            ? "Accounts"
                                            : "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  menuController.menuListDatas.value[index].headName ==
                          "Materials"
                      ? Container(
                          margin:
                              const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          height:
                              BaseUtitiles.getheightofPercentage(context, 26),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: GridView.builder(
                              // scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: menuController.subMatList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          menuController.subMatList[index] ==
                                                  "MRN Request (Indent)"
                                              ? Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                    gradient: LinearGradient(
                                                      begin:
                                                          Alignment.topLeft,
                                                      end: Alignment
                                                          .bottomRight,
                                                      colors: [
                                                        purple,
                                                        blue,
                                                      ],
                                                    ),
                                                  ),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .penToSquare,
                                                        // FontAwesomeIcons.clipboardList,
                                                        color: Colors.white,
                                                        size: 25,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : menuController.subMatList[
                                                          index] ==
                                                      "Inward"
                                                  ? Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration:
                                                          BoxDecoration(
                                                        color:
                                                            Theme.of(context)
                                                                .primaryColor,
                                                        borderRadius:
                                                            const BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                            purple,
                                                            blue,
                                                          ],
                                                        ),
                                                      ),
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .listCheck,
                                                            color:
                                                                Colors.white,
                                                            size: 25,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : menuController.subMatList[
                                                              index] ==
                                                          "Transfer Between Projects"
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets.only(
                                                                  top: 10),
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10),
                                                            ),
                                                            gradient:
                                                                LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors: [
                                                                purple,
                                                                blue,
                                                              ],
                                                            ),
                                                          ),
                                                          child: const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                FontAwesomeIcons
                                                                    .arrowsTurnToDots,
                                                                color: Colors
                                                                    .white,
                                                                size: 25,
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : menuController.subMatList[
                                                                  index] ==
                                                              "Transfer Between Sites"
                                                          ? Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                gradient:
                                                                    LinearGradient(
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomRight,
                                                                  colors: [
                                                                    purple,
                                                                    blue,
                                                                  ],
                                                                ),
                                                              ),
                                                              child: const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    FontAwesomeIcons
                                                                        .arrowsSpin,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 25,
                                                                  )
                                                                  // Image.asset('assets/images/ic_wallet.png',
                                                                  //     width: 22),
                                                                ],
                                                              ),
                                                            )
                                                          : menuController.subMatList[
                                                                      index] ==
                                                                  "Consumption"
                                                              ? Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          10),
                                                                    ),
                                                                    gradient:
                                                                        LinearGradient(
                                                                      begin: Alignment
                                                                          .topLeft,
                                                                      end: Alignment
                                                                          .bottomRight,
                                                                      colors: [
                                                                        purple,
                                                                        blue,
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  child: const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        FontAwesomeIcons
                                                                            .personDigging,
                                                                        color:
                                                                            Colors.white,
                                                                        size:
                                                                            25,
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: 40,
                                                                  height: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          10),
                                                                    ),
                                                                    gradient:
                                                                        LinearGradient(
                                                                      begin: Alignment
                                                                          .topLeft,
                                                                      end: Alignment
                                                                          .bottomRight,
                                                                      colors: [
                                                                        purple,
                                                                        blue,
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  child: const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .account_balance,
                                                                        color:
                                                                            Colors.white,
                                                                        size:
                                                                            25,
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            menuController.subMatList[index] ==
                                                    "MRN Request (Indent)"
                                                ? "MRN(Indent)"
                                                : menuController.subMatList[index] == "Inward"
                                                    ? "Inward"
                                                    : menuController.subMatList[index] == "Transfer Between Projects"
                                                        ? "Transfer \n B/w  Projects"
                                                        : menuController.subMatList[index] == "Transfer Between Sites"
                                                            ? "Transfer \n B/w Sites"
                                                            : menuController.subMatList[index] == "Consumption"
                                                                ? "Consumption"
                                                                : "",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    menuController.MaterialScreen(menuController.subMatList[index], context);
                                    menuController.formName.value = menuController.subMatList[index];
                                    await commanController.getControllEntryListRights();
                                  },
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 140,
                                      childAspectRatio: 7 / 6,
                                      crossAxisSpacing: 3,
                                      mainAxisSpacing: 10),
                            ),
                          ),
                        )
                      : Container(),
                  menuController.menuListDatas.value[index].headName ==
                          "Main Menu"
                      ? Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          //height: BaseUtitiles.getheightofPercentage(context, 33),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: GridView.builder(
                              // scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: menuController.subMainmenuList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            menuController.subMainmenuList[
                                                        index] ==
                                                    "BOQ - Revised"
                                                ? Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          purple,
                                                          blue,
                                                        ],
                                                      ),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .diagramSuccessor,
                                                          color: Colors.white,
                                                          size: 25,
                                                        )
                                                        // Image.asset('assets/images/ic_wallet.png',
                                                        //     width: 22),
                                                      ],
                                                    ),
                                                  )
                                                : menuController.subMainmenuList[
                                            index] ==
                                                "Work Order - Direct"
                                                ? Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                gradient: LinearGradient(
                                                  begin:
                                                  Alignment.topLeft,
                                                  end: Alignment
                                                      .bottomRight,
                                                  colors: [
                                                    purple,
                                                    blue,
                                                  ],
                                                ),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Icon(
                                                    Icons.assignment,
                                                    color: Colors.white,
                                                    size: 25,
                                                  )
                                                  // Image.asset('assets/images/ic_wallet.png',
                                                  //     width: 22),
                                                ],
                                              ),
                                            )
                                                : Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          purple,
                                                          blue,
                                                        ],
                                                      ),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.account_balance,
                                                          color: Colors.white,
                                                          size: 25,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(top: 6),
                                              child: Text(
                                                menuController.subMainmenuList[
                                                            index] ==
                                                        "BOQ - Revised"
                                                    ? "BOQ - Revised"
                                                    // : menuController.subMainmenuList[index] == "Material Purchase - Item Wise" ? "Material Purchase"
                                                    // : menuController.subMainmenuList[index] == "Material Transfer" ? "Material Transfer"
                                                    // : menuController.subMainmenuList[index] == "Material Usage" ? "Material Usage"
                                                    // : menuController.subMainmenuList[index] == "Stock Report" ? "Stock"
                                                    : menuController.subMainmenuList[
                                                index] ==
                                                    "Work Order - Direct"
                                                    ? "Work Order - Direct" : "",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    menuController.MainmenuScreen(
                                        menuController.subMainmenuList[index],
                                        context);
                                    menuController.formName.value =
                                        menuController.subMainmenuList[index];
                                    await commanController.getControllEntryListRights();
                                  },
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 140,
                                      childAspectRatio: 7 / 6,
                                      crossAxisSpacing: 3,
                                      mainAxisSpacing: 10),
                            ),
                          ),
                        )
                      : Container(),
                  menuController.menuListDatas.value[index].headName ==
                          "Daily Entries"
                      ? Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: menuController.dailyEntryList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 12),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            menuController.dailyEntryList[
                                                        index] ==
                                                    "SubContractor Attendance"
                                                ? Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          purple,
                                                          blue,
                                                        ],
                                                      ),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .userCheck,
                                                          color: Colors.white,
                                                          size: 25,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : menuController.dailyEntryList[
                                                            index] ==
                                                        "Company NMR Attendance"
                                                    ? Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            colors: [
                                                              purple,
                                                              blue,
                                                            ],
                                                          ),
                                                        ),
                                                        child: const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .subject_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: 25,
                                                            )
                                                            // Image.asset('assets/images/ic_wallet.png',
                                                            //     width: 22),
                                                          ],
                                                        ),
                                                      )
                                                    : menuController.dailyEntryList[
                                                                index] ==
                                                            "NMR Wkly Bill - Generation"
                                                        ? Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10),
                                                              ),
                                                              gradient:
                                                                  LinearGradient(
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                                colors: [
                                                                  purple,
                                                                  blue,
                                                                ],
                                                              ),
                                                            ),
                                                            child: const Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .attractions,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 25,
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : menuController.dailyEntryList[
                                                                    index] ==
                                                                "Daily Work Done (DPR)"
                                                            ? Container(
                                                                width: 40,
                                                                height: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight,
                                                                    colors: [
                                                                      purple,
                                                                      blue,
                                                                    ],
                                                                  ),
                                                                ),
                                                                child: const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      FontAwesomeIcons
                                                                          .trowelBricks,
                                                                      // FontAwesomeIcons.peopleCarryBox,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 25,
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : menuController.dailyEntryList[
                                                                        index] ==
                                                                    "Daily Work Done (DPR New)"
                                                                ? Container(
                                                                    width: 40,
                                                                    height: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            10),
                                                                      ),
                                                                      gradient:
                                                                          LinearGradient(
                                                                        begin: Alignment
                                                                            .topLeft,
                                                                        end: Alignment
                                                                            .bottomRight,
                                                                        colors: [
                                                                          purple,
                                                                          blue,
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    child: const Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(
                                                                          FontAwesomeIcons
                                                                              .trowel,
                                                                          color:
                                                                              Colors.white,
                                                                          size:
                                                                              25,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                : menuController.dailyEntryList[
                                                                            index] ==
                                                                        "Daily Work Done (DPR Labour)"
                                                                    ? Container(
                                                                        width:
                                                                            40,
                                                                        height:
                                                                            40,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Theme.of(context).primaryColor,
                                                                          borderRadius:
                                                                              const BorderRadius.all(
                                                                            Radius.circular(10),
                                                                          ),
                                                                          gradient:
                                                                              LinearGradient(
                                                                            begin:
                                                                                Alignment.topLeft,
                                                                            end:
                                                                                Alignment.bottomRight,
                                                                            colors: [
                                                                              purple,
                                                                              blue,
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            const Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.account_tree,
                                                                              color: Colors.white,
                                                                              size: 25,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : menuController.dailyEntryList[index] ==
                                                                            "Bill Generation - Direct"
                                                                        ? Container(
                                                                            width:
                                                                                40,
                                                                            height:
                                                                                40,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Theme.of(context).primaryColor,
                                                                              borderRadius: const BorderRadius.all(
                                                                                Radius.circular(10),
                                                                               ),
                                                                              gradient: LinearGradient(
                                                                                begin: Alignment.topLeft,
                                                                                end: Alignment.bottomRight,
                                                                                colors: [
                                                                                  purple,
                                                                                  blue,
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                const Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  FontAwesomeIcons.fileSignature,
                                                                                  color: Colors.white,
                                                                                  size: 25,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )
                                                                        : menuController.dailyEntryList[index] ==
                                                                                "Requisition Voucher"
                                                                            ? Container(
                                                                                width: 40,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(
                                                                                  color: Theme.of(context).primaryColor,
                                                                                  borderRadius: const BorderRadius.all(
                                                                                    Radius.circular(10),
                                                                                  ),
                                                                                  gradient: LinearGradient(
                                                                                    begin: Alignment.topLeft,
                                                                                    end: Alignment.bottomRight,
                                                                                    colors: [
                                                                                      purple,
                                                                                      blue,
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                child: const Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.add_business_outlined,
                                                                                      color: Colors.white,
                                                                                      size: 25,
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : menuController.dailyEntryList[index] == "Pre Approval"
                                                                                ? Container(
                                                                                    width: 40,
                                                                                    height: 40,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Theme.of(context).primaryColor,
                                                                                      borderRadius: const BorderRadius.all(
                                                                                        Radius.circular(10),
                                                                                      ),
                                                                                      gradient: LinearGradient(
                                                                                        begin: Alignment.topLeft,
                                                                                        end: Alignment.bottomRight,
                                                                                        colors: [
                                                                                          purple,
                                                                                          blue,
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    child: const Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.ac_unit,
                                                                                          color: Colors.white,
                                                                                          size: 25,
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ):
                                            menuController.dailyEntryList[index] == "SubCont NMR Wkly Bill - Generation"
                                                                                ? Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                const BorderRadius
                                                    .all(
                                                  Radius.circular(10),
                                                ),
                                                gradient:
                                                LinearGradient(
                                                  begin: Alignment
                                                      .topLeft,
                                                  end: Alignment
                                                      .bottomRight,
                                                  colors: [
                                                    purple,
                                                    blue,
                                                  ],
                                                ),
                                              ),
                                              child: const Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .receipt_long_outlined,
                                                    color: Colors.white,
                                                    size: 25,
                                                  )
                                                ],
                                              ),
                                            ):Container(
                                                                                    width: 40,
                                                                                    height: 40,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Theme.of(context).primaryColor,
                                                                                      borderRadius: const BorderRadius.all(
                                                                                        Radius.circular(10),
                                                                                      ),
                                                                                      gradient: LinearGradient(
                                                                                        begin: Alignment.topLeft,
                                                                                        end: Alignment.bottomRight,
                                                                                        colors: [
                                                                                          purple,
                                                                                          blue,
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    child: const Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Icon(
                                                                                          Icons.account_balance,
                                                                                          color: Colors.white,
                                                                                          size: 25,
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(top: 6),
                                              child: Text(
                                                menuController.dailyEntryList[
                                                            index] ==
                                                        "SubContractor Attendance"
                                                    ? "SubContractor\nAttendance"
                                                    : menuController.dailyEntryList[
                                                                index] ==
                                                            "Company NMR Attendance"
                                                        ? "NMR Attendance"
                                                        : menuController.dailyEntryList[
                                                                    index] ==
                                                                "SubCont NMR Wkly Bill - Generation"
                                                            ? "NMR Wkly Bill"
                                                            : menuController.dailyEntryList[
                                                                        index] ==
                                                                    "Daily Work Done (DPR)"
                                                                ? "DPR"
                                                                : menuController.dailyEntryList[
                                                                            index] ==
                                                                        "Daily Work Done (DPR New)"
                                                                    ? "DPR NEW"
                                                                    : menuController.dailyEntryList[index] ==
                                                                            "Daily Work Done (DPR Labour)"
                                                                        ? "Work Done(DPR Labour)"
                                                                        : menuController.dailyEntryList[index] ==
                                                                                "Bill Generation - Direct"
                                                                            ? "Bill Direct"
                                                                            : menuController.dailyEntryList[index] == "Requisition Voucher"
                                                                                ? "Adv Req Voucher"
                                                                                : menuController.dailyEntryList[index] == "Pre Approval"
                                                                                    ? "Pre Approval"
                                                                                    : "",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    menuController.NavigateScreen(
                                        menuController.dailyEntryList[index],
                                        context);
                                    menuController.formName.value =
                                        menuController.dailyEntryList[index];
                                    await commanController.getControllEntryListRights();
                                  },
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 140,
                                      childAspectRatio: 7 / 6,
                                      crossAxisSpacing: 3,
                                      mainAxisSpacing: 13),
                            ),
                          ),
                        )
                      : Container(),
                  menuController.menuListDatas.value[index].headName ==
                          "Accounts"
                      ? Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: menuController.accountsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 12),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            menuController
                                                        .accountsList[index] ==
                                                    "Site Voucher"
                                                ? Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                      gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          purple,
                                                          blue,
                                                        ],
                                                      ),
                                                    ),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .vertical_split_outlined,
                                                          color: Colors.white,
                                                          size: 25,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : menuController.accountsList[
                                                            index] ==
                                                        "Staff Voucher"
                                                    ? Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          gradient:
                                                              LinearGradient(
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                            colors: [
                                                              purple,
                                                              blue,
                                                            ],
                                                          ),
                                                        ),
                                                        child: const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .laptopFile,
                                                              color:
                                                                  Colors.white,
                                                              size: 25,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : menuController.accountsList[
                                                                index] ==
                                                            "Cash Book/Staff"
                                                        ? Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    10),
                                                              ),
                                                              gradient:
                                                                  LinearGradient(
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                                colors: [
                                                                  purple,
                                                                  blue,
                                                                ],
                                                              ),
                                                            ),
                                                            child: const Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  FontAwesomeIcons
                                                                      .fileInvoiceDollar,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 25,
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : menuController.accountsList[
                                                                    index] ==
                                                                "Cash Book/Site"
                                                            ? Container(
                                                                width: 40,
                                                                height: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight,
                                                                    colors: [
                                                                      purple,
                                                                      blue,
                                                                    ],
                                                                  ),
                                                                ),
                                                                child: const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .add_card,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 25,
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : Container(
                                                                width: 40,
                                                                height: 40,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                  gradient:
                                                                      LinearGradient(
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight,
                                                                    colors: [
                                                                      purple,
                                                                      blue,
                                                                    ],
                                                                  ),
                                                                ),
                                                                child: const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .account_balance,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 25,
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(top: 6),
                                              child: Text(
                                                menuController.accountsList[
                                                            index] ==
                                                        "Site Voucher"
                                                    ? "Site Voucher"
                                                    : menuController.accountsList[
                                                                index] ==
                                                            "Staff Voucher"
                                                        ? "Staff Voucher"
                                                        : menuController.accountsList[
                                                                    index] ==
                                                                "Cash Book/Staff"
                                                            ? "Cash Book/Staff"
                                                            : menuController.accountsList[
                                                                        index] ==
                                                                    "Cash Book/Site"
                                                                ? "Cash Book/Site"
                                                                : "",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    menuController.AccountsScreen(
                                        menuController.accountsList[index],
                                        context);
                                    menuController.formName.value =
                                        menuController.accountsList[index];
                                    await commanController.getControllEntryListRights();
                                  },
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 140,
                                      childAspectRatio: 8 / 6,
                                      crossAxisSpacing: 3,
                                      mainAxisSpacing: 10),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          },
        ));
  }
}

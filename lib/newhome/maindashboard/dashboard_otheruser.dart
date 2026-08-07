import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mcr/controller/site_location_controller.dart';
import 'package:upgrader/upgrader.dart';
import '../../app_theme/app_colors.dart';
import '../../constants/storage_constant.dart';
import '../../controller/auto_yrwise_no_controller.dart';
import '../../controller/comman_controller.dart';
import '../../controller/companycontroller.dart';
import '../../controller/dashboard_controller.dart';
import '../../controller/logincontroller.dart';
import '../../controller/menu_controller.dart';
import '../../controller/pendinglistcontroller.dart';
import '../../controller/projectcontroller.dart';
import '../../controller/punch_in_controller.dart';
import '../../controller/requisitionslip_controller.dart';
import '../../controller/stocksite_controller.dart';
import '../../controller/subcontcontroller.dart';
import '../../home/account_settings/account_setting.dart';
import '../../home/dashboard/button_widget.dart';
import '../../home/dashboard/site_locations_view.dart';
import '../../home/punch_in_out/punch_in.dart';
import '../../home/punch_in_out/punch_out.dart';
import '../../login/animation_signinpage/Animations/FadeAnimation.dart';
import '../../login/animation_signinpage/signin_page.dart';
import '../../login/animation_signinpage/welcomepage.dart';
import '../../provider/daily_wrkdone_dprNew_provider.dart';
import '../../utilities/baseutitiles.dart';
import '../../utilities/requestconstant.dart';
import '../menus/main_menuslist.dart';
import '../pendinglist.dart';
import '../reports/reports.dart';


class DashboardScreen_OtherUser extends StatefulWidget {
  DashboardScreen_OtherUser({Key? key}) : super(key: key);

  @override
  State<DashboardScreen_OtherUser> createState() => _DashboardScreen_OtherUserState();
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class _DashboardScreen_OtherUserState extends State<DashboardScreen_OtherUser> {

  int _currentPage = 0;
  final _pageController = PageController();
  final searchcontroller = TextEditingController();

  LoginController loginController = Get.put(LoginController());
  ProjectController projectController = Get.put(ProjectController());
  SubcontractorController subcontractorController = Get.put(SubcontractorController());
  CompanyController Companycontroller = Get.put(CompanyController());
  StockSiteController stockSiteController = Get.put(StockSiteController());
  AutoYearWiseNoController autoYearWiseNoController = Get.put(AutoYearWiseNoController());
  // MenuController menuController = Get.put(MenuController());
  Menu_Controller menuController=Get.put(Menu_Controller());
  PendingListController pendingListController = Get.put(PendingListController());
  RequisitionSlipController requisitionSlipController = Get.put(RequisitionSlipController());
  CommanController commanController = Get.put(CommanController());
  Dashboard_Controller dashboard_controller = Get.put(Dashboard_Controller());

  final _upgrader = Upgrader(
      debugLogging: true, durationUntilAlertAgain: const Duration(seconds: 10));

  @override
  void initState() {
    setState(() {
      punchIn = false;
    });
    var duration = const Duration(seconds: 0);
    Future.delayed(duration, () {
      autoyrwise();
      SignInPage.checkVersion(context);
    });
    super.initState();
  }

  autoyrwise() async {
    await menuController.getMenuList();
    await DPR_New_Provider.getMaterial();
    await pendingListController.getPendingList();
    await autoYearWiseNoController.AutoYearWise();
    await autoYearWiseNoController.NMR_AutoYearWise();
    await autoYearWiseNoController.DPR_NEW_AutoYearWise();
    await autoYearWiseNoController.DPR_AutoYearWise();
    await autoYearWiseNoController.DPR_Labour_AutoYearWise();
    await autoYearWiseNoController.directBill_AutoYearWise();
    await autoYearWiseNoController.InwardPending_AutoYearWise();
    await autoYearWiseNoController.TransferBetProject_AutoYearWise();
    await autoYearWiseNoController.TransferBetSite_AutoYearWise();
    await autoYearWiseNoController.ADVREQVoucher_AutoYearWise();
    await autoYearWiseNoController.SiteVoucherAutoYear();
    await autoYearWiseNoController.StaffVocAutoYear();
    await autoYearWiseNoController.MRNRequest_AutoYearWise();
    await autoYearWiseNoController.CompanyNMR_AutoYearWise();
    await autoYearWiseNoController.Consumprion_AutoYearWise();
    await autoYearWiseNoController.Boq_Revised_AutoYearWise();
    await autoYearWiseNoController.RequisitionSlipAutoYr();
    await autoYearWiseNoController.PreApproval_AutoYearWise();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
          backgroundColor: Setmybackground,
          bottomNavigationBar: BottomBar(
            selectedIndex: _currentPage,
            onTap: (int index) {
              _pageController.jumpToPage(index);
              setState(() => _currentPage = index);
            },
            items: const <BottomBarItem>[
              BottomBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Color(0xFF4B3FFF),
              ),
              BottomBarItem(
                icon: Icon(Icons.menu_open),
                title: Text('Menus'),
                activeColor: Color(0xFF4B3FFF),
              ),
              BottomBarItem(
                icon: Icon(Icons.list_alt),
                title: Text('List'),
                activeColor: Color(0xFF4B3FFF),
              ),
              BottomBarItem(
                icon: Icon(Icons.file_copy_outlined),
                title: Text('Reports'),
                activeColor: Color(0xFF4B3FFF),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      const Expanded(
                          flex: 3,
                          child: Text(
                            "Dashboard",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      Container(
                        child: InkWell(
                          child: Container(
                              margin: const EdgeInsets.only(left: 20, right: 10),
                              child: Icon(Icons.settings, color: Theme.of(context).primaryColor)),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AccountSettings()));
                          },
                        ),
                      ),
                      Container(
                        child: InkWell(
                          child: Container(
                              margin: const EdgeInsets.only(left: 20, right: 10),
                              child: Icon(Icons.logout,
                                  color: Theme.of(context).primaryColor)),
                          onTap: () {
                            logoutPopup(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 8)
                    ],
                  ),
                  const Divider(),
                  SizedBox(
                    height: BaseUtitiles.getheightofPercentage(context, 84),
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: const HomeScreenOtherUser(),),
                        Container(
                          alignment: Alignment.center,
                          child: const MainManusList(),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const PendingList_Screen(),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: const Reports_screen(),
                        ),
                      ],
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        }
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
  Future logoutPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alert!'),
        content: const Text('Are you sure to Logout?'),
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
                          return Navigator.of(context).pop();
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: RequestConstant.Lable_Font_SIZE,
                            ))),
                  ),
                  VerticalDivider(
                    color: Colors.grey.shade400,
                    width: 5,
                    thickness: 2,
                    indent: 15,
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          loginController.usertoken_DeleteApi();
                          loginController.deleteLoginDetails();
                          SessionStorage.removeUser();
                          BaseUtitiles.showToast('Logout Successfully');
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            // MaterialPageRoute(builder: (context) => LoginScreen()),
                            MaterialPageRoute(
                                builder: (context) => const WelcomePage()),
                          );
                        },
                        child: const Text("Logout",
                            style: TextStyle(
                                color: Colors.red,
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


class HomeScreenOtherUser extends StatefulWidget {
  const HomeScreenOtherUser({Key? key}) : super(key: key);

  @override
  State<HomeScreenOtherUser> createState() => _HomeScreenOtherUserState();
}

class _HomeScreenOtherUserState extends State<HomeScreenOtherUser> {

  LoginController loginController = Get.put(LoginController());
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  PunchInController punchInController = Get.put(PunchInController());

  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App!'),
        content: const Text('Do you want to exit an App?'),
        actions: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
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
                    endIndent: 15, //Spacing at the bottom of divider.
                  ),
                  Expanded(
                    child: SizedBox(
                      width: BaseUtitiles.getWidthtofPercentage(context, 15),
                      child: TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Exit",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                  RequestConstant.Lable_Font_SIZE,
                              ))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ) ??
        false;
  }


  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );

  final kGradientBoxDecoration = BoxDecoration(
    gradient: const LinearGradient(colors: [Colors.black, Colors.redAccent]),
    borderRadius: BorderRadius.circular(32),
  );

  void _handleRadioValueChange(int? value) {
    setState(() {
      punchInController.selectedRadio.value = value!;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    punchInController.getOndutyPunchInSts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          punchInController.selectedRadio.value = 0;
        });
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: WillPopScope(
              onWillPop: () async {
                showExitPopup(context);
                return true;
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 100),
                    Column(
                      children: [
                        FadeAnimation(1.2,
                          Container(
                            child: SizedBox(
                              height: 210,
                              width: 210,
                              child: Transform(
                                alignment: FractionalOffset.center,
                                transform: Matrix4.rotationZ(
                                  3.1415926535897932 / 4,
                                ),
                                child: Container(
                                  decoration: kGradientBoxDecoration,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      decoration: kInnerDecoration,
                                      child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationZ(
                                          -3.1415926535897932 / 4,
                                        ),
                                        child: FractionallySizedBox(
                                          widthFactor: 1,  // 50% of parent width
                                          heightFactor: 0.6, // 50% of parent height
                                          child: Image.asset(
                                            "assets/images/resizelogo_new.jpg",
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: BaseUtitiles.getheightofPercentage(context, 5)),
                        FadeAnimation(1.5, Column(
                          children: <Widget>[
                            FadeAnimation(1.8, Container(
                              alignment: Alignment.center,
                              width: BaseUtitiles.getWidthtofPercentage(context, 100),
                              child: Text(loginController.UserName().toString(), style: const TextStyle(color: Colors.indigo,fontSize: RequestConstant.Heading_Font_SIZE, fontWeight: FontWeight.bold),),
                            )),
                            const SizedBox(height: 20),
                          ],
                        )),
                        FadeAnimation(  1.5,
                          Card(elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32), // Apply rounded corners here
                            ),
                            child: Container(
                              decoration: kGradientBoxDecoration,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  width: BaseUtitiles.getWidthtofPercentage(context, 70),
                                  child: Column(
                                    children: [
                                      SizedBox( height: BaseUtitiles.getheightofPercentage(context, 2),),
                                      Obx(()=>
                                          FadeAnimation(
                                            1.5, Container(
                                            width: BaseUtitiles.getWidthtofPercentage(context, 55),
                                            height: BaseUtitiles.getheightofPercentage(context, 5),
                                            child: ListTile(
                                              title: GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      _handleRadioValueChange(1);
                                                    });
                                                  },
                                                  child: Text('ProjectWise',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))),
                                              leading: Radio<int>(
                                                activeColor: Theme.of(context).primaryColor,
                                                value: 1,
                                                groupValue: punchInController.selectedRadio.value,
                                                onChanged: _handleRadioValueChange,
                                              ),
                                            ),
                                          ),
                                          ),
                                      ),
                                      Obx(()=>
                                          FadeAnimation(
                                            1.5,
                                            Container(

                                                width: BaseUtitiles.getWidthtofPercentage(context, 55),
                                                height: BaseUtitiles.getheightofPercentage(context, 5),
                                                child: ListTile(
                                                  title: GestureDetector(
                                                      onTap: (){
                                                        setState(() {
                                                          _handleRadioValueChange(2);
                                                        });
                                                      },
                                                      child: Text('On Duty',style: const TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))),
                                                  leading: Radio<int>(
                                                    activeColor: Theme.of(context).primaryColor,
                                                    value: 2,
                                                    groupValue: punchInController.selectedRadio.value,
                                                    onChanged: _handleRadioValueChange,
                                                  ),
                                                )),
                                          ),
                                      ),
                                      SizedBox( height: BaseUtitiles.getheightofPercentage(context, 3),),

                                      FadeAnimation(
                                        1.5, Padding(
                                        padding: EdgeInsets.only(bottom: 16.r,left: 16.r,right: 16.r),
                                        child: PunchButtonWidget(
                                          maxHeight: 40.h,
                                          maxWidth: 150.w,
                                          color: Theme.of(context).primaryColor,
                                          title:
                                          Obx(()=>
                                              Text(
                                                punchInController.resPunchSts.value=="true" ?"Punch Out":"Punch In",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                          ),
                                          onTap: () async {

                                            if(punchInController.selectedRadio.value==1){
                                              await punchInController.getOndutyPunchInSts();

                                              if(punchInController.isOnDuty.value==1 || punchInController.resPunchSts.value=="true" ) {
                                                punchIn = false;
                                                await siteLocationController.getProjectName();
                                                Get.to(()=> const SiteLocationView());
                                              }else{
                                                punchIn = true;
                                                await siteLocationController.getProjectName();
                                                Get.to(()=> const SiteLocationView());
                                              }
                                            }
                                            else if(punchInController.selectedRadio.value==2){
                                              await punchInController.getOndutyPunchInSts();

                                              if (punchInController.resPunchSts.value=="false" && punchInController.isOnDuty.value==0 ) {
                                                setState(() {
                                                  punchInController.isOnDuty.value=1;
                                                  punchInController.update();
                                                });
                                                await Get.to(()=>PunchIn(
                                                    latitude: "",
                                                    longitude: "",
                                                    radius: ""));
                                              }
                                              // else if(punchInController.onDutyStatus.value=="Y" ){
                                              else{
                                                setState(() {
                                                  punchInController.isOnDuty.value=1;
                                                  punchInController.update();
                                                });
                                                await Get.to(()=>PunchOut(
                                                    latitude: "",
                                                    longitude: "",
                                                    radius: ""));
                                              }
                                              // else{
                                              //   BaseUtitiles.showToast("Your PunchIn details not approved by HR, Please contact your HR");
                                              // }
                                            }
                                            else{
                                              BaseUtitiles.showToast("Please select any one");
                                            }
                                          },
                                        ),
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 150),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
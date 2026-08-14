import 'package:mcr/controller/site_location_controller.dart';
import 'package:mcr/home/dashboard/site_locations_view.dart';
import 'package:mcr/home/menu/main_menu/workOrder_Direct/workOrder_Direct_Entrylist.dart';
import 'package:mcr/home/punch_in_out/punch_in.dart';
import 'package:mcr/utilities/baseutitiles.dart';
import 'package:mcr/utilities/print_logger.dart';
import '../controller/preapproval_controller.dart';
import '../controller/billgenerationdirect_controller.dart';
import '../controller/cashbook_site_controller.dart';
import '../controller/dailyentries_controller.dart';
import '../controller/dailywrk_done_dpr_controller.dart';
import '../controller/dailywrk_done_dprlabour_controller.dart';
import '../controller/dailywrk_done_dprnew_controller.dart';
import '../controller/inward_pending_controller.dart';
import '../controller/logincontroller.dart';
import '../controller/sitevoucher_controller.dart';
import '../controller/staffvoucher_controller.dart';
import '../controller/transferbw_project_controller.dart';
import '../controller/transferbw_site_controller.dart';
import '../home/menu/accounts/cash_book_site/casebook_site_new.dart';
import '../home/menu/accounts/cash_book_staff/case_book_staff.dart';
import '../home/menu/accounts/site_voucher/site_voucher_new/site_voucher_entrylist_new.dart';
import '../home/menu/accounts/staff_voucher/staff_voucher_entrylist.dart';
import '../home/menu/daily_entries/advancereques_voucher_new/advance_req_entrylist_new.dart';
import '../home/menu/daily_entries/bill_generation/bill_generation_boq_entrylist.dart';
import '../home/menu/daily_entries/bill_generation_direct/bill_generation_entrylist.dart';
import '../home/menu/daily_entries/company_nmr_attendance/company_nmr_main.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(labour)/daily_wrkdone_dpr_labour.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr(new)/daily_wrkdone_dpr_entrylistnew.dart';
import '../home/menu/daily_entries/daily_wrk_done_dpr/daily_wrkdone_dpr_entrylist.dart';
import '../home/menu/daily_entries/pre_approval/preapproval_main.dart';
import '../home/menu/daily_entries/subcont_nmr_weekbill_site/subcont_nmr_entrylist_site.dart';
import '../home/menu/daily_entries/subcontractor_attendance_site/subattendance_site_entry_list.dart';
import '../home/menu/main_menu/boq_revised/boq_revised_entrylist.dart';
import '../home/menu/materials/consumption/consumption_list.dart';
import '../home/menu/materials/inward/inward_list.dart';
import '../home/menu/materials/mrn_request(indent)/mrnrequest_list.dart';
import '../home/menu/materials/transfer_between_projects/transferbetween_projects_list.dart';
import '../home/menu/materials/transfer_between_sites/transferbetween_sites_list.dart';
import '../models/home_menulistres_model.dart';
import '../provider/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'advance_reqvoucher_new_controller.dart';
import 'boqrevised_controller.dart';
import 'company_nmr_controller.dart';
import 'consumption_controller.dart';
import 'mrn_request_indent_controller.dart';
import 'nmrweeklybill_controller.dart';


class Menu_Controller extends GetxController {
  LoginController loginController = Get.put(LoginController());
  DailyEntriesController dailyEntriesController=Get.put(DailyEntriesController());
  NMRWklyController nmrWklyController = Get.put(NMRWklyController());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());
  DailyWrkDone_DPRLabour_Controller dailyWrkDone_DPRLabour_Controller=Get.put(DailyWrkDone_DPRLabour_Controller());
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller = Get.put(DailyWrkDone_DPR_Controller());
  BillGenerationDirectController billGenerationDirectController=Get.put(BillGenerationDirectController());
  TransferBW_project_Controller transferBW_project_Controller=Get.put(TransferBW_project_Controller());
  TransferBt_Site_Controller transferBt_Site_Controller=Get.put(TransferBt_Site_Controller());
  // AdvanceReqVoucherController advanceReqVoucherController=Get.put(AdvanceReqVoucherController());
  AdvanceReqVoucherController_new advanceReqVoucherController_new =Get.put(AdvanceReqVoucherController_new());
  SiteVoucher_Controller siteVoucher_Controller=Get.put(SiteVoucher_Controller());
  StaffVoucher_Controller staffVoucher_Controller=Get.put(StaffVoucher_Controller());
  MRN_Request_Controller mrn_request_controller=Get.put(MRN_Request_Controller());
  Consumption_Controller consumption_controller=Get.put(Consumption_Controller());
  Boq_Revised_Controller boq_revised_controller=Get.put(Boq_Revised_Controller());
  InwardPending_Controller inward_controller = Get.put(InwardPending_Controller());
  CashBookSiteController cashBookSiteController=Get.put(CashBookSiteController());
  CompanyNmrAttendanceController companyNmrAttendanceController = Get.put(CompanyNmrAttendanceController());
  PreApprovalController preApprovalController=Get.put(PreApprovalController());
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  RxList menuListDatas = [].obs;

  RxString formName = "".obs;
  var subMenueDatas = new SubMenu();
  List<SubMenu> submenuListName = [];

  List subMatList = [];
  List subMainmenuList = [];
  List dailyEntryList = [];
  List accountsList = [];

  Future getMenuList() async {
    printToLog("User Id :: ${loginController.user.value.userId}");
    await MenuProvider.getMenuListProvider(loginController.user.value.userId!).then((value)  {
      if (value != null && value.length > 0) {
        menuListDatas.value = value;
        value.forEach((element) {
          if(element.headName=="Materials"){
            subMatList.clear();
            element.subMenu!.forEach((value) {
              subMatList.add( value.subName);
            });
          }
          if(element.headName=="Main Menu"){
            subMainmenuList.clear();
            element.subMenu!.forEach((value) {
              subMainmenuList.add( value.subName);
            });
          }
          if(element.headName=="Daily Entries"){
            dailyEntryList.clear();
            element.subMenu!.forEach((value) {
              dailyEntryList.add( value.subName);
            });
          }
          if(element.headName=="Accounts"){
            accountsList.clear();
            element.subMenu!.forEach((value) {
              accountsList.add( value.subName);
            });
          }
        });
        return menuListDatas.value;
      }
      return menuListDatas.value;
    });
  }



 MaterialScreen(String value, BuildContext context) {
    if (value == "MRN Request (Indent)") {
      mrn_request_controller.editCheck = 0;
      mrn_request_controller.entrycheck = 0;
      mrn_request_controller.screenCheck ="Direct";
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MRN_RequestIndent_Entrylist()));
    } else if (value == "Inward") {
      inward_controller.entryvalue=0;
      inward_controller.editvalue=0;
      inward_controller.inwardAllDatasList.value.clear();
      inward_controller.itemlistTable_Delete();
      inward_controller.ItemGetTableListdata.value.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Inward_ListScreen()));
    } else if (value == "Transfer Between Projects") {
      transferBW_project_Controller.type.value="Direct";
      transferBW_project_Controller.entrycheck=0;
      transferBW_project_Controller.editcheck=0;
      transferBW_project_Controller.itemlistTable_Delete();
      transferBW_project_Controller.ItemGetTableListdata.value.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const TransferBtweenProjects_Entrylist()));
    } else if (value == "Transfer Between Sites") {
      transferBt_Site_Controller.entrycheck=0;
      transferBt_Site_Controller.editcheck=0;
      transferBt_Site_Controller.itemlistTable_Delete();
      transferBt_Site_Controller.ItemGetTableListdata.value.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const TransferBetweenSites_Entrylist()));
    }

    else if (value == "Consumption") {
      consumption_controller.editCheck = 0;
      consumption_controller.itemCheck=0;
      consumption_controller.submitCheck = 0;
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Consumption_List()));
    }
  }

  NavigateScreen(String value, BuildContext context) async {
    if (value == "SubContractor Attendance") {
      dailyEntriesController.editcheck=0;
      dailyEntriesController.entrycheck=0;
      dailyEntriesController.deleteSubcontDetTableDatas();
      dailyEntriesController.readListdata.value.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SubAttendanceSiteEntryList()));
    }
    else if(value=="Company NMR Attendance"){
      companyNmrAttendanceController.entrycheck=0;
      companyNmrAttendanceController.edicheck=0;

      Navigator.push(context, MaterialPageRoute(builder: (context) =>  CompanyNmrMain(0)));
    }

    else if (value == "SubCont NMR Wkly Bill - Generation") {
      nmrWklyController.NmritemList.value.clear();
      Navigator.push(
        context, MaterialPageRoute(
            builder: (context) => Subcont_NMR_EntryListScreen_Site()),
      );
    } else if (value == "Daily Work Done (DPR)") {
      dailyWrkDone_DPR_Controller.editCheck = 0;
      dailyWrkDone_DPR_Controller.entrycheck = 0;
      dailyWrkDone_DPR_Controller.addwrkCheck = 0;
      dailyWrkDone_DPR_Controller.screenchek.value=0;
      dailyWrkDone_DPR_Controller.dpr_itemview_DbList.value.clear();
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => DailyWork_done_DPR_EntryList()),
      );
    } else if (value == "Daily Work Done (DPR New)") {
        dailyWrkDone_DPRNEW_Controller. entrycheck=0;
        dailyWrkDone_DPRNEW_Controller.editcheck=0;
        dailyWrkDone_DPRNEW_Controller.check=0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DailyWork_done_DPR_EntryListNew()),
      );
    }

    else if (value == "Daily Work Done (DPR Labour)") {
      dailyWrkDone_DPRLabour_Controller.screencheck=0;
      dailyWrkDone_DPRLabour_Controller.editCheck=0;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DailyWrk_Done_DPR_Labour(0)),
      );
    }


    else if (value == "Bill Generation - Direct") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bill_Generation_direct_Entrylist()),
      );
    } else if (value == "Bill Generation") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bill_Generation_Boq_Entrylist()),
      );
    } else if (value == "Requisition Voucher") {
      advanceReqVoucherController_new.itemlistTable_Delete();
      advanceReqVoucherController_new.ItemGetTableListdata.value.clear();
      advanceReqVoucherController_new.delete_ListTable();
      advanceReqVoucherController_new. GetTableList.value.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => AdvReq_Voucher_EntryList_new()),
      );
    }
    else if (value == "Pre Approval") {
      preApprovalController.entrycheck=0;
      preApprovalController.editcheck=0;
      preApprovalController.pendingcheck=0;
      Navigator.push(context, MaterialPageRoute(builder: (context) => PreapprovalMain(0)),
      );
    }
  }

  AccountsScreen(String value, BuildContext context) {
    if (value == "Site Voucher") {
      siteVoucher_Controller.editcheck=0;
      siteVoucher_Controller.itemcheck=0;
      siteVoucher_Controller.Active=0;
      siteVoucher_Controller.Amount.text="0.00";
      siteVoucher_Controller.type.value="Direct Payment/Office";
      siteVoucher_Controller.delete_Sitevoucher_itemlist_Table();
      siteVoucher_Controller.Sitevoucher_itemview_GetDbList.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SiteVoucher_EntryListNew()));
    } else if (value == "Staff Voucher") {
      staffVoucher_Controller.TotalAmount.text = "0.00";
      staffVoucher_Controller.editcheck = 0;
      staffVoucher_Controller.itemcheck = 0;
      staffVoucher_Controller.Active = 0;
      staffVoucher_Controller.type.value = "SiteWise Payment";
      staffVoucher_Controller.delete_Sitevoucher_itemlist_Table();
      staffVoucher_Controller.Sitevoucher_itemview_GetDbList.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Staff_Voucher_EntryListScreen()));
    } else if (value == "Cash Book/Staff") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Case_Book_Staff()));
    }
    else if (value == "Cash Book/Site") {
      cashBookSiteController.cashsiteDatas.value.clear();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CashBook_Site()),
      );
    }
  }

  MainmenuScreen(String value, BuildContext context) {
    if (value == "BOQ - Revised") {
      boq_revised_controller.editCheck = 0;
      boq_revised_controller.itemCheck = 0;
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Boq_Revised_EntryList()));
    }
    else if(value == "Work Order - Direct"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkOrderDirectEntrylist()));
    }
  }
}

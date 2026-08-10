class ApiConstant{

  static const String LIVE_ENDPOINT = "http://49.204.233.151/";     //local

  // static const String LIVE_ENDPOINT = "http://103.99.148.61/";      // old ip

  // static const String LIVE_ENDPOINT = "http://103.186.220.133/";      // new ip


  static const String BASE_URL = LIVE_ENDPOINT + "MCRTESTAPI/";     //local

  // static const String BASE_URL = LIVE_ENDPOINT + "MCRAPI/";

  static const String Web_URL = LIVE_ENDPOINT + "MCR/";


  /// ---- Get API's ----

  static const String DASHBOARD_API = BASE_URL + "api/CommonFile/GetDashboard";
  static const String AUTHENTICATION = BASE_URL + "api/CommonFile/GetUserDetails";
  static const String PENDINGLISTAPI = BASE_URL + "api/CommonFile/GetPendingList";
  static const String GETMRNFINALAPROVALAPI = BASE_URL + "api/MaterialRequest/GetAppList";
  static const String GETMRPREAPROVALAPI = BASE_URL + "api/MaterialRequest/GetPreAppList";
  static const String GETVERSIONAPI = BASE_URL + "api/CommonFile/GetVersion";
  static const String GETPROJECTDROPDOWNLISTALL = BASE_URL + "api/CommonFile/GetProjectAll";
  static const String GETPROJECTDROPDOWNLIST = BASE_URL + "api/CommonFile/GetProject";
  static const String GETNMRBILLNO = BASE_URL + "api/SubcontNMR/GetProjectCumContractorNo";
  static const String PROJECT_NAME = BASE_URL + "api/CommonFile/Get_MRNProjectsToTransfer";
  static const String GETPROJECTCOMPANYWISE_DROPDOWNLIST = BASE_URL + "api/CommonFile/GetProjectCompwise";
  static const String GET_HEAD_DROPDOWNLIST = BASE_URL + "api/SubContDPRNew/GetHeadname";
  static const String GETSUBCONTRACTDROPDOWNLIST = BASE_URL + "api/CommonFile/GetSubContractorAll";
  static const String GETSUBCONTRACTBILLDIRLIST = BASE_URL + "api/SubContDirectBill/GetSubcontList";
  static const String GETSUBCONTRACTLIST = BASE_URL + "api/CommonFile/GetSubContractor";
  static const String GETNMRREPORT = BASE_URL + "api/Report/GetNmrReportMas";
  static const String GETLABOURLIST = BASE_URL + "api/CommonFile/GetLabour";
  static const String GETATTENDANCEREPORTLIST = BASE_URL + "api/Report/GetAttendanceReportMas";
  static const String ATTENDANCEONITEMSELCT = BASE_URL + "api/Report/GetAttendanceReportDet";
  static const String SITEDROPDWONLISTAPI = BASE_URL + "api/CommonFile/GetSite";
  static const String GETMRNREPORTSLISTAPI = BASE_URL + "api/Report/GetMrnReportMas";
  static const String GETINWARDREPORTSLISTAPI = BASE_URL + "api/Report/GetInwardReportMas";
  static const String GETSUPPLIERDROPDOWNAPI = BASE_URL + "api/CommonFile/GetSupplier";
  static const String GETDPRLISTAPI = BASE_URL + "api/Report/GetDPRReportMas";
  static const String GETCOMPANYDROPDOWNLIST = BASE_URL + "api/CommonFile/GetCompany";
  static const String GETCOMPANYALL_DROPDOWNLIST = BASE_URL + "api/CommonFile/GetCompanyAll";
  static const String GETPROJECTEXPENSESAPI = BASE_URL + "api/CommonFile/GetProjectExpenses";
  static const String GETSUPPLIEROSEXPENSESAPI = BASE_URL + "api/CommonFile/GetSupplierExpenses";
  static const String GETSUBCONTRACTOREXPENSESAPI = BASE_URL + "api/CommonFile/GetSubConExpenses";
  static const String GETONCLICK_PENDINGLISTAPI = BASE_URL + "api/CommonFile/GetPendingRecords";
  static const String MRNONITEMSELCT = BASE_URL + "api/Report/GetMrnReportDet";
  static const String INWARDONITEMSELCT = BASE_URL + "api/Report/GetInwardReportDet";
  static const String DPRONITEMSELCT = BASE_URL + "api/Report/GetDPRReportDet";
  static const String GETMATERIALSUBDRPDOWNLIST = BASE_URL + "api/CommonFile/GetMaterialSub";
  static const String GETREQTRACKERLISTAPI = BASE_URL + "api/Report/GetRequestTracker";
  static const String GETMATERIAL_SHOW_LIST = BASE_URL + "api/Report/GetStockReport";
  static const String GETMATERIAL_DETAILS_LIST = BASE_URL + "api/Report/GetStockDetail";
  static const String GETMATERIAL_SUBHAED_DROPDOWNLIST = BASE_URL + "api/CommonFile/GetMaterialHead";
  static const String GETMATERIALWISEDROPDOWNLIST = BASE_URL + "api/CommonFile/GetMaterialSubAll";
  static const String GETMATERIALWISE_SHOW_LIST = BASE_URL + "api/Report/GetStockAbstract";
  static const String GETSUBCONT_ENTRY_SHOW_CLICK = BASE_URL + "api/CommonFile/GetSubContCategory";
  static const String GETINVOICENOLIST = BASE_URL + "api/SubContDirectBill/GetinvoiceNo";
  static const String GETAUTONO_YEAR_WISE = BASE_URL + "api/CommonFile/GetAutoNoYearWise";
  static const String GETSUBCONT_ATTEN_ENTRY_LIST = BASE_URL + "api/SubContLabAttendance/GetAttendanceEntryList";
  static const String GETMENU_LIST_API = BASE_URL + "api/CommonFile/GetMenusList";
  static const String GETCONTROLL_RIGHTS_ENTRYLIST = BASE_URL + "api/CommonFile/GetControlRights";
  static const String EDIT_SUBCONT_ENTRYLIST_API = BASE_URL + "api/SubContLabAttendance/GetAttendanceById";
  static const String GETSUBCONT_NMR_ENTRY_LIST = BASE_URL + "api/SubcontNMR/GetNMRWklyBillEntryList";
  static const String GETSUBCONT_NMR_ITEM_LIST = BASE_URL + "api/SubcontNMR/GETNMRWklyBill";
  static const String GETSUBCONT_NMR_CHECKSTATUS = BASE_URL + "api/SubcontNMR/GetNMRDetails";
  static const String GETSUBCONT_NMR_COUNT_CHECKSTATUS = BASE_URL + "api/SubcontNMR/GetNMRCount";
  static const String GETSUBCONT_NMR_ADVANCE_BALANCE = BASE_URL + "api/SubcontNMR/GetSubContNMRAdvBalance";
  static const String EDIT_NMR_DEDUCTION = BASE_URL + "api/SubcontNMR/GetNMRBillId";
  static const String GET_DPR_ENTRY_LIST = BASE_URL + "api/SubContDPR/GetDPREntryList";
  static const String GET_DPR_SUBCONTRACTOR_LIST = BASE_URL + "api/SubContDPR/GetSubContractorsList";
  static const String GET_DPR_ITEM_LIST = BASE_URL + "api/SubContDPR/GetItemsList";
  static const String GET_DPR_EDIT_API = BASE_URL + "api/SubContDPR/GetDprById";
  static const String GET_DPRNEW_MATERIAL_API = BASE_URL + "api/CommonFile/GetMaterial";
  static const String GET_DPR_NEW_ENTRY_LIST = BASE_URL + "api/SubContDPRNew/GetDPREntryList";
  static const String GET_DPRNEW_BOQDETAILSLIST = BASE_URL + "api/SubContDPRNew/GetItemsList";
  static const String GET_DPRNEW_EDIT_API = BASE_URL + "api/SubContDPRNew/GetDprById";
  static const String GET_DPR_LABOUR_ENTRY_LIST = BASE_URL + "api/SubContDPRNewLabour/GetDPREntryList";
  static const String GET_DPR_LABOUR_EDIT_API = BASE_URL + "api/SubContDPRNewLabour/GetDprById";
  static const String GET_DIRECTBILL_ADVANCE_BALANCE = BASE_URL + "api/Commonfile/GetSubContAdvBalance";
  static const String GET_DIRECTBILL_ENTRY_LIST = BASE_URL + "api/SubContDirectBill/GetDirectBillEntryList";
  static const String GET_WORKORD_DIRECT_ENTRY_LIST = BASE_URL + "api/SubcontractWorkOrderDirect/GetWorkOrderDirectList";
  static const String GET_DIRECTBILL_CALCULATION_LIST = BASE_URL + "api/CommonFile/GetAddlessList";


  static const String EDIT_DIRECTBILL_API = BASE_URL + "api/SubContDirectBill/GetDirectBillById";
  static const String EDIT_WORKORD_DIRECT_API = BASE_URL + "api/SubcontractWorkOrderDirect/GetDirectWorkOrder";

  static const String EDIT_INWARDPENDING_API = BASE_URL + "api/MaterialInward/GetInwardById";
  static const String EDIT_TRANSFERBET_API = BASE_URL + "api/MaterialTransferProject/GetTransferById";
  static const String EDIT_TRANSFERBET_SITE_API = BASE_URL + "api/MaterialTransferS2S/GetTransferById";
  static const String EDIT_ADVANCEREQ_API = BASE_URL + "api/AdvRequisitionVoucher/GetVoucherProjectById";
  static const String EDIT_TRANSFER_ACKNOW_API = BASE_URL + "api/MaterialTransferAck/GetTransferAckById";
  static const String GETINWARD_ENTRY_LIST = BASE_URL + "api/MaterialInward/GetInwardEntryList";
  static const String GETMATERIALINWARD_ALLDATAS = BASE_URL + "api/MaterialInward/GetPOById";
  static const String GETTRANSPROJECT_ENTRY_LIST = BASE_URL + "api/MaterialTransferProject/GetTransferEntryList";
  static const String GETFROMPROJECTDROPDOWNLIST = BASE_URL + "api/MaterialTransferProject/GetFromProject";
  static const String GETTRANSALLDATASLIST = BASE_URL + "api/MaterialTransferProject/GetReqById";
  static const String GETTRANSITEMLIST = BASE_URL + "api/MaterialTransferProject/GetMaterialList";
  static const String GET_TRANSBETSITE_ENTRYLIST = BASE_URL + "api/MaterialTransferS2S/GetTransferEntryList";
  static const String GETCASHBOOK_SITE = BASE_URL + "api/Report/GetCashBookSite";
  static const String GETCASHBOOK_STAFF = BASE_URL + "api/Report/GetCashBookStaff";
  static const String GETACCOUNTTYPEDROPDOWNLIST = BASE_URL + "api/CommonFile/GetAccType";
  static const String GETACCOUNTTYPEDROPDOWNLISTADVREQ = BASE_URL + "api/CommonFile/GetAccTypeAdvReq";
  static const String GetADVREQ_SITEWIEPAYMENTLIST = BASE_URL + "api/AdvRequisitionVoucher/GetAdvreq_sitewisePayment";
  static const String GETPAYMODEDROPDOWNLIST = BASE_URL + "api/CommonFile/GetPayMode";
  static const String GETPAYFORDROPDOWNLIST = BASE_URL + "api/CommonFile/GetPayFor";
  static const String ACCOUNTNAMEDROPDWONLISTAPI = BASE_URL + "api/CommonFile/GetAccName";
  static const String STAFFDROPDWONLISTAPI = BASE_URL + "api/CommonFile/GetStaffName";
  static const String GET_ADVREQ_ENTRY_LIST = BASE_URL + "api/AdvRequisitionVoucher/GetVoucherProjectEntryList";
  static const String GETSITEVOC_ENTRY_LIST = BASE_URL + "api/VoucherProject/GetVoucherProjectEntryList";
  static const String GETSTAFFVOC_ENTRY_LIST = BASE_URL + "api/VoucherStaff/GetVoucherStaffEntryList";
  static const String GET_SITEVOUCHER_EDIT_API = BASE_URL + "api/VoucherProject/GetVoucherProjectById";
  static const String GET_STAFFVOUCHERSITE_EDIT_API = BASE_URL + "api/VoucherStaff/GetVoucherStaffById";
  static const String GET_STAFFVOUCHER_BankNAMELIST_API = BASE_URL + "api/commonfile/GetBankName";
  static const String GETMRNREQUEST_ENTRY_LIST = BASE_URL + "api/MaterialRequest/GetRequestEntryList";
  static const String GET_MATERIAL_EDIT_API = BASE_URL + "api/MaterialRequest/GetRequestById";
  static const String GET_COMPANY_NMRALLLISTAPI = BASE_URL + "api/CommonFile/GetLabourById";
  static const String GETMATERIALREQUESTTYPE = BASE_URL + "api/commonfile/Get_Material_Item_ReqType";
  static const String GETMATERIALLIST = BASE_URL + "api/CommonFile/GetMaterialAll";
  static const String GETCONSUMPTION_ENTRY_LIST = BASE_URL + "api/MaterialUsage/GetUsageEntryList";
  static const String GETSTOCKMATERIALLIST = BASE_URL + "api/CommonFile/GetStockMaterial";
  static const String GETSTOCkLISTMATERIALWISE = BASE_URL + "api/CommonFile/GetStockListMaterialWise";
  static const String GET_MRNREQ_ADD_QTY = BASE_URL + "api/CommonFile/GetScale";
  static const String GET_CONSUM_EDIT_API = BASE_URL + "api/MaterialUsage/GetUsageById";
  static const String GET_BOQ_ENTRY_LIST = BASE_URL + "api/BOQRevised/GetBOQRevisedEntryList";
  static const String GETREVISEDITEMLIST = BASE_URL + "api/BOQRevised/GetItemsList";
  static const String GET_BOQREVISED_EDIT_API = BASE_URL + "api/BOQRevised/GetBOQRevisedById";
  static const String GETREQUISITIONSLIP_ENTRY_LIST = BASE_URL + "api/HR/GetRequisitionEntryList";
  static const String GET_REQUISITION_EDIT_API = BASE_URL + "api/HR/GetRequisitionById";
  static const String GET_TRAACK_PENDING_ALLDATAS_API = BASE_URL + "api/MaterialTransferAck/GetTransferById";
  static const String GET_TRAACK_ENTYLIST_API = BASE_URL + "api/MaterialTransferAck/GetTransferAckEntryList";
  static const String GETONCLICK_PENDINGLISTDetAPI = BASE_URL + "api/CommonFile/GetPendingRecordsItemsList";
  static const String GET_COMPANY_NMRENTRYLISTAPI = BASE_URL + "api/CompanyLabAttendance/GetAttendanceEntryList";
  static const String GET_COMPANY_NMRLISTEDIT_API = BASE_URL + "api/CompanyLabAttendance/GetAttendanceById";
  static const String GET_PREAPPROVALENTRYLIST_API = BASE_URL + "api/PreApproval/GetPreApprovalEntryList";
  static const String GET_PREAPPROVALTYPELIST_API = BASE_URL + "api/CommonFile/GetPreApprovalType";
  static const String GET_PREAPPROVAL_EDIT_API = BASE_URL + "api/PreApproval/GetPreApprovalById";
  static const String GET_POAPPROVAL_SUPPLIERBUILDLIST_API = BASE_URL + "api/commonfile/GetBilledList";
  static const String GET_POAMENDMENT_LIST = BASE_URL + "api/MaterialInward/Getapp_amdList";
  static const String GET_TRANSFERACKPENDING_LIST = BASE_URL + "api/MaterialTransferAck/GetMatTransAckMaterialList";
  static const String GET_PUNCHIN_STATUS = BASE_URL + "api/StaffPunching/GetPunchStatus";
  static const String TODAY_PUNCHIN_STATUS = BASE_URL + "api/StaffPunching/GetPunchInandOutTodayWiseReports";
  static const String PUNCH_FILTER_STATUS = BASE_URL + "api/StaffPunching/GetPunchInandOutReports";

  /// ---Reports---

  static const String GETPROJECT_REPORTS = BASE_URL + "api/CommonFile/GetProjectReport";
  static const String GETSITE_REPORTS = BASE_URL + "api/CommonFile/GetSiteReport";
  static const String GETSUPPLIER_REPORTS = BASE_URL + "api/CommonFile/GetSupplierReport";
  static const String GETSUBCONTACTOR_REPORTS = BASE_URL + "api/CommonFile/GetSubContractorReport";
  // static const String GET_SITE_LOCATION = BASE_URL + "api/CommonFile/GetSite_PinAllocation";
  // static const String GET_SITE_LOCATION = BASE_URL + "api/commonfile/GetSite_PinAllocationStatus";
  static const String GET_SITE_LOCATION = BASE_URL + "api/StaffPunching/GetPinProjectList";
  static const String GET_IMAGE_LIST = BASE_URL + "api/image/GetInwardImageList";
  static const String GET_VOC_IMAGE_LIST = BASE_URL + "api/Image/GetSiteVoucherImageList";
  static const String GET_ATTEN_IMAGE_LIST = BASE_URL + "api/Image/GetSubContAttImageList";
  static const String GET_DPR_IMAGE_LIST = BASE_URL + "api/image/GetDprImageList";


  /// ----- Put API's -----

  static const String PUTCHANGEPASSWORDAPI = BASE_URL + "api/CommonFile/PutChangePassword";
  static const String PUT_UPPDATE_API = BASE_URL + "api/SubContLabAttendance/PUTAttendanceUpdate";
  static const String PUT_APROVAL_API = BASE_URL + "api/SubContLabAttendance/PUTAttendanceApprove";
  static const String PUT_NMR_UPDATE_API = BASE_URL + "api/SubcontNMR/PUTNMRBillUpdate";
  static const String PUT_DPR_UPDATE_API = BASE_URL + "api/SubContDPR/PUTDprUpdate";
  static const String PUT_DPR_NEW_UPDATE_API = BASE_URL + "api/SubContDPRNew/PUTDprUpdate";
  static const String PUT_DPR_APROVE_API = BASE_URL + "api/SubContDPR/PUTDprApprove";
  static const String PUT_DPR_NEW_APROVE_API = BASE_URL + "api/SubContDPRNew/PUTDprApprove";
  static const String PUT_DPR_LABOUR_APROVE_API = BASE_URL + "api/SubContDPRNewLabour/PUTDprApprove";
  static const String PUT_DPR_LABOUR_UPDATE_API = BASE_URL + "api/SubContDPRNewLabour/PUTDprUpdate";
  static const String PUT_DIRECTBILL_UPDATE_API = BASE_URL + "api/SubContDirectBill/PUTDirectBillUpdate";
  static const String PUT_WORKORDER_UPDATE_API = BASE_URL + "api/SubcontractWorkOrderDirect/PUTWorkorderDirect";

  static const String PUT_SUBCONTNMRBILL_APPROVAL_API = BASE_URL + "api/SubcontNMR/PUTNMRApprove";
  static const String PUT_BILLGEN_APPROVAL_API = BASE_URL + "api/SubContDirectBill/PUTDirectBillApprove";
  static const String PUT_POAPPROVAL_API = BASE_URL + "api/CommonFile/PutPendingListApproval";
  static const String PUT_ADVANCEREQ_APPROVAL_API = BASE_URL + "api/AdvRequisitionVoucher/PUTAdvVoucherApprove";
  static const String PUT_INWARDPENDING_UPDATE_API = BASE_URL + "api/MaterialInward/PUTInwardUpdate";
  static const String PUT_TRANSFERBET_UPDATE_API = BASE_URL + "api/MaterialTransferProject/PUTTransferUpdate";
  static const String PUT_TRANSFERBET_SITE_UPDATE_API = BASE_URL + "api/MaterialTransferS2S/PUTTransferUpdate";
  static const String PUT_ADVREQ_UPDATE_API = BASE_URL + "api/AdvRequisitionVoucher/PUTVoucherProjectUpdate";
  static const String PUT_SITEVOUCHER_UPDATE_API = BASE_URL + "api/VoucherProject/PUTVoucherProjectUpdate";
  static const String PUT_STAFFVOUCHER_UPDATE_API = BASE_URL + "api/VoucherStaff/PUTVoucherStaffUpdate";
  static const String PUT_MATERIALREQUEST_UPDATE_API = BASE_URL + "api/MaterialRequest/PUTRequestUpdate";
  static const String PUT_MATERIALREQUEST_PREAPPR_API = BASE_URL + "api/MaterialRequest/PUTRequestPreApprove";
  static const String PUT_MATERIALREQUEST_APPROVAL_API = BASE_URL + "api/MaterialRequest/PUTRequestApproval";
  static const String PUT_COMPANYNMR_UPDATE_API = BASE_URL + "api/CompanyLabAttendance/PUTAttendanceUpdate";
  static const String PUT_COMPANYNMR_APPROVAL_API = BASE_URL + "api/CompanyLabAttendance/PUTAttendanceApprove";
  static const String PUT_Conum_UPDATE_API = BASE_URL + "api/MaterialUsage/PUTUsageUpdate";
  static const String PUT_BOQREVISED_UPDATE_API = BASE_URL + "api/BOQRevised/PUTBOQRevisedUpdate";
  static const String PUT_REQUISITIONSLIP_UPDATE_API = BASE_URL + "api/HR/PUTRequisitionUpdate";
  static const String PUT_TRANSFERACKNOW_UPDATE_API = BASE_URL + "api/MaterialTransferAck/PUTTransferAckUpdate";
  static const String PUT_ACCOUNTNAME_UPDATE_API = BASE_URL + "api/CommonFile/PUTAccountNameUpdate";
  static const String PUT_PREAPPROVAL_UPDATE_API = BASE_URL + "api/PreApproval/PUTPreApprovalUpdate";
  static const String PUT_PREAPPROVAL_APPROVE_API = BASE_URL + "api/PreApproval/PUTPreApprovalApprove";
  static const String PUT_MRNFINALAPPROVAL_APPROVE_API = BASE_URL + "api/MaterialRequest/PUTRequestApproval";
  // static const String PUNCH_OUT = BASE_URL + "api/StaffPunching/PUTStaffPunchOutUpdate";
  static const String PUNCH_OUT = BASE_URL + "api/StaffPunching/PutPunchOutUploadStaffImageSave";


  /// ----- POST API's -----

  static const String POST_PREAPPROVAL_SAVE_API = BASE_URL + "api/PreApproval/POSTPreApprovalSave";
  static const String SUBCONTLABATTAENDANCE_SAVE_API = BASE_URL + "api/SubContLabAttendance/POSTAttendanceSave";
  static const String SUBCONTLABATTAENDANCE_SAVE_SITE_API = BASE_URL + "api/SubContLabAttendance/POSTAttendanceSavesite";
  static const String NMR_SAVE_DEDUCTION = BASE_URL + "api/SubcontNMR/POSTNMRBillSave";
  static const String DPR_SAVE_API = BASE_URL + "api/SubContDPR/POSTDprSave";
  static const String DPR_NEW_SAVE_API = BASE_URL + "api/SubContDPRNew/POSTDprSave";
  static const String DPR_LABOUR_SAVE_API = BASE_URL + "api/SubContDPRNewLabour/POSTDprSave";
  static const String DIRECTBILL_SAVE_API = BASE_URL + "api/SubContDirectBill/POSTDirectBillSave";
  static const String WORKORD_DIRECT_SAVE_API = BASE_URL + "api/SubcontractWorkOrderDirect/POSTWorkorderDirect";

  static const String INWARDPENDING_SAVE_API = BASE_URL + "api/MaterialInward/POSTInwardSave";
  static const String TRANSFERBET_SAVE_API = BASE_URL + "api/MaterialTransferProject/POSTTransferSave";
  static const String TRANSFERBET_SITE_SAVE_API = BASE_URL + "api/MaterialTransferS2S/POSTTransferSave";
  static const String TOKEN_SAVE = BASE_URL + "api/CommonFile/POSTUserTokenflutter";
  static const String ADVREQ_SAVE = BASE_URL + "api/AdvRequisitionVoucher/POSTVoucherProjectSave";
  static const String TRANSFER_ACKNOW_ENTRYSAVE = BASE_URL + "api/MaterialTransferAck/POSTTransferAckSave";
  static const String SITEVOUCHER_SAVE = BASE_URL + "api/VoucherProject/POSTVoucherProjectSave";
  static const String STAFFVOUCHER_SAVE = BASE_URL + "api/VoucherStaff/POSTVoucherStaffSave";
  static const String MATERIALREQUEST_SAVE = BASE_URL + "api/MaterialRequest/POSTRequestSave";
  static const String COMPANY_NMR_SAVE_API = BASE_URL + "api/CompanyLabAttendance/POSTAttendanceSave";
  static const String CONSUM_SAVE = BASE_URL + "api/MaterialUsage/POSTUsageSave";
  static const String BOQREVISED_SAVE = BASE_URL + "api/BOQRevised/POSTBOQRevisedSave";
  static const String REQUISITION_SAVE = BASE_URL + "api/HR/POSTRequisitionSave";
  static const String ACCOUNTNAME_SAVE = BASE_URL + "api/CommonFile/POSTAccountNameSave";
  static const String POSTMATERIALSAVEAPI = BASE_URL + "api/CommonFile/POSTMaterial";
  static const String POST_MRNPREAPPROVAL_APPROVE_API = BASE_URL + "api/MaterialRequest/POSTRequestPreApprovalSave";
  static const String POAMENDMENT_APPROVAL_SAVEAPI = BASE_URL + "api/MaterialInward/POSTapp_amdSave";
  static const String PUNCH_IN = BASE_URL + "api/StaffPunching/PostPunchInUploadStaffImageSave";
  // static const String SET_SITE_LOCATION = BASE_URL + "api/CommonFile/PostSetSiteLocationSave";
  static const String SET_SITE_LOCATION = BASE_URL + "api/CommonFile/PostProjectLocationSave";
  static const String INWARDIMAGE_SAVEAPI = BASE_URL + "api/Image/PostInwardImageSave";
  static const String SITEVOCIMAGE_SAVEAPI = BASE_URL + "api/Image/PostSiteVoucherImageSave";
  static const String SUBIMAGE_SAVEAPI = BASE_URL + "api/Image/PostSubcontractorAttImageSave";

  /// ----- Delete API's -----

  static const String DELETE_SUBCONT_ENTRYLIST_API = BASE_URL + "api/SubContLabAttendance/DeleteAttendance";
  static const String DELETE_PREAPPROVAL_ENTRYLIST_API = BASE_URL + "api/PreApproval/DeletePreApproval";
  static const String DELETE_NMR_ENTRYLIST_API = BASE_URL + "api/SubcontNMR/DeleteNMRBill";
  static const String DELETE_DPR_ENTRYLIST_API = BASE_URL + "api/SubContDPR/DeleteDPR";
  static const String DELETE_DPRLABOUR_ENTRYLIST_API = BASE_URL + "api/SubContDPRNewLabour/DeleteDPR";
  static const String DELETE_DIRECTBILL_API = BASE_URL + "api/SubContDirectBill/DeleteDirectBill";
  static const String DELETE_WORKORDER_DIRECT_API = BASE_URL + "api/SubcontractWorkOrderDirect/DeleteWorkorder";

  static const String DELETE_INWARDPENDINGLIST_API = BASE_URL + "api/MaterialInward/DeleteInward";
  static const String DELETE_TRANSFERBET_API = BASE_URL + "api/MaterialTransferProject/DeleteTransfer";
  static const String DELETE_TRANSFERBET_SITE_API = BASE_URL + "api/MaterialTransferS2S/DeleteTransfer";
  static const String DELETE_ADVREQVOUCHER_API = BASE_URL + "api/AdvRequisitionVoucher/DeleteVoucherProject";
  static const String USERTOKENDELETE_API = BASE_URL + "api/CommonFile/DELETEUserToken";

  static const String DELETE_SITEVOUCHER_ENTRYLIST_API = BASE_URL + "api/VoucherProject/DeleteVoucherProject";
  static const String DELETE_STAFFVOUCHERSITE_ENTRYLIST_API = BASE_URL + "api/VoucherStaff/DeleteVoucherStaff";
  static const String DELETE_MATERIAL_ENTRYLIST_API = BASE_URL + "api/MaterialRequest/DeleteRequest";
  static const String DELETE_CONSUM_ENTRYLIST_API = BASE_URL + "api/MaterialUsage/DeleteUsage";
  static const String DELETE_BOQREVISED_ENTRYLIST_API = BASE_URL + "api/BOQRevised/DeleteBOQ";
  static const String DELETE_REQUISITION_ENTRYLIST_API = BASE_URL + "api/HR/DeleteRequisition";
  static const String DELETE_TRANSACKENTRYLIST_API = BASE_URL + "api/MaterialTransferAck/DeleteTransferAck";
  static const String DELETE_ACCOUNTNAME_API = BASE_URL + "api/CommonFile/DeleteAccountName";
  static const String DELETE_COMPANYNMRLIST_API = BASE_URL + "api/CompanyLabAttendance/DeleteAttendance";
  static const String DELETE_IMAGE_API = BASE_URL + "api/image/DeleteInwardImage";
  static const String SITE_VOC_IMAGE_DELETE = BASE_URL + "api/Image/DeleteSiteVoucherImage";
  static const String LABR_ATTEN_IMAGE_DELETE = BASE_URL + "api/Image/DeleteSubcontAttImage";
  static const String DPR_IMAGE_DELETE = BASE_URL + "api/Image/DeleteDprImage";

}
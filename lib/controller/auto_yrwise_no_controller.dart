import '../provider/common_provider.dart';
import 'package:get/get.dart';

class AutoYearWiseNoController extends GetxController {
  RxString SubcontAttendance_autoYrsWise = "".obs;
  RxString preapproval_autoYrsWise = "".obs;
  RxString NMR_autoYrsWise = "".obs;
  RxString DPRNEW_autoYrsWise = "".obs;
  RxString DPR_Labour_autoYrsWise = "".obs;
  RxString DPR_autoYrsWise = "".obs;
  RxString DirectBillautoYrsWise = "".obs;
  RxString InwardPendingautoYrsWise = "".obs;
  RxString TransferBetProjectautoYrsWise = "".obs;
  RxString TransferBetSiteautoYrsWise = "".obs;
  RxString AdvReqautoYrsWise = "".obs;
  RxString SiteVoucher_autoYrsWise = "".obs;
  RxString StaffVoucher_autoYrsWise = "".obs;
  RxString MRNIndent_autoYrsWise = "".obs;
  RxString companyNMR_autoYrsWise = "".obs;
  RxString Conum_autoYrsWise = "".obs;
  RxString BOQRevised_autoYrsWise = "".obs;
  RxString RequisitionSlip_autoYrsWise = "".obs;
  RxString WorkOrdDirect_autoYrWise = "".obs;

  Future AutoYearWise() async {
    await CommonProvider.subcontAttendance_getAutoYearWise().then((value){
      if (value != null) {
        SubcontAttendance_autoYrsWise.value = value;
        return SubcontAttendance_autoYrsWise.value;
      }
    });
  }
  Future PreApproval_AutoYearWise() async {
    await CommonProvider.preapproval_getAutoYearWise().then((value){
      if (value != null) {
        preapproval_autoYrsWise.value = value;
        return preapproval_autoYrsWise.value;
      }
    });
  }

  Future NMR_AutoYearWise() async {
    await CommonProvider.NMR_getAutoYearWise().then((value){
      if (value != null) {
        NMR_autoYrsWise.value = value;
        return NMR_autoYrsWise.value;
      }
    });
  }
  Future DPR_NEW_AutoYearWise() async {
    await CommonProvider.DPR_NEW_getAutoYearWise().then((value){
      if (value != null) {
        DPRNEW_autoYrsWise.value = value;
        return DPRNEW_autoYrsWise.value;
      }
    });
  }

  Future DPR_AutoYearWise() async {
    await CommonProvider.DPR_getAutoYearWise().then((value){
      if (value != null) {
        DPR_autoYrsWise.value = value;
        return DPR_autoYrsWise.value;
      }
    });
  }

  Future DPR_Labour_AutoYearWise() async {
    await CommonProvider.DPR_Labour_getAutoYearWise().then((value){
      if (value != null) {
        DPR_Labour_autoYrsWise.value = value;
        return DPR_Labour_autoYrsWise.value;
      }
    });
  }
  Future directBill_AutoYearWise() async {
    await CommonProvider.directBill_getAutoYearWise().then((value){
      if (value != null) {
        DirectBillautoYrsWise.value = value;
        return DirectBillautoYrsWise.value;
      }
    });
  }

  Future workOrderdirect_AutoYearWise() async {
    await CommonProvider.workOrderdirect_getAutoYearWise().then((value){
      if (value != null) {
        WorkOrdDirect_autoYrWise.value = value;
        return WorkOrdDirect_autoYrWise.value;
      }
    });
  }

  Future InwardPending_AutoYearWise() async {
    await CommonProvider.inwardPending_getAutoYearWise().then((value){
      if (value != null) {
        InwardPendingautoYrsWise.value = value;
        return InwardPendingautoYrsWise.value;
      }
    });
  }

  Future TransferBetProject_AutoYearWise() async {
    await CommonProvider.transfer_getAutoYearWise().then((value){
      if (value != null) {
        TransferBetProjectautoYrsWise.value = value;
        return TransferBetProjectautoYrsWise.value;
      }
    });
  }

  Future TransferBetSite_AutoYearWise() async {
    await CommonProvider.transferSite_getAutoYearWise().then((value){
      if (value != null) {
        TransferBetSiteautoYrsWise.value = value;
        return TransferBetSiteautoYrsWise.value;
      }
    });
  }

  Future ADVREQVoucher_AutoYearWise() async {
    await CommonProvider.advReqvoucher_getAutoYearWise().then((value){
      if (value != null) {
        AdvReqautoYrsWise.value = value;
        return AdvReqautoYrsWise.value;
      }
    });
  }

  Future SiteVoucherAutoYear() async {
    await CommonProvider.SiteVoucher_getAutoYearWise().then((value){
      if (value != null) {
        SiteVoucher_autoYrsWise.value = value;
        return SiteVoucher_autoYrsWise.value;
      }
    });
  }
  Future StaffVocAutoYear() async {
    await CommonProvider.StaffVoucher_getAutoYearWise().then((value){
      if (value != null) {
        StaffVoucher_autoYrsWise.value = value;
        return StaffVoucher_autoYrsWise.value;
      }
    });
  }
  Future MRNRequest_AutoYearWise() async {
    await CommonProvider.MRNIndent_getAutoYearWise().then((value){
      if (value != null) {
        MRNIndent_autoYrsWise.value = value;
        return MRNIndent_autoYrsWise.value;
      }
    });
  }

  Future CompanyNMR_AutoYearWise() async {
    await CommonProvider.companyNMR_getAutoYearWise().then((value){
      if (value != null) {
        companyNMR_autoYrsWise.value = value;
        return companyNMR_autoYrsWise.value;
      }
    });
  }

  Future Consumprion_AutoYearWise() async {
    await CommonProvider.Consum_getAutoYearWise().then((value){
      if (value != null) {
        Conum_autoYrsWise.value = value;
        return Conum_autoYrsWise.value;
      }
    });
  }

  Future Boq_Revised_AutoYearWise() async {
    await CommonProvider.BoqRevised_getAutoYearWise().then((value){
      if (value != null) {
        BOQRevised_autoYrsWise.value = value;
        return BOQRevised_autoYrsWise.value;
      }
    });
  }

  Future RequisitionSlipAutoYr() async {
    await CommonProvider.Requisitionslip_getAutoYearWise().then((value){
      if (value != null) {
        RequisitionSlip_autoYrsWise.value = value;
        return RequisitionSlip_autoYrsWise.value;
      }
    });
  }
}

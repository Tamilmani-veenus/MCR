
import '../../utilities/reports/report_constant.dart';
import '../../apimanager/apimanager.dart';
import '../baseutitiles.dart';



class SamplePDF_Report {


  static Future getPDF_Report(String Type,int work_id) async {
    var data = null;
    await ApiManager.getAPICall(ReportConstant.PDF_REPORT + "?Type=B&work_id=304")
        .then((value) {
      // data = casebooksiteFromJson(value);
      if (data != null && data.length > 0) {
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
      BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }



}
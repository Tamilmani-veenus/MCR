
import '../apimanager/apimanager.dart';
import '../models/home_menulistres_model.dart';
import '../utilities/apiconstant.dart';


class MenuProvider{


  static Future<List<GetHomeMenuListResponse>> getMenuListProvider(int userId) async {
    var data = null;
    await ApiManager.getAPICall(
        ApiConstant.GETMENU_LIST_API + "?UserId=$userId")
        .then((value) {
      final res = getHomeMenuListResponseFromJson(value);
      if (res.length > 0 && res != null) {
        data = res;
        return data;
      }
    }, onError: (error) {
      print(error);
      print("Error == $error");
    //  BaseUtitiles.showToast('Something went wrong.. $error');
    });
    return data;
  }

}
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AppUtils {
  Future<bool> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('user_logged_in') ?? false;
    return isLoggedIn;
  }

  void setUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user_logged_in', true);
  }

  Future<bool> isWalThroughCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('walkthrough') ?? false;
    return isLoggedIn;
  }

  void setWalkThroughCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('walkthrough', true);
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('user_logged_in', false);
    prefs.setString('user_token', '');
    prefs.setString('user_name', '');
    prefs.setBool('team_name_status', false);
  }

  void setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userId);
  }

  void setPromoter(String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_type', userType);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    return userId;
  }

  void setTeamName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', userName);
  }

  Future<String> getTeamName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('user_name') ?? "";
    return userName;
  }

  void setUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_token', token);
  }

  Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('user_token') ?? "";
    return token;
  }

  void setTeamNameStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('team_name_status', true);
  }

  Future<bool> getTeamNameStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isTeamNameStatus = prefs.getBool('team_name_status') ?? false;
    return isTeamNameStatus;
  }

  void setFCMToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('fcmToken', token);
  }

  Future<String> getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fcmToken = prefs.getString('fcmToken') ?? "";
    return fcmToken;
  }

  void setUserType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userType', type);
  }

  Future<String> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String type = prefs.getString('userType') ?? "";
    return type;
  }

  void setSessionRedirected(bool type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('sessionRedirected', type);
  }

  Future<bool> getSessionRedirected() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool type = prefs.getBool('sessionRedirected') ?? false;
    return type;
  }

  void setNotificationClickType(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('notificationClickType', type);
  }

  Future<String> getNotificationClickType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String type = prefs.getString('notificationClickType') ?? "";
    return type;
  }
}

void Print(name, value) {
  print({
    [name]: value,
  });
}

import 'dart:math';

import 'package:get/get.dart';
import 'package:sample/service/auth_service.dart';
import 'package:sample/service/repository/auth_repo.dart';
import 'package:sample/utils/get_utils.dart';
import 'package:grpc/grpc.dart';

import '../routes/routes.dart';

class AuthController extends GetxController {
  static AuthController get() => Get.find();

  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  static AuthController? _this;
  static AuthController? get controller => _this;

  bool canPop() => false;

  static String? _login;
  static String? _password;

  final _isValidLogin = false.obs;
  final _isValidPassword = false.obs;
  final _inProgress = false.obs;
  final _isFirstLoad = true.obs;

  bool get isValidLogin => _isValidLogin();
  bool get isValidPassword => _isValidPassword();
  bool get inProgress => _inProgress();
  bool get isFirstLoad => _isFirstLoad();

  @override
  void onInit() {
    super.onInit();
  }

  void setLogin(String? login){
    _login = login;
    final bool isValid = _login != null && _login!.length > 0;
    _isValidLogin(isValid);
    if (isValid == true){
      _isFirstLoad(false);
    }
    update();
  }

  void setPassword(String? password) {
    _password = password;
    _isValidPassword(_password != null && _password!.length > 0);
    update();
  }

  Future<dynamic> login() async {
    if (_login == null || _password == null) return;

    _inProgress(true);
    AppUtils.showPreloader();

    try {
      final user = await authRepo.auth(_login!, _password!);
      AppUtils.hidePreloader();
      _inProgress(false);
      if (user.login.isEmpty) {
        AppUtils.showError("User not found...");
      } else {
        saveToken(user.token);
        Get.offAllNamed(Routes.MAIN);
      }
    } on GrpcError catch(e) {
      _inProgress(false);
      print("error " + e.toString());
      final eMessage = e.message;
      if (eMessage != null) {
        AppUtils.showError(eMessage);
      }
    } catch (e){
      _inProgress(false);
      AppUtils.showError(e.toString());
    }
  }

  Future<bool> checkLogin() async {
    return await AuthService().getToken().then((token) {
      if (token != null && token.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<void> saveToken(String token) async {
    await AuthService().setToken(token);
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  }
}
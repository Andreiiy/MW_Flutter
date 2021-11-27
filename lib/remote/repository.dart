import 'package:math_world/models/app_data.dart';
import 'package:math_world/models/user.dart';
import 'package:math_world/remote/remote.dart';
import 'package:math_world/remote/responce_from_server.dart';

class Repository{


  final Remote remoteDataSource = Remote();
  AppData _appData = AppData();


  Future<ResponseFromServer?> register() async {
      final response = await remoteDataSource.register();
      if(response.errorCode ==  0)
        _appData.user = User.fromJson(response.data);
    return response;
  }

  Future<ResponseFromServer?> login(String email, String password) async {
    final response = await remoteDataSource.login(email,password);
    if(response.errorCode ==  0)
      _appData.user = User.fromJson(response.data);
    return response;
  }
}
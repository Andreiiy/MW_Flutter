import 'package:math_world/models/app_data.dart';
import 'package:math_world/models/user.dart';
import 'package:math_world/remote/remote.dart';
import 'package:math_world/remote/responce_from_server.dart';

class Repository{


  final Remote remoteDataSource = Remote();
  AppData _appData = AppData();


  Future<ResponseFromServer?> register(String name,String lastName, String password, String country) async {
      final response = await remoteDataSource.register(name,lastName,password,country);
      if(response.errorCode ==  0)
        _appData.user = User.fromJson(response.data);
    return response;
  }

  Future<ResponseFromServer?> login(String lastName, String password) async {
    final response = await remoteDataSource.login(lastName,password);
    if(response.errorCode ==  0)
      _appData.user = User.fromJson(response.data);
    return response;
  }
}
import 'package:flutter/foundation.dart';

import '../service/utils/base_urls.dart';
import 'base_config.dart';
import 'package:edge_client/utils/enums.dart';

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();
  BaseConfig? config;

  initConfig(EnvType env) {
    config = _getConfig(env);
  }

  /// based on the [environment] it will return the configurations
  BaseConfig _getConfig(EnvType environment) {
    switch (environment) {
      case EnvType.dev:
        return BaseConfig(BaseUrls.development);
      case EnvType.qa:
        return BaseConfig(BaseUrls.qualityAssurance);
      case EnvType.uat:
        return BaseConfig(BaseUrls.userAcceptanceTesting);
      case EnvType.prod:
        return BaseConfig(BaseUrls.production);
    }
  }

  static EnvType getEnvironment(EnvType defaultEnv){
    EnvType envType = defaultEnv;
    
    if(!kIsWeb) {
      const environment = String.fromEnvironment('ENV');
      if(environment.isNotEmpty) {
        envType = EnvType.values.firstWhere((e) {
          // print(e.toString());
          return e.toString().split('.').last == environment;
        }, orElse: ()=> defaultEnv);
      } else {
        envType = defaultEnv;
      }
    }
    print('dfdfdsds$envType');
    return envType;
  } 

}
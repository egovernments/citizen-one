
import 'package:egov_widgets/egov_widgets.dart';

mixin HelperMethods {

  static home(){
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  static String getExtension(String url){
    return url.substring(0, url.indexOf('?')).split('/').last;
  }

}
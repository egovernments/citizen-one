import 'dart:async';

import 'package:edge_client/modules/property_tax/property_result.dart';
import 'package:edge_client/service/base_service.dart';
import 'package:egov_widgets/egov_widgets.dart';
import 'package:egov_widgets/utils/models.dart';
import 'package:flutter/material.dart';

import '../modules/property_tax/property_search.dart';
import '../modules/property_tax/user_details.dart';
import '../repository/property_repo.dart';
import '../service/utils/api_end_points.dart';
import '../utils/enums.dart';

class ConsumerProvider extends UserRepository with ChangeNotifier{
  final UserDetails consumer;

  ConsumerProvider({required this.consumer}){
    setValues();
  }


  Future<void> createOrUpdateConsumer(BuildContext context, {bool isCreate = true}) async {
    try{
      getValues();
      var response = consumerCreateOrUpdate(consumer.toJson());
      ToastUtils.showCustomToast(context, '${isCreate ? 'Created' : 'Updated'} the consumer Successfully', '');
     navigatorKey.currentState?.pop();
     if(!isCreate) navigatorKey.currentState?.pop();
    }catch(e){

    }
  }

  Future<void> searchConsumer(String consumerName, Map category, BuildContext context) async {
    try{
      var query = {
        'searchPattern' : consumerName.toString()
      };
      var response = await searchForConsumer(query);
      if(response.isNotEmpty) {
        navigatorKey.currentState?.push(MaterialPageRoute(builder: (_)=> ConsumerResult(response, category)));
      }else{
        ToastUtils.showCustomToast(context, 'No consumers found', 'ERROR');
      }
    } catch(e){
     print(e);
    }
  }

   getValues() {
      consumer.name = consumer.nameCtrl.text.trim();
      consumer.username = consumer.fatherNameCtrl.text.trim();
      consumer.phone = consumer.phoneCtrl.text.trim();
      consumer.email = consumer.emailCtrl.text.trim();
      consumer.address ??= Address();
      consumer.address?.street = consumer.streetCtrl.text.trim();
      consumer.address?.zipcode = consumer.zipCodeCtrl.text.trim();
  }


  setValues(){
     consumer.nameCtrl.text = consumer.name ?? '';
     consumer.fatherNameCtrl.text = consumer.username ?? '';
    consumer.phoneCtrl.text = consumer.phone ?? '';
    consumer.emailCtrl.text = consumer.email ?? '';
    consumer.streetCtrl.text = consumer.address?.street ?? '';
    consumer.zipCodeCtrl.text = consumer.address?.zipcode ?? '';
  }

}

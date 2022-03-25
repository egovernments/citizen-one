

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/water_service/collect_payment.dart';
import '../screens/water_service/consumer_details.dart';

mixin ServiceHandler {

  var waterServiceList = [
    {
      "name" : "Create Consumer",
      "des"  : "Create a consumer",
      "categoryType" : "create",
    },
    {
      "name" : "Update Consumer",
      "des"  : "Update a consumer",
      "categoryType" : "update",
    },
    {
      "name" : "Collect Payment",
      "des"  : "collect a payment",
      "categoryType" : "collectPayment",
    }
  ];

  List<Map> getCategoriesBasedOnService(Map service){
    switch(service['serviceType']){
      case 'water' :
        return waterServiceList;
      case 'propertyTax' :
        return [];
      default :
        return [];
    }
  }


  void categoryNavigator(String serviceType, Map category, BuildContext context){
    switch(serviceType){
      case 'water' :
        switch(category['categoryType']){
          case 'create' :case 'update' :
            Navigator.push(context, MaterialPageRoute(builder: (_)=> Consumer(category)));
            break;
          case 'collectPayment' :
            Navigator.push(context, MaterialPageRoute(builder: (_)=> CollectPayment()));
            break;
        }
        break;
    }
  }


}
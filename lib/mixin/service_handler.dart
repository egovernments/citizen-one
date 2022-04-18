

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modules/water_service/collect_payment.dart';
import '../modules/water_service/consumer_details.dart';
import '../modules/water_service/consumer_search.dart';

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
  var propertyServiceList = [
    {
      "name" : "Create Property",
      "des"  : "Create a new property",
      "categoryType" : "create",
    },
    {
      "name" : "Update Property",
      "des"  : "Update property details",
      "categoryType" : "update",
    },
    {
      "name" : "Search Property",
      "des"  : "Search a property",
      "categoryType" : "search",
    }
  ];
  var tradeLicenceServiceList = [
    {
      "name" : "New Trade licence",
      "des"  : "Apply for a new trade licence",
      "categoryType" : "create",
    },
    {
      "name" : "Renew Trade licence",
      "des"  : "Renew a trade licence",
      "categoryType" : "update",
    },
    {
      "name" : "Search Application",
      "des"  : "Search Trade licence application",
      "categoryType" : "search",
    }
  ];

  List<Map> getCategoriesBasedOnService(Map service){
    switch(service['serviceType']){
      case 'water' :
        return waterServiceList;
      case 'propertyTax' :
        return propertyServiceList;
      case 'tradeLicence' :
        return tradeLicenceServiceList;
      default :
        return [];
    }
  }


  void categoryNavigator(String serviceType, Map category, BuildContext context){
    switch(serviceType){
      case 'propertyTax' :
        switch(category['categoryType']){
          case 'create' :
            Navigator.push(context, MaterialPageRoute(builder: (_)=> ConsumerView(category)));
            break;
          case 'update' :
            Navigator.push(context, MaterialPageRoute(builder: (_)=> ConsumerSearch(category)));
            break;
          case 'collectPayment' :
            Navigator.push(context, MaterialPageRoute(builder: (_)=> CollectPayment()));
            break;
        }
        break;
    }
  }


}
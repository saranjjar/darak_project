

import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String? serviceName;
  final String? icon;

  Category({
    this.serviceName,
    this.icon,
  });

  factory Category.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return Category(
      serviceName : data?['service_name'],
      icon : data?['icon'],

    );
  }

  Map<String,dynamic> toFirestore(){
    return {
      if(serviceName!=null) 'service_name':serviceName,
      if(icon!=null) 'icon':icon,
    };
  }
}
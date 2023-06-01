

import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategory {
  final String? id;
  final String? username;
  final String? price;
  final String? bio;
  final String? photo;
  final String? service;
  final String? subService;
  final String? idNumber;
  final String? location;
  final String? email;
  final String? mobile;


  SubCategory({
    this.id,
    this.username,
    this.price,
    this.bio,
    this.photo,
    this.service,
    this.idNumber,
    this.location,
    this.mobile,
    this.email,
    this.subService
  });

  factory SubCategory.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return SubCategory(
      id : data?['id'],
      username : data?['user_name'],
      bio : data?['bio'],
      photo : data?['photo'],
      price : data?['price'],
      service : data?['service'],
      location : data?['location'],
      idNumber : data?['idNumber'],
      mobile : data?['mobile'],
      email : data?['email'],
      subService : data?['subService'],
    );
  }

  Map<String,dynamic> toFirestore(){
    return {
      if(id!=null) 'id':id,
      if(username!=null) 'user_name':username,
      if(photo!=null) 'photo':photo,
      if(price!=null) 'price':price,
      if(bio!=null) 'bio':bio,
      if(service!=null) 'service':service,
      if(location!=null) 'location':location,
      if(idNumber!=null) 'idNumber':idNumber,
      if(mobile!=null) 'mobile':mobile,
      if(email!=null) 'email':email,
      if(subService!=null) 'subService':subService,
    };
  }
}
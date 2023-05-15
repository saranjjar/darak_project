

import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategory {
  final String? username;
  final String? price;
  final String? bio;
  final String? photo;
  final String? service;
  final String? idNumber;
  final String? location;
  final String? email;
  final String? mobile;


  SubCategory({
    this.username,
    this.price,
    this.bio,
    this.photo,
    this.service,
    this.idNumber,
    this.location,
    this.mobile,
    this.email,
  });

  factory SubCategory.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return SubCategory(
      username : data?['user_name'],
      bio : data?['bio'],
      photo : data?['photo'],
      price : data?['price'],
      service : data?['service'],
      location : data?['location'],
      idNumber : data?['idNumber'],
      mobile : data?['mobile'],
      email : data?['email'],
    );
  }

  Map<String,dynamic> toFirestore(){
    return {
      if(username!=null) 'user_name':username,
      if(photo!=null) 'photo':photo,
      if(price!=null) 'price':price,
      if(bio!=null) 'bio':bio,
      if(service!=null) 'service':service,
      if(location!=null) 'location':location,
      if(idNumber!=null) 'idNumber':idNumber,
      if(mobile!=null) 'mobile':mobile,
      if(email!=null) 'email':email,
    };
  }
}
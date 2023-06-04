import 'package:cloud_firestore/cloud_firestore.dart';

class BookingReview {
  final String? uid;
  final String? toUid;
  final String? nameCustomer;
  final String? serviceName;
  final String? subServiceName;
  //final String? category;
  final String? worker;
  final String? date;
  final String? time;
  final String? workingHours;
  final String? price;
  final String? status;
  final String? location;

  BookingReview({
    this.uid,
    this.toUid,
    this.nameCustomer,
    this.serviceName,
    this.subServiceName,
    //this.category,
    this.worker,
    this.date,
    this.time,
    this.workingHours,
    this.price,
    this.status,
    this.location
  });

  factory BookingReview.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return BookingReview(
      uid: data?['uid'],
      toUid: data?['toUid'],
      nameCustomer: data?['nameCustomer'],
      serviceName: data?['serviceName'],
      subServiceName: data?['subServiceName'],
      //category: data?['category'],
      worker: data?['worker'],
      date: data?['date'],
      time: data?['time'],
      workingHours: data?['workingHours'],
      price: data?['price'],
      status: data?['status'],
      location: data?['location'],
    );
  }

  Map<String,dynamic> toFirestore(){
    return{
      if(uid !=null) "uid" : uid,
      if(toUid !=null) "toUid" : toUid,
      if(nameCustomer !=null) "nameCustomer" : nameCustomer,
      if(serviceName !=null) "serviceName" : serviceName,
      if(subServiceName !=null) "subServiceName" : subServiceName,
      //if(category !=null) "category" : category,
      if(worker !=null) "worker" : worker,
      if(date !=null) "date" : date,
      if(time !=null) "time" : time,
      if(workingHours !=null) "workingHours" : workingHours,
      if(price !=null) "price" : price,
      if(status !=null) "status" : status,
      if(location !=null) "location" : location,
    };
  }
}
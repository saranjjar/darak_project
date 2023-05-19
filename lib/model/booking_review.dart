import 'package:cloud_firestore/cloud_firestore.dart';

class BookingReview {
  final String? uid;
  final String? serviceName;
  final String? category;
  final String? worker;
  final String? date;
  final String? workingHours;
  final String? price;
  final String? status;

  BookingReview({
    this.uid,
    this.serviceName,
    this.category,
    this.worker,
    this.date,
    this.workingHours,
    this.price,
    this.status,
  });

  factory BookingReview.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return BookingReview(
      uid: data?['uid'],
      serviceName: data?['serviceName'],
      category: data?['category'],
      worker: data?['worker'],
      date: data?['date'],
      workingHours: data?['workingHours'],
      price: data?['price'],
      status: data?['status'],
    );
  }

  Map<String,dynamic> toFirestore(){
    return{
      if(uid !=null) "uid" : uid,
      if(serviceName !=null) "serviceName" : serviceName,
      if(category !=null) "category" : category,
      if(worker !=null) "worker" : worker,
      if(date !=null) "date" : date,
      if(workingHours !=null) "workingHours" : workingHours,
      if(price !=null) "price" : price,
      if(status !=null) "status" : status,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class WorkerData {
  final String? id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final String? location;
  final String? fcmtoken;
  final Timestamp? addtime;

  WorkerData(
      {this.id,
        this.name,
        this.email,
        this.photoUrl,
        this.location,
        this.fcmtoken,
        this.addtime});

  factory WorkerData.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> snapshot,
      SnapshotOptions? options,
      ){
    final data = snapshot.data();
    return WorkerData(
      id:data?['id'],
      name:data?['name'],
      email:data?['email'],
      photoUrl:data?['photourl'],
      location:data?['location'],
      fcmtoken:data?['fcmtoken'],
      addtime:data?['addtime'],
    );
  }

  Map<String,dynamic> toFirestore(){
    return{
      if(id != null) 'id':id,
      if(name != null) 'name':name,
      if(email != null) 'email':email,
      if(photoUrl != null) 'photourl':photoUrl,
      if(location != null) 'location':location,
      if(fcmtoken != null) 'fcmtoken':fcmtoken,
      if(addtime != null) 'addtime':addtime,
    };
  }
}
class TWorker {
  String? accessToken;
  String? displayName;
  String? email;
  String? photoUrl;

  TWorker({
    this.accessToken,
    this.displayName,
    this.email,
    this.photoUrl,
  });

  factory TWorker.fromJson(Map<String, dynamic> json) {
    return TWorker(
      accessToken: json['access_token'] ?? '',
      displayName: json['display_name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson()=>{
    'access_token':accessToken,
    'display_name':displayName,
    'email':email,
    'photoUrl':photoUrl,
  };
}
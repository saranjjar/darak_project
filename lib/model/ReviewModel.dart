// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ReviewModel {
//   String? uid;
//   String? toUid;
//   String? name;
//   String? nameWorker;
//   String? comment;
//   num? currentRating;
//   String? url;
//   Timestamp? day;
//   ReviewModel({
//     this.uid,
//     this.toUid,
//     this.name,
//     this.nameWorker,
//     this.comment,
//     this.day,
//     this.currentRating,
//     this.url,
//   });
//   factory ReviewModel.formMap(
//     DocumentSnapshot<Map<String, dynamic>> snapshot,
//   ) {
//     final data = snapshot.data();
//     return ReviewModel(
//       uid: data?['uid'],
//       toUid: data?['toUid'],
//       name: data?['name'],
//       nameWorker: data?['nameWorker'],
//       comment: data?['comment'],
//       day: data?['day'],
//       currentRating: data?['rating'],
//       url: data?['url'],
//     );
//   }
//   Map<String, dynamic> toFirestore() {
//     return {
//       if (uid != null) "uid": uid,
//       if (toUid != null) "toUid": toUid,
//       if (name != null) "name": name,
//       if (nameWorker != null) "nameWorker": nameWorker,
//       if (comment != null) "comment": comment,
//       if (day != null) "day": day,
//       if (currentRating != null) "rating": currentRating,
//       if (url != null) "url": url,
//     };
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String? uid;
  final String? toUid;
  final String? name;
  final String? nameWorker;
  final String? comment;
  final num? currentRating;
  final String? url;
  final Timestamp? day;
  ReviewModel({
    this.uid,
    this.toUid,
    this.name,
    this.nameWorker,
    this.comment,
    this.day,
    this.currentRating,
    this.url,
  });
  factory ReviewModel.formMap(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ReviewModel(
      uid: data?['uid'],
      toUid: data?['toUid'],
      name: data?['name'],
      nameWorker: data?['nameWorker'],
      comment: data?['comment'],
      day: data?['day'],
      currentRating: data?['rating'],
      url: data?['url'],
    );
// uid = data.id;
// toUid = data['toUid'];
// name = data['name'];
// nameWorker = data['nameWorker'];
// comment = data['comment'];
// day = data['day'];
// currentRating = data['rating'];
// url = data['url'];
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (toUid != null) "toUid": toUid,
      if (name != null) "name": name,
      if (nameWorker != null) "nameWorker": nameWorker,
      if (comment != null) "comment": comment,
      if (day != null) "day": day,
      if (currentRating != null) "rating": currentRating,
      if (url != null) "url": url,
    };
  }
}

class Comment {
  String userId;
  String workerId;
  String message;
  DateTime timestamp;

  Comment({
    required this.userId,
    required this.workerId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'workerId': workerId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darak_project/model/msg_content.dart';
import 'package:darak_project/services/common/user_store.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:random_string/random_string.dart';

class InChatController extends GetxController {

  RxList<MsgContent> msgContact = <MsgContent>[].obs;
  var to_uid = ''.obs;
  var to_name = ''.obs;
  var to_avatar = ''.obs;
  var to_location = 'unKnown'.obs;
  var doc_id = null;

  final textController = TextEditingController();
  ScrollController msgScrolling = ScrollController();

  FocusNode contentNode = FocusNode();
  final user_id = UserStore.t0.token;
  final db = FirebaseFirestore.instance;
  var listener ;

  sendImageMessage(String url) async{
    final content = MsgContent(
        uid: user_id,
        content: url,
        type: "image",
        addtime: Timestamp.now()
    );
    await db.collection('message').doc(doc_id).collection('msglist').withConverter(
        fromFirestore: MsgContent.fromFirestore,
        toFirestore: (MsgContent msgContent,options)=>msgContent.toFirestore()
    ).add(content).then((DocumentReference doc) {
      textController.clear();
      Get.focusScope?.unfocus();
    });

    await db.collection("message").doc(doc_id).update(
        {
          "last_msg":" [image] ",
          "last_time":Timestamp.now()
        }
    );
  }

  //send Message Method
  sendMessage() async{
    String sendContent = textController.text;
    final content = MsgContent(
      uid: user_id,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now()
    );
    await db.collection('message').doc(doc_id).collection('msglist').withConverter(
        fromFirestore: MsgContent.fromFirestore,
        toFirestore: (MsgContent msgContent,options)=>msgContent.toFirestore()
    ).add(content).then((DocumentReference doc) {
      textController.clear();
      Get.focusScope?.unfocus();
    });
    
    await db.collection("message").doc(doc_id).update(
      {
        "last_msg":sendContent,
        "last_time":Timestamp.now()
      }
    );
  }


  void showPicker(context){
    showModalBottomSheet(
      context:context,builder:(BuildContext context){
        return SafeArea(child: Wrap(
          children: [
           ListTile(
             leading: const Icon(Icons.photo_library),
             title: const Text('Gallery',),
             onTap: () {
                imgFromGallery(ImageSource.gallery);
               Get.back();
             },
           ),
            ListTile(
             leading: const Icon(Icons.photo_camera),
             title: const Text('Camera',),
             onTap: (){
                imgFromGallery(ImageSource.camera);
                Get.back();
                },
           ),
          ],
        ));
    }
    );
  }

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery(ImageSource image) async {
    final pickedFile = await _picker.getImage(source:image);
    if(pickedFile!=null){
      _photo = File(pickedFile.path);
      uploadFile();
    }else{
      if (kDebugMode) {
        print("No image selected");
      }
    }
  }

  Future getImageUrl(String name) async{
    final spaceRef = FirebaseStorage.instance.ref("chat").child(name);
    var str = await spaceRef.getDownloadURL();
    return str??"";
  }

  Future uploadFile()async{
    if(_photo==null)return;
    final fileName = randomAlphaNumeric(15)+extension(_photo!.path);
    try{
      final ref = FirebaseStorage.instance.ref("chat").child(fileName);
      ref.putFile(_photo!).snapshotEvents.listen((event) async{
        switch(event.state){
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String imgUrl = await getImageUrl(fileName);
            sendImageMessage(imgUrl);
        }
      });
    }catch(error){
        if (kDebugMode) {
          print(error.toString());
        }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = Get.parameters;
    doc_id = data['doc_id'];
    to_uid.value = data['to_uid']??"";
    to_name.value = data['to_name']??"";
    to_avatar.value = data['to_avatar']??"";
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    var messages = db.collection('message').doc(doc_id).collection("msglist").withConverter(
        fromFirestore: MsgContent.fromFirestore,
        toFirestore: (MsgContent msgcontent,options)=>msgcontent.toFirestore()
    ).orderBy("addtime",descending: false);
    msgContact.clear();
    listener = messages.snapshots().listen((event) {
      for(var change in event.docChanges){
        switch(change.type){
          case DocumentChangeType.added:
          if(change.doc.data()!=null){
            msgContact.insert(0, change.doc.data()!);
          }
            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;

        }
      }
    },
    onError: (error)=>print('Listen Failed : $error')
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    msgScrolling.dispose();
    listener.cancel();
  }
}
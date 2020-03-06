import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {

  final FirebaseUser user;

  CreatePage(this.user);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();

  File _image;

  @override
  void dispose() {
    textEditingController.dispose(); //메모리를 해제해야함
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildApp(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        child: Icon(Icons.add_a_photo,),
      ),
    );
  }

  Widget _buildApp() {
    return AppBar(actions: <Widget>[
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () {
          final firebaseStorageRef = FirebaseStorage.instance
              .ref()
              .child('post')
              .child(widget.user.uid)
              .child('${DateTime.now().millisecondsSinceEpoch}.png');
          final task = firebaseStorageRef.putFile(
            _image, StorageMetadata(contentType: 'image/png')
          );
          task.onComplete.then((value){
            var downloadUrl = value.ref.getDownloadURL();

            downloadUrl.then((uri){
              var doc = Firestore.instance.collection('post').document(widget.user.uid);
              doc.setData({
                'id': doc.documentID,
                'photoUrl': uri.toString(),
                'contents': textEditingController.text,
                'user': widget.user.displayName,
                'email': widget.user.email,
                'userPhotoUrl': widget.user.photoUrl,
                'userUid': widget.user.uid,
              }).then((onvalue){
                Navigator.pop(context);
              });
            });

          });
        },
      )
    ]);
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _image == null ? Text('No Image') : Image.file(_image),
          TextField(
            decoration: InputDecoration(hintText: '내용을 입력하세요!!'),
            controller: textEditingController,
          )
        ],
      ),
    );
  }

  Future _getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lostfound/detail_stuff_page.dart';
import 'package:lostfound/two_main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detail_post_page.dart';

class HomePage extends StatelessWidget {

  final FirebaseUser user;

  HomePage(this.user);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName),
              accountEmail: Text(user.email),
              onDetailsPressed: () {},
              otherAccountsPictures: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white30,
                    backgroundImage: AssetImage(
                        'assets/images/one.jpg'
                    ),
                  ), CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  backgroundImage: AssetImage(
                      'assets/images/five.jpg'
                  ),
                ), CircleAvatar(
                  backgroundColor: Colors.brown.shade800,
                  backgroundImage: AssetImage(
                      'assets/images/four.jpg'
                  ),
                ),

              ],
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                Theme.of(context).platform == TargetPlatform.iOS
                    ? Colors.blue
                    : Colors.white,
                child: Image.network(user.photoUrl),
              ),
            ),
            ListTile(
              title: Text("처음 페이지 UI"),
              trailing: Icon(Icons.arrow_forward),
            ),
            ListTile(
              title: Text("두번째 페이지 UI"),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => TwoMainPage(user)));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        brightness: Brightness.light,
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.displayName + '님',
                      style: TextStyle(color: Colors.black87, fontSize: 25),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '찾으실 분실물을 입력해주세요!',
                      style:
                          TextStyle(color: Colors.lightBlueAccent, fontSize: 23),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(244, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                            hintText: "찾으실 분실물을 입력해주세요!",
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 15)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '찾는 물품이에요!',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 180,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          promoCard('assets/images/one.jpg', 'S Fold',context),
                          promoCard('assets/images/two.jpeg', '겔럭시 버즈',context),
                          promoCard('assets/images/three.jpg', '책가방',context),
                          promoCard('assets/images/four.jpg', '맥프로 2017' ,context),
                          promoCard('assets/images/five.jpg', '기가지니 버즈',context),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text('내가 찾아준 물품이에요!!',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 11,
                    ),
                    Container(
                      height: 200,
                      child: _buildBody(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  Widget promoCard1(image,text,BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyDetailPage(image,text)));
        },
        child: Container(
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(image),
            ),
          ),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                    0.1,
                    0.95
                  ], colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.1),
                  ])),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              )),
        ),
      ),
    );
  }

  Widget promoCard(image,text,BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyDetailPage(image,text)));
        },
        child: Container(
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(image),
            ),
          ),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                    0.1,
                    0.95
                  ], colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.1),
                  ])),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
              )),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('post').where("userUid", isEqualTo: user.uid).snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var items = snapshot.data?.documents ?? [];

          print(items[0]['photoUrl']);

          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return promoCard1(items[index]['photoUrl'],items[index]['contents'],context);
              });//romoCard(image,text,BuildContext context) {
        },
      ),
    );
  }

  Widget _buildListItem(context, document) {
    return Hero(
      tag: document['photoUrl'],
      child: Material(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DetailPostPage(document);
                }
            ));
          },
          child: Image.network(
            document['photoUrl'],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

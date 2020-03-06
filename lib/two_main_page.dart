import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lostfound/create_page.dart';
import 'package:lostfound/detail_post_page.dart';
import 'package:lostfound/detail_stuff_page.dart';
import 'package:lostfound/home_page.dart';
import 'package:flutter/material.dart';

class TwoMainPage extends StatefulWidget {

  final FirebaseUser user;

  TwoMainPage(this.user);

  @override
  _TwoMainPageState createState() => _TwoMainPageState();
}

class _TwoMainPageState extends State<TwoMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.displayName),
              accountEmail: Text(widget.user.email),
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
                    ? Colors.deepOrangeAccent
                    : Colors.white,
                child: Image.network(widget.user.photoUrl),
              ),
            ),
            ListTile(
              title: Text("처음 페이지 UI"),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage(widget.user)));
              },
            ),
            ListTile(
              title: Text("두번째 페이지 UI"),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){

              },
            ),

          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          _top(),
          SizedBox(height: 20.0,),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.0,),
          Container(height: 180.0,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 3 / 2),
              children: <Widget>[
                _girdItem(Icons.assignment_ind ,'면허증'),
                _girdItem(Icons.phone_iphone , '휴대폰'),
                _girdItem(Icons.laptop_mac, '노트북'),
                _girdItem(Icons.watch, '시계'),
                _girdItem(Icons.work, '가방'),
                _girdItem(Icons.headset, '이어폰'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Text("Latest",
                  style: TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                promoCard('assets/images/one.jpg', 'S Fold'),
                promoCard('assets/images/two.jpeg', '겔럭시 버즈'),
                promoCard('assets/images/three.jpg', '책가방'),
                promoCard('assets/images/four.jpg', '맥프로 2017' ),
                promoCard('assets/images/five.jpg', '기가지니 버즈'),
              ],
            ),
          ),
          SizedBox(
            height: 11,
          ),
        ],
      ),
    );
  }

  Widget promoCard(image,text) {
    return InkWell(
      onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyDetailPage(image,text)));
      },
      child: AspectRatio(
        aspectRatio: 2.62 / 3,
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
  _girdItem(icon, texts) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          child: Icon(
            icon,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepOrange,
        ),
        SizedBox(height: 10.0,),
        Text(
          texts,
          style: TextStyle(
            fontSize: 12.0, fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }

  _top() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.photoUrl),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                   'hi '+ widget.user.displayName,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.notifications,
                  color: Colors.white,),
                onPressed: () {},
              )
            ],
          ),
          SizedBox(height: 30.0,),
          TextField(
            decoration: InputDecoration(
              hintText: "Search",
              fillColor: Colors.white,
              filled: true,
              suffixIcon: Icon(Icons.filter_list),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            ),
          )
        ],
      ),
    );
  }
}

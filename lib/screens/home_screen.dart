import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_firebase/providers/user_provider.dart';
import 'package:instagram_firebase/resources/auth_methods.dart';
import 'package:instagram_firebase/utiils/colors.dart';
import 'package:instagram_firebase/models/user.dart' as model;
import 'package:instagram_firebase/utiils/list.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  int _page = 0;
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
    addData();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int page){
    _pageController.jumpToPage(page);
  }
  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  addData() async {
    UserProvider _userprovider = Provider.of(context, listen: false);
    await _userprovider.refreshUser();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    print(snap.data());
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        children: homeItems,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
      // body: Center(
      //     child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     InkWell(
      //       onTap: () async {
      //         await AuthMethods().signout();
      //       },
      //       child: Container(
      //         color: Colors.blue,
      //         child: Center(
      //           child: Text("Log out"),
      //         ),
      //       ),
      //     ),
      //     100.heightBox,
      //     Text(user.bio),
      //   ],
      // )),
      bottomNavigationBar:
          CupertinoTabBar(backgroundColor: mobileBackgroundColor, items: [
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            label: 'Home',
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            label: 'Search',
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.plus_square,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            label: 'Like',
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.heart,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            label: 'Home',
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.profile_circled,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            label: 'Home',
            backgroundColor: primaryColor),
      ],
      onTap: navigationTapped,
      ),
    );
  }
}

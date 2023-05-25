import 'package:flutter/material.dart';
import 'package:project/view/auth/login_page.dart';
import 'package:project/view/page_search_meal.dart';
import 'package:project/view/list.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

class MenuUtama extends StatefulWidget {
  const MenuUtama({Key? key}) : super(key: key);

  @override
  State<MenuUtama> createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    BerandaScreen(),
    ProfilScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xffDFA67B)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Color(0xffDFA67B)),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Color(
            0xffDFA67B), // Ubah warna ikon dan teks item yang dipilih sesuai kebutuhan
        unselectedItemColor: Colors
            .grey, // Ubah warna ikon dan teks item yang tidak dipilih sesuai kebutuhan
        // Mengubah gaya teks label pada item yang dipilih
        selectedLabelStyle: TextStyle(
          color: Color(
              0xffDFA67B), // Ubah warna teks label pada item yang dipilih sesuai kebutuhan
        ),
        // Mengubah gaya teks label pada item yang tidak dipilih
        unselectedLabelStyle: TextStyle(
          color: Colors
              .grey, // Ubah warna teks label pada item yang tidak dipilih sesuai kebutuhan
        ),
      ),
    );
  }
}

class BerandaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF2CC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffDFA67B),
        leading: IconButton(
          icon: Icon(Icons.restaurant),
          onPressed: () {},
        ),
        title: Text(
          'Home',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _validasi(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 170,
              height: 45,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xffDFA67B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PageCategory();
                  }));
                },
                child: Text(
                  "List Category",
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
            Container(
              width: 170,
              height: 45,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xffDFA67B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PageSearchMeal();
                  }));
                },
                child: Text(
                  "Search Makanan",
                  style: TextStyle(
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _validasi(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure want to logout?"),
        actions: [
          TextButton(
            onPressed: () => _logoutProcess(context),
            child: Text("Yes"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("No"),
          ),
        ],
      ),
    );
  }

  _logoutProcess(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('status', false);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

}

class ProfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF2CC),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffDFA67B),
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {},
        ),
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Card(
              margin: const EdgeInsets.only(top: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Container(
                height: 250,
                width: 300,
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 130,
                        child: Image.asset(
                          'assets/rosy.jpeg',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 90,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("Nur Rosydatun Nafiah"),
                    Text("123200001"),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.only(top: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 10,
              child: Container(
                height: 250,
                width: 300,
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 130,
                        child: Image.asset(
                          'assets/gita.jpeg',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.person,
                              size: 90,
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text("Regita Amelia Asnawi Putri"),
                    Text("123200024"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

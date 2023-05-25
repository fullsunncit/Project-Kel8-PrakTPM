import 'dart:ui';
import 'package:project/view/auth/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'page_list_meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageSearchMeal extends StatefulWidget {
  const PageSearchMeal({Key? key}) : super(key: key);

  @override
  _PageSearchMealState createState() => _PageSearchMealState();
}

class _PageSearchMealState extends State<PageSearchMeal> {
  final _controller = TextEditingController();
  String Value = '';
  // String? text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF2CC),
      appBar: AppBar(
        backgroundColor: Color(0xffDFA67B),
        title: Row(
          children: [
            Icon(Icons.fastfood_rounded),
            SizedBox(width: 5), // Jarak antara ikon dan teks
            Text(
              'Search Makanan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                padding: EdgeInsets.all(1),
                child: Container(
                  child: TextField(
                    selectionHeightStyle: BoxHeightStyle.max,
                    style: GoogleFonts.nunitoSans(
                        textStyle: TextStyle(fontSize: 15)),
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.nunitoSans(fontSize: 15.0),
                      hintText: "Enter meal title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: BorderSide(
                          color: Color(
                              0xffDFA67B), // Ubah warna outline sesuai kebutuhan
                        ),
                      ),
                      filled: true,
                      icon: Icon(
                        Icons.search,
                        color: Color(0xffDFA67B),
                        size: 40.0,
                      ),
                    ),
                    onChanged: (value) => {
                      setState(
                            () {
                          Value = value;
                        },
                      )
                    },
                    controller: _controller,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.all(1),
              child: Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(
                        0xffDFA67B),
                  ),
                  child: Text(
                    "Search",
                    style: GoogleFonts.nunitoSans(
                      textStyle: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return PageListMeal(text: Value);
                    }));
                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  }


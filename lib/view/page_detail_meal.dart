import 'package:shared_preferences/shared_preferences.dart';
import '../controller/meals_data_source.dart';
import '../model/details.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PageDetailMeal extends StatefulWidget {
  final String idMeal;
  const PageDetailMeal({Key? key, required this.idMeal}) : super(key: key);
  @override
  State<PageDetailMeal> createState() => _PageDetailMealState();
}

class _PageDetailMealState extends State<PageDetailMeal> {

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
              'Detail Makanan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: _buildDetailBody(),
    );
  }

  Widget _buildDetailBody() {
    return Container(
      child: FutureBuilder(
        future: MealsDataSource.instance.loadDetailMeal(widget.idMeal),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }
          if (snapshot.hasData) {
            MealDetail mealsModel = MealDetail.fromJson(snapshot.data);
            return _buildSuccessSection(mealsModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MealDetail data) {
    return ListView.builder(
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildTampil(data.meals![index]);
      },
    );
  }

  Widget _buildTampil(Meals detailModel){
    return Column(
      children: [
        SizedBox(height: 25.0),
        Container(
          width: 250.0,
          height: 200.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ClipRRect(
            child: Image.network(
              detailModel.strMealThumb!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          detailModel.strMeal!,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          width: 500,
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "🍕 Category : ${detailModel.strCategory!}",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 5.0),
              Text(
                "📍 Area : ${detailModel.strArea!}",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 5.0),
              Text("👩‍🍳 Instructions : "),
              Text(
                "${detailModel.strInstructions!}",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 5.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _launchURL("${detailModel.strYoutube}");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xffDFA67B)), // Ubah warna background button sesuai kebutuhan, misalnya Colors.brown
                  ),
                  child: Text("🎥 Youtube"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

import 'package:project/view/page_detail_meal.dart';
import '../controller/meals_data_source.dart';
import '../model/meals.dart';
import 'package:flutter/material.dart';

class PageListMeal extends StatefulWidget {
  final String text;
  const PageListMeal({Key? key, required this.text}) : super(key: key);
  @override
  State<PageListMeal> createState() => _PageListMealState();
}

class _PageListMealState extends State<PageListMeal> {

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
              'List Makanan',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: _buildListUsersBody(),
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: MealsDataSource.instance.loadMeals(widget.text),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          } else if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            MealList mealsModel = MealList.fromJson(snapshot.data);
            if (mealsModel.meals == "False") {
              return kosong();
            } else {
              return _buildSuccessSection(mealsModel);
            }
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget kosong() {
    return Center(
      child: Text("Data Kosong"),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(MealList data) {
    return ListView.builder(
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(data.meals![index]);
      },
    );
  }

  Widget _buildItemUsers(Meals mealData) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PageDetailMeal(idMeal: mealData.idMeal!))),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 120,
              child: Image.network(mealData.strMealThumb!),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealData.strMeal!,
                    maxLines: 1,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(mealData.strCategory!)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

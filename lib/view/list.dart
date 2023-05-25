import '../controller/meals_data_source.dart';
import '../model/category.dart';
import 'package:flutter/material.dart';

class PageCategory extends StatefulWidget {
  const PageCategory({Key? key}) : super(key: key);
  @override
  State<PageCategory> createState() => _PageCategoryState();
}

class _PageCategoryState extends State<PageCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF2CC),
      appBar: AppBar(
        backgroundColor: Color(0xffDFA67B),
        title: Row(
          children: [
            Icon(Icons.fastfood),
            SizedBox(width: 5), // Jarak antara ikon dan teks
            Text(
              'List Category',
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
        future: MealsDataSource.instance.loadListCategory(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          } else if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            ListCategory mealsModel = ListCategory.fromJson(snapshot.data);
            if (mealsModel.categories == "False") {
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

  Widget _buildSuccessSection(ListCategory data) {
    return ListView.builder(
      itemCount: data.categories!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(data.categories![index]);
      },
    );
  }

  Widget _buildItemUsers(Categories mealData) {
    return InkWell(
      onTap: () => {},
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 140,
              child: Image.network(mealData.strCategoryThumb!),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mealData.strCategory!,
                    maxLines: 1,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    truncateToSentence(mealData.strCategoryDescription!),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  String truncateToSentence(String text) {
    final List<String> sentences = text.split(RegExp(r"(?<!\w\.\w.)(?<![A-Z][a-z]\.)(?<=\.|\?)\s"));
    final String firstSentence = sentences.first;
    return firstSentence;
  }
}

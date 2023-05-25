import '../service/base_network.dart';

class MealsDataSource {
  static MealsDataSource instance = MealsDataSource();

  Future<Map<String, dynamic>> loadMeals(String text) {
    return BaseNetwork.get("search.php?s=" + text);
  }

  Future<Map<String, dynamic>> loadDetailMeal(String idMeal) {
    return BaseNetwork.get("lookup.php?i=" + idMeal);
  }

  Future<Map<String, dynamic>> loadListCategory() {
    return BaseNetwork.get("categories.php");
  }
}

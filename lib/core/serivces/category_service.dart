import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/models/category.dart';

class CategoryService {
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('Categories');

  Future<List<Category>> getCategories() async {
    QuerySnapshot querySnapshot = await categories.get();
    List<Category> categoryList = [];
      querySnapshot.docs.forEach((doc) {
      categoryList.add(Category.fromJson(doc.data() as Map<String, dynamic>));
    });
    return categoryList;
  }
}

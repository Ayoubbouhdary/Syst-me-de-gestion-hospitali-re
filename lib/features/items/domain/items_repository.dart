import 'item.dart';

abstract class ItemsRepository {
  Future<List<Item>> getItems();
  Future<Item> getItem(String id);
}

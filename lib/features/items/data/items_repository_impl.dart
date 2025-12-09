import 'dart:async';
import '../domain/item.dart';
import '../domain/items_repository.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  final List<Item> _items = List.generate(
    20,
    (index) => Item(
      id: '$index',
      title: 'Item $index',
      description: 'This is the description for item $index. It is a very interesting item.',
      price: (index + 1) * 10.0,
      imageUrl: 'https://picsum.photos/200?random=$index',
    ),
  );

  @override
  Future<Item> getItem(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _items.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<Item>> getItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return _items;
  }
}

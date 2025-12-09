import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/items_repository_impl.dart';
import '../domain/item.dart';
import '../domain/items_repository.dart';

part 'items_providers.g.dart';

@riverpod
ItemsRepository itemsRepository(ItemsRepositoryRef ref) {
  return ItemsRepositoryImpl();
}

@riverpod
Future<List<Item>> itemsList(ItemsListRef ref) async {
  return ref.watch(itemsRepositoryProvider).getItems();
}

@riverpod
Future<Item> itemDetail(ItemDetailRef ref, String id) async {
  return ref.watch(itemsRepositoryProvider).getItem(id);
}

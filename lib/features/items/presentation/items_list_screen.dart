import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'items_providers.dart';

class ItemsListScreen extends ConsumerWidget {
  const ItemsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: itemsAsync.when(
        data: (items) => RefreshIndicator(
          onRefresh: () => ref.refresh(itemsListProvider.future),
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.imageUrl),
                ),
                title: Text(item.title),
                subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                onTap: () => context.go('/items/${item.id}'),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

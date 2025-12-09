import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'soin_providers.dart';

class SoinsListScreen extends ConsumerWidget {
  const SoinsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soinsAsync = ref.watch(soinsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Soins'),
      ),
      body: soinsAsync.when(
        data: (soins) => RefreshIndicator(
          onRefresh: () => ref.refresh(soinsListProvider.future),
          child: ListView.builder(
            itemCount: soins.length,
            itemBuilder: (context, index) {
              final soin = soins[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(soin.typeSoin),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${DateFormat('dd/MM/yyyy HH:mm').format(soin.dateSoin)}'),
                      if (soin.description != null) Text(soin.description!),
                    ],
                  ),
                  trailing: Text(
                    NumberFormat.currency(locale: 'fr_FR', symbol: '€').format(soin.cout),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
    );
  }
}

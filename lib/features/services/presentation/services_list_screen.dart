import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'service_providers.dart';

class ServicesListScreen extends ConsumerWidget {
  const ServicesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(servicesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Services Hospitaliers'),
      ),
      body: servicesAsync.when(
        data: (services) => RefreshIndicator(
          onRefresh: () => ref.refresh(servicesListProvider.future),
          child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              final budgetRestant = service.budgetMensuel - service.coutActuel;
              final tauxUtilisation = (service.coutActuel / service.budgetMensuel * 100);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.nom,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      _buildBudgetRow(
                        'Budget mensuel',
                        service.budgetMensuel,
                        Colors.blue,
                      ),
                      _buildBudgetRow(
                        'Coût actuel',
                        service.coutActuel,
                        Colors.orange,
                      ),
                      _buildBudgetRow(
                        'Budget restant',
                        budgetRestant,
                        budgetRestant > 0 ? Colors.green : Colors.red,
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: tauxUtilisation / 100,
                        backgroundColor: Colors.grey[300],
                        color: tauxUtilisation > 90 ? Colors.red : Colors.green,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Taux d\'utilisation: ${tauxUtilisation.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 12,
                          color: tauxUtilisation > 90 ? Colors.red : Colors.green,
                        ),
                      ),
                    ],
                  ),
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

  Widget _buildBudgetRow(String label, double amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            NumberFormat.currency(locale: 'fr_FR', symbol: '€').format(amount),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

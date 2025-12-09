import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'patient_providers.dart';

class PatientsListScreen extends ConsumerWidget {
  const PatientsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/patients/new'),
          ),
        ],
      ),
      body: patientsAsync.when(
        data: (patients) => RefreshIndicator(
          onRefresh: () => ref.refresh(patientsListProvider.future),
          child: ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(patient.prenom[0] + patient.nom[0]),
                  ),
                  title: Text('${patient.prenom} ${patient.nom}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Né(e) le: ${DateFormat('dd/MM/yyyy').format(patient.dateNaissance)}'),
                      Text('Sécurité Sociale: ${patient.numeroSecuriteSociale}'),
                      Text(
                        'Coût total: ${NumberFormat.currency(locale: 'fr_FR', symbol: '€').format(patient.coutTotal)}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go('/patients/${patient.id}'),
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

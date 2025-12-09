import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'patient_providers.dart';
import '../../soins/presentation/soin_providers.dart';

class PatientDetailScreen extends ConsumerWidget {
  final String id;

  const PatientDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientAsync = ref.watch(patientDetailProvider(id));
    final soinsAsync = ref.watch(soinsByPatientProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails Patient'),
      ),
      body: patientAsync.when(
        data: (patient) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${patient.prenom} ${patient.nom}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow('Date de naissance', DateFormat('dd/MM/yyyy').format(patient.dateNaissance)),
                      _buildInfoRow('Sécurité Sociale', patient.numeroSecuriteSociale),
                      _buildInfoRow(
                        'Coût total',
                        NumberFormat.currency(locale: 'fr_FR', symbol: '€').format(patient.coutTotal),
                      ),
                      _buildInfoRow('Nombre de soins', '${patient.soinIds.length}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Historique des Soins',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              soinsAsync.when(
                data: (soins) => soins.isEmpty
                    ? const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Aucun soin enregistré'),
                        ),
                      )
                    : Column(
                        children: soins.map((soin) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(soin.typeSoin),
                            subtitle: Text(
                              DateFormat('dd/MM/yyyy HH:mm').format(soin.dateSoin),
                            ),
                            trailing: Text(
                              NumberFormat.currency(locale: 'fr_FR', symbol: '€').format(soin.cout),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Erreur: $err'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

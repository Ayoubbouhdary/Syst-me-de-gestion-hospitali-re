import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../domain/patient.dart';
import 'patient_providers.dart';

class PatientFormScreen extends ConsumerStatefulWidget {
  final String? id;

  const PatientFormScreen({super.key, this.id});

  @override
  ConsumerState<PatientFormScreen> createState() => _PatientFormScreenState();
}

class _PatientFormScreenState extends ConsumerState<PatientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _secuController = TextEditingController();
  DateTime? _dateNaissance;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _secuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? 'Nouveau Patient' : 'Modifier Patient'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nomController,
              decoration: const InputDecoration(labelText: 'Nom'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Champ requis' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _prenomController,
              decoration: const InputDecoration(labelText: 'Prénom'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Champ requis' : null,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _dateNaissance ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() => _dateNaissance = date);
                }
              },
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'Date de Naissance'),
                child: Text(
                  _dateNaissance == null
                      ? 'Sélectionner une date'
                      : DateFormat('dd/MM/yyyy').format(_dateNaissance!),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _secuController,
              decoration: const InputDecoration(labelText: 'Numéro Sécurité Sociale'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Champ requis' : null,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate() && _dateNaissance != null) {
      final patient = Patient(
        id: widget.id ?? '', // ID ignored on create
        nom: _nomController.text,
        prenom: _prenomController.text,
        dateNaissance: _dateNaissance!,
        numeroSecuriteSociale: _secuController.text,
      );

      try {
        if (widget.id == null) {
          await ref.read(patientControllerProvider.notifier).createPatient(patient);
        } else {
          await ref.read(patientControllerProvider.notifier).updatePatient(patient);
        }
        if (mounted) context.pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    } else if (_dateNaissance == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner une date de naissance')),
      );
    }
  }
}

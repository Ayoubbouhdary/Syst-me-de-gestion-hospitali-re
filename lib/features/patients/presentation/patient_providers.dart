import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/patient_repository_impl.dart';
import '../domain/patient.dart';
import '../domain/patient_repository.dart';

import '../../../core/network/dio_provider.dart';

part 'patient_providers.g.dart';

@riverpod
PatientRepository patientRepository(PatientRepositoryRef ref) {
  final dio = ref.watch(dioProvider);
  return PatientRepositoryImpl(dio);
}

@riverpod
Future<List<Patient>> patientsList(PatientsListRef ref) async {
  return ref.watch(patientRepositoryProvider).getPatients();
}

@riverpod
Future<Patient> patientDetail(PatientDetailRef ref, String id) async {
  return ref.watch(patientRepositoryProvider).getPatient(id);
}

@riverpod
class PatientController extends _$PatientController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }

  Future<void> createPatient(Patient patient) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => 
      ref.read(patientRepositoryProvider).createPatient(patient)
    );
    ref.invalidate(patientsListProvider);
  }

  Future<void> updatePatient(Patient patient) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => 
      ref.read(patientRepositoryProvider).updatePatient(patient)
    );
    ref.invalidate(patientsListProvider);
  }

  Future<void> deletePatient(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => 
      ref.read(patientRepositoryProvider).deletePatient(id)
    );
    ref.invalidate(patientsListProvider);
  }
}

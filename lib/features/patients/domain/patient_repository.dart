import 'patient.dart';

abstract class PatientRepository {
  Future<List<Patient>> getPatients();
  Future<Patient> getPatient(String id);
  Future<Patient> createPatient(Patient patient);
  Future<Patient> updatePatient(Patient patient);
  Future<void> deletePatient(String id);
  Future<List<Patient>> searchPatients(String query);
}

import 'package:dio/dio.dart';
import '../domain/patient.dart';
import '../domain/patient_repository.dart';

class PatientRepositoryImpl implements PatientRepository {
  final Dio _dio;

  PatientRepositoryImpl(this._dio);

  @override
  Future<Patient> createPatient(Patient patient) async {
    try {
      final response = await _dio.post('/patients', data: patient.toJson());
      return Patient.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create patient: $e');
    }
  }

  @override
  Future<void> deletePatient(String id) async {
    try {
      await _dio.delete('/patients/$id');
    } catch (e) {
      throw Exception('Failed to delete patient: $e');
    }
  }

  @override
  Future<Patient> getPatient(String id) async {
    try {
      final response = await _dio.get('/patients/$id');
      return Patient.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get patient: $e');
    }
  }

  @override
  Future<List<Patient>> getPatients() async {
    try {
      final response = await _dio.get('/patients');
      return (response.data as List)
          .map((json) => Patient.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get patients: $e');
    }
  }

  @override
  Future<List<Patient>> searchPatients(String query) async {
    try {
      final response = await _dio.get('/patients/search', queryParameters: {'q': query});
      return (response.data as List)
          .map((json) => Patient.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to search patients: $e');
    }
  }

  @override
  Future<Patient> updatePatient(Patient patient) async {
    try {
      final response = await _dio.put('/patients/${patient.id}', data: patient.toJson());
      return Patient.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update patient: $e');
    }
  }
}

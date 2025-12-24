import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_arch_app/features/patients/domain/patient.dart';
import 'package:clean_arch_app/features/patients/domain/patient_repository.dart';

class MockPatientRepository extends Mock implements PatientRepository {}

void main() {
  late MockPatientRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(
      Patient(
        id: '',
        nom: '',
        prenom: '',
        dateNaissance: DateTime(2000),
        numeroSecuriteSociale: '',
        coutTotal: 0,
        soinIds: [],
      ),
    );
  });

  setUp(() {
    mockRepo = MockPatientRepository();
  });

  test('getPatients returns list of patients', () async {
    final patients = [
      Patient(
        id: '1',
        nom: 'Dupont',
        prenom: 'Jean',
        dateNaissance: DateTime(1990, 1, 1),
        numeroSecuriteSociale: '123456789',
        coutTotal: 0,
        soinIds: [],
      ),
    ];
    when(() => mockRepo.getPatients()).thenAnswer((_) async => patients);
    final result = await mockRepo.getPatients();
    expect(result, isA<List<Patient>>());
    expect(result.length, 1);
    expect(result.first.nom, 'Dupont');
  });

  test('getPatient returns a patient', () async {
    final patient = Patient(
      id: '2',
      nom: 'Martin',
      prenom: 'Alice',
      dateNaissance: DateTime(1985, 5, 5),
      numeroSecuriteSociale: '987654321',
      coutTotal: 0,
      soinIds: [],
    );
    when(() => mockRepo.getPatient('2')).thenAnswer((_) async => patient);
    final result = await mockRepo.getPatient('2');
    expect(result.nom, 'Martin');
    expect(result.prenom, 'Alice');
  });

  test('createPatient returns created patient', () async {
    final patient = Patient(
      id: '3',
      nom: 'Test',
      prenom: 'Test',
      dateNaissance: DateTime(2000, 1, 1),
      numeroSecuriteSociale: '000000000',
      coutTotal: 0,
      soinIds: [],
    );
    when(() => mockRepo.createPatient(any())).thenAnswer((_) async => patient);
    final result = await mockRepo.createPatient(patient);
    expect(result.id, '3');
    expect(result.nom, 'Test');
  });

  test('deletePatient completes', () async {
    when(
      () => mockRepo.deletePatient('1'),
    ).thenAnswer((_) async => Future.value());
    await mockRepo.deletePatient('1');
    verify(() => mockRepo.deletePatient('1')).called(1);
  });
}

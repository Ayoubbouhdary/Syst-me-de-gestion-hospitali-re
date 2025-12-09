import '../domain/soin.dart';
import '../domain/soin_repository.dart';

class SoinRepositoryImpl implements SoinRepository {
  final List<Soin> _soins = [
    Soin(
      id: '1',
      patientId: '1',
      serviceId: '1',
      typeSoin: 'Consultation cardiologie',
      cout: 150.00,
      dateSoin: DateTime(2025, 1, 15, 10, 30),
      description: 'Consultation de routine',
    ),
    Soin(
      id: '2',
      patientId: '1',
      serviceId: '1',
      typeSoin: 'ECG',
      cout: 80.00,
      dateSoin: DateTime(2025, 1, 15, 11, 0),
      description: 'Électrocardiogramme',
    ),
    Soin(
      id: '3',
      patientId: '1',
      serviceId: '1',
      typeSoin: 'Échographie cardiaque',
      cout: 1020.50,
      dateSoin: DateTime(2025, 1, 20, 14, 0),
      description: 'Échographie doppler',
    ),
    Soin(
      id: '4',
      patientId: '2',
      serviceId: '2',
      typeSoin: 'Urgence',
      cout: 300.00,
      dateSoin: DateTime(2025, 1, 18, 22, 15),
      description: 'Prise en charge urgence',
    ),
    Soin(
      id: '5',
      patientId: '2',
      serviceId: '3',
      typeSoin: 'Radiographie',
      cout: 2040.75,
      dateSoin: DateTime(2025, 1, 19, 9, 0),
      description: 'Radio thorax',
    ),
    Soin(
      id: '6',
      patientId: '3',
      serviceId: '4',
      typeSoin: 'Consultation pédiatrie',
      cout: 890.00,
      dateSoin: DateTime(2025, 1, 22, 15, 30),
      description: 'Suivi vaccinal',
    ),
  ];

  @override
  Future<Soin> createSoin(Soin soin) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _soins.add(soin);
    return soin;
  }

  @override
  Future<void> deleteSoin(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _soins.removeWhere((s) => s.id == id);
  }

  @override
  Future<Soin> getSoin(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _soins.firstWhere((s) => s.id == id);
  }

  @override
  Future<List<Soin>> getSoins() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _soins;
  }

  @override
  Future<List<Soin>> getSoinsByPatient(String patientId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _soins.where((s) => s.patientId == patientId).toList();
  }

  @override
  Future<List<Soin>> getSoinsByService(String serviceId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _soins.where((s) => s.serviceId == serviceId).toList();
  }
}

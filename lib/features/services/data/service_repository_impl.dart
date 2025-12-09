import '../domain/service.dart';
import '../domain/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final List<Service> _services = [
    const Service(
      id: '1',
      nom: 'Cardiologie',
      budgetMensuel: 150000,
      budgetAnnuel: 1800000,
      coutActuel: 125340.50,
    ),
    const Service(
      id: '2',
      nom: 'Urgences',
      budgetMensuel: 200000,
      budgetAnnuel: 2400000,
      coutActuel: 187650.25,
    ),
    const Service(
      id: '3',
      nom: 'Chirurgie',
      budgetMensuel: 180000,
      budgetAnnuel: 2160000,
      coutActuel: 165890.75,
    ),
    const Service(
      id: '4',
      nom: 'Pédiatrie',
      budgetMensuel: 120000,
      budgetAnnuel: 1440000,
      coutActuel: 98450.00,
    ),
    const Service(
      id: '5',
      nom: 'Radiologie',
      budgetMensuel: 100000,
      budgetAnnuel: 1200000,
      coutActuel: 89230.50,
    ),
  ];

  @override
  Future<double> getBudgetRestant(String serviceId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final service = _services.firstWhere((s) => s.id == serviceId);
    return service.budgetMensuel - service.coutActuel;
  }

  @override
  Future<double> getCoutActuel(String serviceId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final service = _services.firstWhere((s) => s.id == serviceId);
    return service.coutActuel;
  }

  @override
  Future<Service> getService(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _services.firstWhere((s) => s.id == id);
  }

  @override
  Future<List<Service>> getServices() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _services;
  }
}

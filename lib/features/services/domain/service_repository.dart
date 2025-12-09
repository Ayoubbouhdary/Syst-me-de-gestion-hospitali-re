import 'service.dart';

abstract class ServiceRepository {
  Future<List<Service>> getServices();
  Future<Service> getService(String id);
  Future<double> getCoutActuel(String serviceId);
  Future<double> getBudgetRestant(String serviceId);
}

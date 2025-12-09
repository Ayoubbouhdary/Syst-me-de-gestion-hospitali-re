import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/service_repository_impl.dart';
import '../domain/service.dart';
import '../domain/service_repository.dart';

part 'service_providers.g.dart';

@riverpod
ServiceRepository serviceRepository(ServiceRepositoryRef ref) {
  return ServiceRepositoryImpl();
}

@riverpod
Future<List<Service>> servicesList(ServicesListRef ref) async {
  return ref.watch(serviceRepositoryProvider).getServices();
}

@riverpod
Future<Service> serviceDetail(ServiceDetailRef ref, String id) async {
  return ref.watch(serviceRepositoryProvider).getService(id);
}

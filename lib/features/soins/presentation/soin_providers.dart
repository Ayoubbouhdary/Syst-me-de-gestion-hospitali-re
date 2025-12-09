import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/soin_repository_impl.dart';
import '../domain/soin.dart';
import '../domain/soin_repository.dart';

part 'soin_providers.g.dart';

@riverpod
SoinRepository soinRepository(SoinRepositoryRef ref) {
  return SoinRepositoryImpl();
}

@riverpod
Future<List<Soin>> soinsList(SoinsListRef ref) async {
  return ref.watch(soinRepositoryProvider).getSoins();
}

@riverpod
Future<List<Soin>> soinsByPatient(SoinsByPatientRef ref, String patientId) async {
  return ref.watch(soinRepositoryProvider).getSoinsByPatient(patientId);
}

@riverpod
Future<List<Soin>> soinsByService(SoinsByServiceRef ref, String serviceId) async {
  return ref.watch(soinRepositoryProvider).getSoinsByService(serviceId);
}

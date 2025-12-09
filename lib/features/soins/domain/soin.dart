import 'package:freezed_annotation/freezed_annotation.dart';

part 'soin.freezed.dart';
part 'soin.g.dart';

@freezed
class Soin with _$Soin {
  const factory Soin({
    required String id,
    required String patientId,
    required String serviceId,
    required String typeSoin,
    required double cout,
    required DateTime dateSoin,
    String? description,
  }) = _Soin;

  factory Soin.fromJson(Map<String, dynamic> json) => _$SoinFromJson(json);
}

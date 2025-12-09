// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SoinImpl _$$SoinImplFromJson(Map<String, dynamic> json) => _$SoinImpl(
  id: json['id'] as String,
  patientId: json['patientId'] as String,
  serviceId: json['serviceId'] as String,
  typeSoin: json['typeSoin'] as String,
  cout: (json['cout'] as num).toDouble(),
  dateSoin: DateTime.parse(json['dateSoin'] as String),
  description: json['description'] as String?,
);

Map<String, dynamic> _$$SoinImplToJson(_$SoinImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'patientId': instance.patientId,
      'serviceId': instance.serviceId,
      'typeSoin': instance.typeSoin,
      'cout': instance.cout,
      'dateSoin': instance.dateSoin.toIso8601String(),
      'description': instance.description,
    };

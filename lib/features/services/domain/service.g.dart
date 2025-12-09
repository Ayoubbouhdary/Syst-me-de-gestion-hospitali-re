// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceImpl _$$ServiceImplFromJson(Map<String, dynamic> json) =>
    _$ServiceImpl(
      id: json['id'] as String,
      nom: json['nom'] as String,
      budgetMensuel: (json['budgetMensuel'] as num).toDouble(),
      budgetAnnuel: (json['budgetAnnuel'] as num).toDouble(),
      coutActuel: (json['coutActuel'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$ServiceImplToJson(_$ServiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'budgetMensuel': instance.budgetMensuel,
      'budgetAnnuel': instance.budgetAnnuel,
      'coutActuel': instance.coutActuel,
    };

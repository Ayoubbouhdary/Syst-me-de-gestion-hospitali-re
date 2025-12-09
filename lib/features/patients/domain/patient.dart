import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient.freezed.dart';
part 'patient.g.dart';

@freezed
class Patient with _$Patient {
  const factory Patient({
    required String id,
    required String nom,
    required String prenom,
    required DateTime dateNaissance,
    required String numeroSecuriteSociale,
    @Default(0.0) double coutTotal,
    @Default([]) List<String> soinIds,
  }) = _Patient;

  factory Patient.fromJson(Map<String, dynamic> json) {
    // Handle ID conversion from int (backend) to String (frontend)
    if (json['id'] is int) {
      json['id'] = json['id'].toString();
    }
    return _$PatientFromJson(json);
  }
}

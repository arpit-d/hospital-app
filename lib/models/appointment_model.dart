import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String type;
  final String speciality;
  final String date;
  final String note;
  const AppointmentModel({this.speciality, this.type, this.date, this.note});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      type: json['type'] ?? '',
      date: json['date'] ?? '',
      note: json['note'] ?? '',
      speciality: json['speciality'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'date': date,
      'note': note,
      'speciality': speciality,
    };
  }
}

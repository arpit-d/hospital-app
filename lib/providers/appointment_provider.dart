import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hospital_app/models/appointment_model.dart';
import 'package:hospital_app/services/firebase_database.dart';

class AppointmentProvider extends ChangeNotifier {
  final _database = Database();
  DateTime _date;
  String _speciality;
  String _type;
  String _note;

  // Setters

  set changeApptDate(DateTime appointmentDate) {
    _date = appointmentDate;
    notifyListeners();
  }

  set changeSpeciality(String speciality) {
    _speciality = speciality;
    notifyListeners();
  }

  set changeType(String type) {
    _type = type;
    notifyListeners();
  }

  set changeNote(String note) {
    _note = note;
    notifyListeners();
  }
  // Getters

  String get speciality => _speciality;

  String get type => _type;

  DateTime get date => _date;

  String get note => _note;

  bookAppointment() {
    final appt = AppointmentModel(
        speciality: _speciality,
        date: _date.toIso8601String(),
        note: _note,
        type: _type);

    _database.setAppointment(appt);
  }
}

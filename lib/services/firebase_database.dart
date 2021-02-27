import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hospital_app/models/appointment_model.dart';

// collection("User").get().then((QuerySnapshot q){var docs = q.data.docs;   iterate docs and get docs[index]["field"]});
// for uid docs[index].uid

class Database {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final uid = FirebaseAuth.instance.currentUser.uid;

  // set appts
  Future<void> setAppointment(AppointmentModel appt) async =>
      await _firebaseFirestore
          .collection("DoctorAppointments")
          .doc(uid)
          .collection("DoctorAppointmentsList")
          .doc()
          .set(
            appt.toMap(),
          );

  Stream<List<AppointmentModel>> getAppointments() {
    return _firebaseFirestore
        .collection("DoctorAppointments")
        .doc(uid)
        .collection("DoctorAppointmentsList")
        .snapshots()
        .map((snapShot) => snapShot.docs
            .map((document) => AppointmentModel.fromJson(document.data()))
            .toList());
  }
}

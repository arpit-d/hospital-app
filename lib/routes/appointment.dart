import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/authentication/authentication_service.dart';
import 'package:hospital_app/models/appointment_model.dart';

import 'package:hospital_app/providers/appointment_provider.dart';
import 'package:hospital_app/resources/constants.dart';
import 'package:hospital_app/routes/test.dart';
import 'package:hospital_app/services/firebase_database.dart';
import 'package:hospital_app/services/locator.dart';

import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Appointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('built 1');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(LineAwesomeIcons.hospital_o),
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookAppointment(),
                ),
              )),
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
             context.read<AuthenticationService>().signOut();
            },
            child: Text("Sign out"),
          ),
        ],
        title: Text(
          'Your Scheduled Appointments',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: Consumer<List<AppointmentModel>>(
        builder: (context, appt, child) {
          List l = [];
          print('built 2');
          if (appt == null) {
            return Center(child: CircularProgressIndicator());
          }
          appt.forEach((element) {
            if (element.speciality == 'Pediatric') l.add(element);
          });
          print(l);
          return ListView.builder(
            itemCount: appt.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(appt[index].speciality),
                subtitle: Text(appt[index].type),
              );
            },
          );
        },
      ),
    );
  }
}

class BookAppointment extends StatelessWidget {
  Future<DateTime> _pickDate(
      BuildContext context, AppointmentProvider appointmentProvider) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );

    if (picked != null) {
      dateCont.text = DateFormat('yyyy-MM-dd').format(picked);
      appointmentProvider.changeApptDate = picked;
    }
    return picked;
  }

  final TextEditingController dateCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Book An Appointment',
          style: TextStyle(color: Colors.green),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            appointmentDataPicker(
              onChanged: (newValue) {
                appointmentProvider.changeSpeciality = newValue;
              },
              value: appointmentProvider.speciality,
              list: appointmentSpecialities,
              labelText: 'Appointment Speciality',
            ),
            appointmentDataPicker(
              onChanged: (newValue) {
                appointmentProvider.changeType = newValue;
              },
              value: appointmentProvider.type,
              list: appointmentTypes,
              labelText: 'Appointment Type',
            ),
            TextFormField(
              controller: dateCont,
              onChanged: (value) {
                appointmentProvider.changeApptDate = DateTime.parse(value);
              },
              decoration: const InputDecoration(
                labelText: 'Date',
                suffixIcon: Icon(LineAwesomeIcons.calendar),
              ),
              readOnly: true,
              onTap: () {
                _pickDate(context, appointmentProvider);
              },
            ),
            TextFormField(
              onChanged: (value) {
                appointmentProvider.changeNote = value;
              },
              minLines: 1,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              maxLengthEnforced: true,
              decoration: const InputDecoration(
                hintText: 'Describe any symptoms or problems you face',
                labelText: 'Notes',
                suffixIcon: Icon(LineAwesomeIcons.sticky_note),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              child: const Text(
                'Book Appointment',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
              onPressed: () {
                appointmentProvider.bookAppointment();
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> appointmentDataPicker({
    @required String value,
    @required List<String> list,
    @required labelText,
    @required onChanged,
  }) {
    return DropdownButtonFormField(
      items: list.map((String category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: onChanged,
      value: value,
      decoration: InputDecoration(
        labelText: '$labelText',
      ),
    );
  }
}

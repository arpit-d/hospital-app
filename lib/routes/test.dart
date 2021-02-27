import 'package:flutter/material.dart';
import 'package:hospital_app/models/appointment_model.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class AppointmentTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(LineAwesomeIcons.hospital_o),
        onPressed: () {},
      ),
      appBar: AppBar(),
      body: Consumer<List<AppointmentModel>>(
        builder: (context, appt, child) {
          if (appt == null) {
            return Center(child: CircularProgressIndicator());
          }
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

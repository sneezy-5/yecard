import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/delivery_bloc.dart';
import '../../../bloc/delivery_event.dart';
import '../../../bloc/delivery_state.dart';
import '../../../routes.dart';




class DeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            AppRoutes.pushReplacement(context, AppRoutes.appHome);
          },
        ),
        title: Text(
          'Lieu de livraison',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
    padding: EdgeInsets.zero,
    children: [ Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dropdown for delivery zone
            BlocBuilder<DeliveryBloc, DeliveryState>(
              builder: (context, state) {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Choisissez où vous faire livrer',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  value: state.selectedZone.isEmpty ? null : state.selectedZone,
                  items: <String>['Zone 1', 'Zone 2', 'Zone 3']
                      .map((zone) => DropdownMenuItem<String>(
                    value: zone,
                    child: Text(zone),
                  ))
                      .toList(),
                  onChanged: (newValue) {
                    context.read<DeliveryBloc>().add(ZoneChanged(newValue!));
                  },
                );
              },
            ),
            SizedBox(height: 16),

            // Text field for reference point
            BlocBuilder<DeliveryBloc, DeliveryState>(
              builder: (context, state) {
                return TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Point de référence',
                    hintText: 'Exemple : Cap Sud',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    context.read<DeliveryBloc>().add(ReferenceChanged(value));
                  },
                );
              },
            ),
            SizedBox(height: 16),

            // Text field for card number
            BlocBuilder<DeliveryBloc, DeliveryState>(
              builder: (context, state) {
                return TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Nombre d'exemplaire de carte",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  initialValue: state.cardNumber,
                  onChanged: (value) {
                    context.read<DeliveryBloc>().add(CardNumberChanged(value));
                  },
                );
              },
            ),
            SizedBox(height: 16),

            // Text field for phone number
            BlocBuilder<DeliveryBloc, DeliveryState>(
              builder: (context, state) {
                return TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Numéro de reception',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  initialValue: state.phoneNumber,
                  onChanged: (value) {
                    context.read<DeliveryBloc>().add(PhoneNumberChanged(value));
                  },
                );
              },
            ),
            SizedBox(height: 100),

            // Continue button
            ElevatedButton(
              onPressed: () {
                // Action when Continue button is pressed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Continuer',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
  ]),
    ),
    );
  }
}

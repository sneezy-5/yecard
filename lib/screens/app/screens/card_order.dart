

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/delivery_bloc.dart';
import '../../../bloc/delivery_event.dart';
import '../../../bloc/delivery_state.dart';
import '../../../models/delivery_zone.dart';
import '../../../repositories/delivery_repository.dart';
import '../../../services/delivery_service.dart';
import '../../../routes.dart';
import '../../../widgets/popup_widgets.dart';

class DeliveryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeliveryBloc(DeliveryRepository(DeliveryService())),
      child: DeliveryView(),
    );
  }
}

class DeliveryView extends StatelessWidget {
  final TextEditingController referenceController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController lieuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            AppRoutes.pushReplacement(context, AppRoutes.appHome);
          },
        ),
        title: const Text(
          'Lieu de livraison',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocListener<DeliveryBloc, DeliveryState>(
        listenWhen: (previous, current) => previous.isSuccess != current.isSuccess || previous.errorMessages != current.errorMessages,
        listener: (context, state) {
          if (state.isSuccess) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomPopup(
                  title: 'Succès',
                  content: "Votre commande a ete cree avec succes",
                  buttonText: 'ok',
                  onButtonPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/app/home');
                    // AppRoutes.pushReplacement(context, AppRoutes.appHome);
                  },
                );
              },
            );
            // AppRoutes.pushReplacement(context, AppRoutes.appHome);
          } else if (state.errorMessages.isNotEmpty) {
            final errorMessage = state.errorMessages.entries
                .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
                .join('\n');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage)),
            );
          }
        },
        child: BlocBuilder<DeliveryBloc, DeliveryState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informations de Livraison',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    // Sélection de la zone de livraison
                    TextFormField(
                      controller: lieuController,
                      decoration: InputDecoration(
                        errorText: state.errorMessages['lieu']?.join(', '),
                        labelText: 'Choisissez où vous faire livrer',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                    ),
                    const SizedBox(height: 20),

                    // Champ de texte pour le point de référence
                    TextFormField(
                      controller: referenceController,
                      decoration: InputDecoration(
                        errorText: state.errorMessages['reference']?.join(', '),
                        labelText: 'Point de référence',
                        hintText: 'Exemple : Cap Sud',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Champ pour le nombre de cartes
                    TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        errorText: state.errorMessages['nbr_cart']?.join(', '),
                        labelText: "Nombre d'exemplaires de cartes",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                    ),
                    const SizedBox(height: 20),

                    // Champ pour le numéro de téléphone
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        errorText: state.errorMessages['phone']?.join(', '),
                        labelText: 'Numéro de réception',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                    ),
                    const SizedBox(height: 100),

                    // Bouton "Continuer"
                    Center(
                      child: ElevatedButton(
                        onPressed: state.isLoading
                            ? null
                            : () {
                          final deliveryZone = DeliveryZone(
                            f_user: 1,
                            lieu: lieuController.text,
                            reference: referenceController.text,
                            nbr_cart: cardNumberController.text,
                            phone: phoneController.text,
                          );
                          context.read<DeliveryBloc>().add(DeliveryZoneChanged(deliveryZone));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric( horizontal: 50, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: state.isLoading
                            ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                            : const Text(
                          'Continuer',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

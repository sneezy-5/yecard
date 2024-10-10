import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yecard/models/card_model.dart';

import '../../../bloc/link_card_bloc.dart';
import '../../../bloc/link_card_event.dart';
import '../../../bloc/link_card_state.dart';
import '../../../repositories/card_repository.dart';
import '../../../services/card_service.dart';
import '../../../widgets/popup_widgets.dart';

class LinkCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LinkCardBloc(CardRepository(CardService())),
      child: LinkCardWiev(),
    );
  }
}
class LinkCardWiev extends StatefulWidget {
  @override
  _LinkCardScreenState createState() => _LinkCardScreenState();
}

class _LinkCardScreenState extends State<LinkCardWiev> {
  String cardNumber = '';

  void _onNumberTap(String number) {
    setState(() {
      if (cardNumber.length < 16) {
        cardNumber += number;
      }
    });
  }

  void _onDeleteTap() {
    setState(() {
      if (cardNumber.isNotEmpty) {
        cardNumber = cardNumber.substring(0, cardNumber.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<LinkCardBloc, LinkCardState>(
            listener: (context, state) {
              if (state.isSuccess) {
              } else if (state.errorMessage.isNotEmpty) {
                final errorMessage = state.errorMessage;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomPopup(
                      title: 'Succès',
                      content: "Votre carte a ete ajoute avec succes",
                      buttonText: 'ok',
                      onButtonPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed('/app/home');
                        // AppRoutes.pushReplacement(context, AppRoutes.appHome);
                      },
                    );
                  },
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorMessage)),
                );
              }else if (state.errorMessages.isNotEmpty) {
                final errorMessage = state.errorMessages.entries
                    .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
                    .join('\n');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorMessage)),
                );
              }
            },
            builder: (context, state) {
              return         Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Lier ma carte',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Entrer le numéro inscrit sur la carte',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child: TextField(
                      readOnly: true,
                      style: const TextStyle(fontSize: 20, letterSpacing: 2),
                      decoration:  InputDecoration(
                        errorText: state.errorMessages['number']?.join(', '),
                        hintText: 'Insérer le numéro de la carte',
                        border: InputBorder.none,
                      ),
                      controller: TextEditingController(text: cardNumber),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // ElevatedButton(
                  //   onPressed: () {
                  //
                  //     if (cardNumber.length == 16) {
                  //       // Navigate to the next screen
                  //     }
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.green,
                  //     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   child: const Text(
                  //     'Continuer',
                  //     style: TextStyle(fontSize: 18, color: Colors.white),
                  //   ),
                  // ),
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () {
                      final cardData = CardData(
                        number: cardNumber,
                      );

                      context
                          .read<LinkCardBloc>()
                          .add(SubmitCard(cardData));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: state.isLoading
                        ? const CircularProgressIndicator(
                      valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : const Text(
                      'Enregistrer',
                      style: TextStyle(
                          fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Spacer(),
                  _buildNumberPad(),
                ],
              );
            })


      ),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('1'),
            _buildNumberButton('2'),
            _buildNumberButton('3'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('4'),
            _buildNumberButton('5'),
            _buildNumberButton('6'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('7'),
            _buildNumberButton('8'),
            _buildNumberButton('9'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNumberButton('0'),
            _buildDeleteButton(),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => _onNumberTap(number),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: _onDeleteTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: const Center(
          child: Icon(Icons.backspace, size: 24),
        ),
      ),
    );
  }
}



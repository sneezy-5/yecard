import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';
import '../repositories/login_repository.dart';
import '../repositories/signup_repository.dart';
import '../routes.dart';
import '../services/login_service.dart';
import '../services/signup_service.dart';
import '../widgets/popup_widgets.dart';
import '../widgets/text_form_field.dart';

class SignupScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(SignupRepository(SignupService())),
      child: SignupView(),
    );
  }
}

class SignupView extends StatelessWidget {
  final LoginRepository loginRepository = LoginRepository(LoginService());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController functionController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController conditionController = TextEditingController(
      text: "Politique de Confidentialité et Conditions d'Utilisation de YéCard\n"
          "Dernière mise à jour : 1er novembre 2024\n\n"
          "Bienvenue sur YéCard, une plateforme de cartes de visite numériques innovantes ! "
          "Nous nous engageons à protéger vos informations personnelles et à offrir une expérience utilisateur sécurisée. "
          "En utilisant notre application et nos services, vous acceptez les termes suivants.\n\n"

          "1. Collecte et Utilisation des Données\n"
          "1.1 Données Collectées\n"
          "Pour une expérience optimale, YéCard peut collecter plusieurs types de données :\n"
          "• Informations d'identification personnelle : nom, numéro de téléphone, adresse email, profession, entreprise, etc., nécessaires pour personnaliser votre carte de visite.\n"
          "• Informations techniques : adresse IP, type d'appareil, système d'exploitation, utilisées pour améliorer notre service et assurer la sécurité de la plateforme.\n"
          "• Données d'utilisation : interactions avec l'application, préférences, et historique d'utilisation, afin d’optimiser l’expérience et de fournir un meilleur service.\n\n"

          "1.2 Finalités de la Collecte\n"
          "Les données collectées sont utilisées pour :\n"
          "• Créer et gérer votre compte et carte de visite numérique ;\n"
          "• Améliorer la sécurité et la performance de l’application ;\n"
          "• Personnaliser votre expérience utilisateur et vous fournir des services adaptés ;\n"
          "• Répondre à vos questions et vous fournir une assistance.\n\n"

          "2. Partage des Informations\n"
          "Vos données ne seront jamais vendues, échangées ou transférées sans votre consentement, sauf dans les cas suivants :\n"
          "• Prestataires de services tiers : nous pouvons partager des informations avec des partenaires de confiance qui nous aident à opérer notre plateforme (hébergement, service client), dans le strict respect de la confidentialité des données.\n"
          "• Conformité légale : nous pourrions être amenés à divulguer vos informations en réponse à des exigences légales.\n\n"

          "3. Sécurité des Données\n"
          "Nous mettons en œuvre des mesures de sécurité rigoureuses pour protéger vos informations personnelles. Vos données sont stockées sur des serveurs sécurisés et seuls les employés autorisés peuvent y accéder dans le cadre de leurs fonctions.\n\n"

          "4. Droits des Utilisateurs\n"
          "Vous avez le droit de :\n"
          "• Accéder à vos informations personnelles ;\n"
          "• Demander la correction ou la suppression de vos données ;\n"
          "• Retirer votre consentement au traitement de vos données à tout moment.\n"
          "Pour exercer ces droits, contactez notre support à l'adresse suivante : support@yecard.pro.\n\n"

          "5. Utilisation Acceptable de YéCard\n"
          "En utilisant YéCard, vous vous engagez à :\n"
          "• Ne pas utiliser la plateforme pour des activités frauduleuses, illégales ou non autorisées ;\n"
          "• Respecter la vie privée et les données des autres utilisateurs ;\n"
          "• Ne pas tenter de perturber ou compromettre la sécurité de la plateforme.\n"
          "Toute violation de ces règles peut entraîner la suspension ou la résiliation de votre compte.\n\n"

          "6. Cookies et Technologies Similaires\n"
          "YéCard utilise des cookies pour collecter des informations non personnelles afin d’améliorer votre expérience. Vous pouvez gérer vos préférences en matière de cookies via les paramètres de votre navigateur.\n\n"

          "7. Modifications de la Politique\n"
          "Nous nous réservons le droit de modifier cette politique de confidentialité et d'utilisation. Les changements seront notifiés via l'application et mis à jour sur notre site. Nous vous encourageons à consulter régulièrement cette page pour rester informé des mises à jour.\n\n"

          "8. Contact\n"
          "Pour toute question ou demande concernant cette politique de confidentialité et d'utilisation, veuillez nous contacter à :\n"
          "Email :\n"
          "Adresse : YéCard, Abidjan Cocody Côte d'Ivoire.\n\n"

          "En utilisant YéCard, vous confirmez avoir lu et accepté cette politique de confidentialité et les conditions d’utilisation."
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Nombre d'étapes
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBarWidget(),
        ),
        body: BlocListener<SignupBloc, SignupState>(
          listenWhen: (previous, current) => previous.currentStep != current.currentStep || previous.isSuccess != current.isSuccess || previous.errorMessages != current.errorMessages,
          listener: (context, state) {
            if (state.isSuccess) {
              final loginData = LoginModelData(email: emailController.text, password: "password");
              loginRepository.login(loginData);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  // Check if the cardNumberController has some text
                  if (cardNumberController.text.isNotEmpty && state.hasCard) {
                    return CustomPopup(
                      title: 'Succès',
                      content: "Votre carte numéroté ${cardNumberController.text} a été liée à votre compte avec succès. Vous pouvez bénéficier de tous les avantages de notre service.",
                      buttonText: 'OK',
                      onButtonPressed: () {
                        Navigator.of(context).pop();
                        AppRoutes.pushReplacement(context, AppRoutes.createPassword);
                      },
                    );
                  } else {
                    return CustomPopup(
                      title: 'Succès',
                      content: "Votre compte a été créé avec succès.",
                      buttonText: 'OK',
                      onButtonPressed: () {
                        Navigator.of(context).pop();
                        AppRoutes.pushReplacement(context, AppRoutes.createPassword);
                      },
                    );
                  }
                },
              );

            } else if (state.errorMessages.isNotEmpty) {
              final errorMessage = state.errorMessages.entries
                  .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
                  .join('\n');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(errorMessage)),
              );
            } else if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );

            }

            DefaultTabController.of(context)?.animateTo(state.currentStep - 1);
          },
          child: BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) {
              switch (state.currentStep) {
                case 1:
                  return _buildStepOne(context, state);
                case 2:
                  return _buildStepTwo(context, state);
                case 3:
                  return _buildStepThree(context, state);
                default:
                  return _buildStepOne(context, state);
              }
            },
          ),
        ),

      ),
    );
  }

  Widget _buildStepOne(BuildContext context, SignupState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Détail personnel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Nom et prénom',
              textController: nameController,
              errorText: state.errorMessages['name']?.join(', '),
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Fonction',
              textController: functionController,
              errorText: state.errorMessages['fonction']?.join(', '), // Erreur associée à la fonction
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              hintText: 'Entreprise',
              textController: companyController,
              errorText: state.errorMessages['entreprise']?.join(', '), // Erreur associée à l'entreprise
            ),
            SizedBox(height: 10),
            const Text(
              'Biographie',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              hintText: 'Décrivez-vous',
              maxLines: 4,
              textController: bioController,
              errorText: state.errorMessages['biography']?.join(', '), // Erreur associée à la biographie
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<SignupBloc>().add(NextStep());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text('Continuer', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepTwo(BuildContext context, SignupState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                Text(
                  'Contacts',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
              ],
            ),
            CustomTextFormField(
              hintText: 'Numéro',
              textController: phoneController,
              errorText: state.errorMessages['phone']?.join(', '),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              hintText: 'Email',
              textController: emailController,
              errorText: state.errorMessages['email']?.join(', '),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              hintText: 'Localisation',
              textController: locationController,
              errorText: state.errorMessages['localisation']?.join(', '),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<SignupBloc>().add(BackStep());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text('Retour', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignupBloc>().add(NextStep());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text('Continuer', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildStepThree(BuildContext context, SignupState state) {
    final hasCard = context.watch<SignupBloc>().state.hasCard;
    final condition = context.watch<SignupBloc>().state.condition;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/images/card.png', width: 168, height: 140),
            ),
            SizedBox(height: 20),
            Text(
              'Lier ma carte physique',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: hasCard,
                  onChanged: (bool? value) {
                    context.read<SignupBloc>().add(HaveCardChanged(value ?? false));
                  },
                ),
                Text("J'ai une carte physique"),
              ],
            ),

            if (hasCard)
              CustomTextFormField(
                hintText: 'Insérer le numéro de la carte',
                textController: cardNumberController,
                errorText: state.errorMessages['cardNumber']?.join(', '),
              ),
            SizedBox(height: 10),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Row(
              children: [
                Checkbox(
                  value: condition,
                  onChanged: (bool? value) {
                    context.read<SignupBloc>().add(HaveConditionChanged(value ?? false));
                  },
                ),
                Text(
                  "Accepter les conditions de confidentialité et d’utilisation ",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
            // Affiche le champ conditions
            CustomTextFormField(
              hintText: '',
              maxLines: 5,
              textController: conditionController,
              readOnly: true,
              errorText: state.errorMessages['conditions']?.join(', '),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<SignupBloc>().add(BackStep());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text('Retour', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: !condition || context.watch<SignupBloc>().state.isLoading
                      ? null // Désactiver le bouton si les conditions ne sont pas acceptées ou si en chargement
                      : () {
                    String name = nameController.text;
                    String function = functionController.text;
                    String company = companyController.text;
                    String bio = bioController.text;
                    String phone = phoneController.text;
                    String email = emailController.text;
                    String location = locationController.text;
                    String cardNumber = cardNumberController.text;

                    final signupData = SignupData(
                      name: name,
                      fonction: function,
                      entreprise: company,
                      biographie: bio,
                      phone: phone,
                      email: email,
                      localisation: location,
                      hasCard: hasCard,
                      cardNumber: hasCard==true ? cardNumber : null,
                      password: 'password',
                    );

                    context.read<SignupBloc>().add(SubmitSignup(signupData));

                    // login state
                    final loginData = LoginModelData(email: email, password: "password");
                    loginRepository.login(loginData) ;

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: context.watch<SignupBloc>().state.isLoading
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text('Continuer', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}

class TabBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return const TabBar(
          indicatorColor: Colors.green,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: 'Niveau 1'),
            Tab(text: 'Niveau 2'),
            Tab(text: 'Niveau 3'),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

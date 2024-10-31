import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yecard/models/login_model.dart';
import 'package:yecard/services/login_service.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';
import '../models/signup_model.dart';
import '../repositories/login_repository.dart';
import '../repositories/signup_repository.dart';
import '../routes.dart';
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
  final TextEditingController conditionController = TextEditingController(text: "Accepter les conditions de confidentialité et d’utilisation...");

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
                  if (cardNumberController.text.isNotEmpty) {
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

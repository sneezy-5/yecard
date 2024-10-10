import 'package:equatable/equatable.dart';

import '../models/card_model.dart';

abstract class LinkCardEvent extends Equatable {
  const LinkCardEvent();

  @override
  List<Object?> get props => [];
}
class FetchCard extends LinkCardEvent {}

class NumberAdded extends LinkCardEvent {
  final String number;

  const NumberAdded(this.number);

  @override
  List<Object?> get props => [number];
}

class NumberDeleted extends LinkCardEvent {
  const NumberDeleted();

  @override
  List<Object?> get props => [];
}

class SubmitCard extends LinkCardEvent {
  final CardData cardData;

  const SubmitCard(this.cardData);

  @override
  List<Object?> get props => [cardData];
}

class CardLoading extends LinkCardEvent {}

class CardLoaded extends LinkCardEvent {
  final CardData cardData;

  const CardLoaded({required this.cardData});

  @override
  List<Object> get props => [cardData];
}
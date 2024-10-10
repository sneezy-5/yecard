import '../models/card_model.dart';
import '../services/card_service.dart';

class CardRepository {
  final CardService _cardService;

  CardRepository(this._cardService);

  Future<Map<String, dynamic>> addCard(CardData cardData) async {
    return await _cardService.addCard(cardData);
  }

  Future<Map<String, dynamic>> getCard() async {
    return await _cardService.getCard();
  }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import domain.Card;
import da.CardDA;
import java.util.List;

/**
 *
 * @author superme
 */
public class CardControl {

    CardDA cardDA;

    public CardControl() {
        cardDA = new CardDA();
    }

    public boolean insertCard(Card card, int user_id) {
        return cardDA.insertCard(card, user_id);
    }

    public List<Card> retrieveCards(int user_id) {
        return cardDA.retrieveCards(user_id);
    }

    public Card retrieveCard(int id) {
        return cardDA.retrieveCard(id);
    }

    public Card retrieveLatestCard(int user_id) {
        return cardDA.retrieveLatestCard(user_id);
    }

    public boolean updateCard(Card card) {
        return cardDA.updateCard(card);
    }

    public boolean deleteCard(int id) {
        return cardDA.deleteCard(id);
    }

    public void destroy() {
        cardDA.destroy();
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import da.CartDA;
import domain.Cart;
import java.util.List;

/**
 *
 * @author superme
 */
public class CartControl {

    private CartDA cartDA;

    public CartControl() {
        cartDA = new CartDA();
    }

    public boolean insertCart(Cart cart) {
        return cartDA.insertCart(cart);
    }

    public List<Cart> retrieveCartALL(int user_id) {
        return cartDA.retrieveCartALL(user_id);
    }

    public Cart retrieveCart(int user_id, int product_id) {
        return cartDA.retrieveCart(user_id, product_id);
    }

    public boolean updateCart(Cart cart) {
        return cartDA.updateCart(cart);
    }

    public boolean deleteCart(int user_id, int product_id) {
        return cartDA.deleteCart(user_id, product_id);
    }
}

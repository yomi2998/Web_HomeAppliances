/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import da.ProductDA;
import domain.Product;
import java.util.List;
/**
 *
 * @author Nelson
 */
public class ProductControl {
    
    private ProductDA productDA;
    
    public ProductControl() {
        productDA = new ProductDA();
    }
    
    public boolean insertProduct(Product product) {
        return productDA.insertProduct(product);
    }
    
    public List<Product> retrieveProduct(int prodId) {
        return productDA.retrieveProduct(prodId);
    }
    
    public boolean updateProduct(Product product) {
        return productDA.updateProduct(product);
    }
    
    public boolean deleteProduct(int prodId) {
        return productDA.deleteProduct(prodId);
    }

    public int countTotalSales() {
        return productDA.countTotalSales();
    }

    public double countTotalEarned() {
        return productDA.countTotalEarned();
    }
    
    public void destroy() {
        productDA.destroy();
    }
}

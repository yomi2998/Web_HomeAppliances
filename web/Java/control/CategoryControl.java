/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;
import domain.Category;
import da.CategoryDA;
import java.util.List;
/**
 *
 * @author superme
 */
public class CategoryControl {
    private CategoryDA categoryDA;

    public CategoryControl() {
        categoryDA = new CategoryDA();
    }

    public boolean insertCategory(Category category) {
        return categoryDA.insertCategory(category);
    }

    public List<Category> retrieveCustomer() {
        return categoryDA.retrieveCategory();
    }

    public boolean updateCustomer(Category category) {
        return categoryDA.updateCategory(category);
    }

    public boolean deleteCategory(int id) {
        return categoryDA.deleteCategory(id);
    }
}

package manager;

import entity.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.transaction.UserTransaction;
import java.util.List;

public class CategoryManager {

    private EntityManager em;

    private UserTransaction utx;

    public CategoryManager() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("nelsonPU");
        em = emf.createEntityManager();
    }

    public int createCategory(Category category) {
        EntityTransaction et = em.getTransaction();

        try {
            et.begin();
            em.persist(category);
            em.flush();
            et.commit();
            return category.getId();
        } catch (Exception e) {
            if (et != null && et.isActive()) {
                et.rollback();
            }
            e.printStackTrace();
            return -1;
        }
    }

    public Category retrieveCategory(int id) {
        Category category = null;

        try {
            category = em.find(Category.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return category;
    }

    public boolean updateCategory(Category category) {
        EntityTransaction et = em.getTransaction();

        try {
            et.begin();
            em.merge(category);
            et.commit();
            return true;
        } catch (Exception e) {
            if (et != null && et.isActive()) {
                et.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCategory(int id) {
        EntityTransaction et = em.getTransaction();

        try {
            et.begin();
            Category category = em.find(Category.class, id);
            em.remove(category);
            et.commit();
            return true;
        } catch (Exception e) {
            if (et != null && et.isActive()) {
                et.rollback();
            }
            e.printStackTrace();
            return false;
        }
    }

    public List<Category> retrieveCategory() {

        List<Category> categories = null;

        try {
            categories = em.createNamedQuery("Category.findAll", Category.class).getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }

    public String getCategoryById(int id) {
        Category category = null;

        try {
            category = em.createNamedQuery("Category.findById", Category.class).setParameter("id", id).getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return category.getName();
    }
}

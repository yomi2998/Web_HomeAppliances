package manager;

import entity.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.transaction.UserTransaction;
import java.util.List;

import domain.Order;

public class OrderStatusManager {

    private EntityManager em;

    private UserTransaction utx;

    public OrderStatusManager() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("nelsonPU");
        em = emf.createEntityManager();
    }

    public boolean insertStatus(OrderStatus orderStatus) {
        EntityTransaction et = em.getTransaction();

        try {
            et.begin();
            em.persist(orderStatus);
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

    public List<OrderStatus> getOrderStatus(int id) {

        List<OrderStatus> status = null;

        try {
            status = em.createNamedQuery("OrderStatus.findById")
                    .setParameter("id", id)
                    .getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}

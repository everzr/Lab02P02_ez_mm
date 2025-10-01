package Controladores;

import Controladores.exceptions.NonexistentEntityException;
import Controladores.exceptions.RollbackFailureException;
import Entity.Reservaciones;
import java.io.Serializable;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.UserTransaction;

public class ReservacionesJpaController implements Serializable {
    @Resource
    private UserTransaction utx; // Not used with RESOURCE_LOCAL, kept for parity

    private final EntityManagerFactory emf;

    public ReservacionesJpaController() { this.emf = Persistence.createEntityManagerFactory("my_persistence_unit"); }
    public ReservacionesJpaController(UserTransaction utx) { this(); this.utx = utx; }
    public ReservacionesJpaController(UserTransaction utx, EntityManagerFactory emf) { this.utx = utx; this.emf = emf; }

    public EntityManager getEntityManager() { return emf.createEntityManager(); }

    public void create(Reservaciones reservaciones) throws RollbackFailureException, Exception {
        EntityManager em = null;
        try { em = getEntityManager(); em.getTransaction().begin(); em.persist(reservaciones); em.getTransaction().commit(); }
        catch (Exception ex) { try { if (em != null && em.getTransaction().isActive()) em.getTransaction().rollback(); } catch (Exception re) { throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re); } throw ex; }
        finally { if (em != null) em.close(); }
    }

    public void edit(Reservaciones reservaciones) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try { em = getEntityManager(); em.getTransaction().begin(); reservaciones = em.merge(reservaciones); em.getTransaction().commit(); }
        catch (Exception ex) { try { if (em != null && em.getTransaction().isActive()) em.getTransaction().rollback(); } catch (Exception re) { throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re); } String msg = ex.getLocalizedMessage(); if (msg == null || msg.length() == 0) { Integer id = reservaciones.getIDReservacion(); if (findReservaciones(id) == null) { throw new NonexistentEntityException("The reservaciones with id " + id + " no longer exists."); } } throw ex; }
        finally { if (em != null) em.close(); }
    }

    public void destroy(Integer id) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try { em = getEntityManager(); em.getTransaction().begin(); Reservaciones reservaciones; try { reservaciones = em.getReference(Reservaciones.class, id); reservaciones.getIDReservacion(); } catch (EntityNotFoundException enfe) { throw new NonexistentEntityException("The reservaciones with id " + id + " no longer exists.", enfe); } em.remove(reservaciones); em.getTransaction().commit(); }
        catch (Exception ex) { try { if (em != null && em.getTransaction().isActive()) em.getTransaction().rollback(); } catch (Exception re) { throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re); } throw ex; }
        finally { if (em != null) em.close(); }
    }

    public List<Reservaciones> findReservacionesEntities() { return findReservacionesEntities(true, -1, -1); }
    public List<Reservaciones> findReservacionesEntities(int maxResults, int firstResult) { return findReservacionesEntities(false, maxResults, firstResult); }
    private List<Reservaciones> findReservacionesEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try { javax.persistence.criteria.CriteriaBuilder cb = em.getCriteriaBuilder(); CriteriaQuery<Reservaciones> cq = cb.createQuery(Reservaciones.class); Root<Reservaciones> rt = cq.from(Reservaciones.class); cq.select(rt); TypedQuery<Reservaciones> q = em.createQuery(cq); if (!all) { q.setMaxResults(maxResults); q.setFirstResult(firstResult); } return q.getResultList(); }
        finally { em.close(); }
    }
    public Reservaciones findReservaciones(Integer id) { EntityManager em = getEntityManager(); try { return em.find(Reservaciones.class, id); } finally { em.close(); } }
    public int getReservacionesCount() { EntityManager em = getEntityManager(); try { javax.persistence.criteria.CriteriaBuilder cb = em.getCriteriaBuilder(); CriteriaQuery<Long> cq = cb.createQuery(Long.class); Root<Reservaciones> rt = cq.from(Reservaciones.class); cq.select(cb.count(rt)); TypedQuery<Long> q = em.createQuery(cq); return q.getSingleResult().intValue(); } finally { em.close(); } }
}

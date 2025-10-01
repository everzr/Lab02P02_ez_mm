package Controladores;

import Controladores.exceptions.NonexistentEntityException;
import Controladores.exceptions.RollbackFailureException;
import Entity.Pasajeros;
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

public class PasajerosJpaController implements Serializable {
    @Resource
    private UserTransaction utx; // Not used with RESOURCE_LOCAL, kept for parity

    private final EntityManagerFactory emf;

    public PasajerosJpaController() {
        this.emf = Persistence.createEntityManagerFactory("my_persistence_unit");
    }

    public PasajerosJpaController(UserTransaction utx) { this(); this.utx = utx; }
    public PasajerosJpaController(UserTransaction utx, EntityManagerFactory emf) { this.utx = utx; this.emf = emf; }

    public EntityManager getEntityManager() { return emf.createEntityManager(); }

    public void create(Pasajeros pasajeros) throws RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(pasajeros);
            em.getTransaction().commit();
        } catch (Exception ex) {
            try { if (em != null && em.getTransaction().isActive()) em.getTransaction().rollback(); }
            catch (Exception re) { throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re); }
            throw ex;
        } finally { if (em != null) em.close(); }
    }

    public void edit(Pasajeros pasajeros) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            pasajeros = em.merge(pasajeros);
            em.getTransaction().commit();
        } catch (Exception ex) {
            try { if (em != null && em.getTransaction().isActive()) em.getTransaction().rollback(); }
            catch (Exception re) { throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re); }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = pasajeros.getIDPasajero();
                if (findPasajeros(id) == null) {
                    throw new NonexistentEntityException("The pasajeros with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally { if (em != null) em.close(); }
    }

    public void destroy(Integer id) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Pasajeros pasajeros;
            try {
                pasajeros = em.getReference(Pasajeros.class, id);
                pasajeros.getIDPasajero();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The pasajeros with id " + id + " no longer exists.", enfe);
            }
            em.remove(pasajeros);
            em.getTransaction().commit();
        } catch (Exception ex) {
            try { if (em != null && em.getTransaction().isActive()) em.getTransaction().rollback(); }
            catch (Exception re) { throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re); }
            throw ex;
        } finally { if (em != null) em.close(); }
    }

    public List<Pasajeros> findPasajerosEntities() { return findPasajerosEntities(true, -1, -1); }
    public List<Pasajeros> findPasajerosEntities(int maxResults, int firstResult) { return findPasajerosEntities(false, maxResults, firstResult); }
    private List<Pasajeros> findPasajerosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            javax.persistence.criteria.CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery<Pasajeros> cq = cb.createQuery(Pasajeros.class);
            Root<Pasajeros> rt = cq.from(Pasajeros.class);
            cq.select(rt);
            TypedQuery<Pasajeros> q = em.createQuery(cq);
            if (!all) { q.setMaxResults(maxResults); q.setFirstResult(firstResult); }
            return q.getResultList();
        } finally { em.close(); }
    }
    public Pasajeros findPasajeros(Integer id) { EntityManager em = getEntityManager(); try { return em.find(Pasajeros.class, id); } finally { em.close(); } }
    public int getPasajerosCount() { EntityManager em = getEntityManager(); try { javax.persistence.criteria.CriteriaBuilder cb = em.getCriteriaBuilder(); CriteriaQuery<Long> cq = cb.createQuery(Long.class); Root<Pasajeros> rt = cq.from(Pasajeros.class); cq.select(cb.count(rt)); TypedQuery<Long> q = em.createQuery(cq); return q.getSingleResult().intValue(); } finally { em.close(); } }
}

/*
 * Generated based on reference repo, adapted to RESOURCE_LOCAL and javax.persistence
 */
package Controladores;

import Controladores.exceptions.NonexistentEntityException;
import Controladores.exceptions.RollbackFailureException;
import Entity.Vuelos;
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

/**
 * JPA Controller for Vuelos entity (RESOURCE_LOCAL transactions)
 */
public class VuelosJpaController implements Serializable {

    @Resource
    private UserTransaction utx; // Not used with RESOURCE_LOCAL, kept for parity with reference

    private final EntityManagerFactory emf;

    public VuelosJpaController() {
        this.emf = Persistence.createEntityManagerFactory("my_persistence_unit");
    }

    public VuelosJpaController(UserTransaction utx) {
        this();
        this.utx = utx;
    }

    public VuelosJpaController(UserTransaction utx, EntityManagerFactory emf) {
        this.utx = utx;
        this.emf = emf;
    }

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Vuelos vuelos) throws RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(vuelos);
            em.getTransaction().commit();
        } catch (Exception ex) {
            try {
                if (em != null && em.getTransaction().isActive()) {
                    em.getTransaction().rollback();
                }
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Vuelos vuelos) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            vuelos = em.merge(vuelos);
            em.getTransaction().commit();
        } catch (Exception ex) {
            try {
                if (em != null && em.getTransaction().isActive()) {
                    em.getTransaction().rollback();
                }
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = vuelos.getIDVuelo();
                if (findVuelos(id) == null) {
                    throw new NonexistentEntityException("The vuelos with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Vuelos vuelos;
            try {
                vuelos = em.getReference(Vuelos.class, id);
                vuelos.getIDVuelo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The vuelos with id " + id + " no longer exists.", enfe);
            }
            em.remove(vuelos);
            em.getTransaction().commit();
        } catch (Exception ex) {
            try {
                if (em != null && em.getTransaction().isActive()) {
                    em.getTransaction().rollback();
                }
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Vuelos> findVuelosEntities() {
        return findVuelosEntities(true, -1, -1);
    }

    public List<Vuelos> findVuelosEntities(int maxResults, int firstResult) {
        return findVuelosEntities(false, maxResults, firstResult);
    }

    private List<Vuelos> findVuelosEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            javax.persistence.criteria.CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery<Vuelos> cq = cb.createQuery(Vuelos.class);
            Root<Vuelos> rt = cq.from(Vuelos.class);
            cq.select(rt);
            TypedQuery<Vuelos> q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Vuelos findVuelos(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Vuelos.class, id);
        } finally {
            em.close();
        }
    }

    public int getVuelosCount() {
        EntityManager em = getEntityManager();
        try {
            javax.persistence.criteria.CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery<Long> cq = cb.createQuery(Long.class);
            Root<Vuelos> rt = cq.from(Vuelos.class);
            cq.select(cb.count(rt));
            TypedQuery<Long> q = em.createQuery(cq);
            return q.getSingleResult().intValue();
        } finally {
            em.close();
        }
    }
}

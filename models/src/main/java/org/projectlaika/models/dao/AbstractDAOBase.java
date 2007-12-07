package org.projectlaika.models.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.transaction.annotation.Transactional;

/**
 * Foundation for creating Data Access Objects in Laika. This class provides basic CRUD operations
 * for a class.
 *
 * DAO Authors extending this class should declare a type of the base class. They should also call
 * the setModel method for the code to function properly.
 * 
 * @author Andy Gregorowicz
 * @param <M> The class the the DAO is providing access for
 */
@Transactional
public abstract class AbstractDAOBase<M>
{
    private EntityManager entityManager;
    @SuppressWarnings("unchecked")
    private Class model;

    /**
     * Gets the object with the id specified
     * @param id
     * @return
     */
    @SuppressWarnings("unchecked")
    public M find(int id)
    {
        return (M) entityManager.find(model, id);
    }
    
    /**
     * Finds all of the objects in the database for the type provided by setModel
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<M> findAll()
    {
        String queryString = String.format("select c from %s c", model.getCanonicalName());
        Query query = entityManager.createQuery(queryString);
        return query.getResultList();
    }
    
    /**
     * Removes the object from the database specified by the id
     * @param id
     */
    @SuppressWarnings("unchecked")
    public void delete(int id)
    {
        Object instance = entityManager.find(model, id);
        entityManager.remove(instance);
    }
    
    /**
     * Persists an object into the database. The id for the persisted entity will be set in the
     * object that is passed into the method.
     * @param obj
     */
    public void save(M obj)
    {
        entityManager.persist(obj);
    }
    
    /**
     * Updates the database to match the state of the object passed in.
     * @param obj
     */
    public void update(M obj)
    {
        entityManager.merge(obj);
    }
    
    /**
     * This method should be called by all subclasses to provide the model this DAO will provide
     * access for.
     * @param model
     */
    @SuppressWarnings("unchecked")
    protected void setModel(Class model)
    {
        this.model = model;
    }
    
    @PersistenceContext
    public void setEntityManager(EntityManager entityManager)
    {
        this.entityManager = entityManager;
    }
}

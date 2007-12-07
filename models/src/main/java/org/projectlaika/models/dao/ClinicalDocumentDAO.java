package org.projectlaika.models.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.projectlaika.models.ClinicalDocument;
import org.springframework.transaction.annotation.Transactional;

/**
 * Data access object for ClinicalDocuments
 * @author Andy Gregorowicz
 */
@Transactional
public class ClinicalDocumentDAO
{
    private EntityManager entityManager;
    
    /**
     * Gets a list of all of the ClinicalDocuments stored in Laika
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<ClinicalDocument> findAll()
    {
        Query query = entityManager.createQuery("select cd from ClinicalDocument cd");
        List<ClinicalDocument> docs = query.getResultList();
        return docs;
    }
    
    /**
     * Finds a ClinicalDocument specified by the id
     * @param id
     * @return
     */
    public ClinicalDocument find(int id)
    {
        return entityManager.find(ClinicalDocument.class, id);
    }
    
    /**
     * Deletes a ClinicalDocument from the database with the id specified
     * @param id
     */
    public void delete(int id)
    {
        ClinicalDocument cd = entityManager.find(ClinicalDocument.class, id);
        entityManager.remove(cd);
    }
    
    /**
     * Saves the ClinicalDocument to the database. After this method is called, the ClinicalDocument
     * instance that was passed in will contain the id that it recieved when it was inserted into
     * the database.
     * @param cd
     */
    public void save(ClinicalDocument cd)
    {
        entityManager.persist(cd);
    }
    
    /**
     * Updates the ClinicalDocument in the database
     * @param cd
     * @return
     */
    public ClinicalDocument update(ClinicalDocument cd)
    {
        ClinicalDocument mergedCd = entityManager.merge(cd);
        entityManager.persist(cd);
        return mergedCd;
    }

    @PersistenceContext
    public void setEntityManager(EntityManager entityManager)
    {
        this.entityManager = entityManager;
    }
}

package org.projectlaika.web;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.servlet.http.HttpServletRequest;

import org.projectlaika.models.DocumentLocation;
import org.projectlaika.models.Namespace;
import org.projectlaika.web.util.LazyListHelper;
import org.springframework.web.servlet.mvc.SimpleFormController;

/**
 * Controller that allows users to create DocumentLocations via a web
 * interface
 *
 * @author Andy Gregorowicz
 */
public class DocumentLocationCreationController extends SimpleFormController
{
    private EntityManagerFactory emf;

    @Override
    protected Object formBackingObject(HttpServletRequest request)
            throws Exception
    {
        DocumentLocation dl = new DocumentLocation();
        LazyListHelper.decorateList(dl, "namespaces", Namespace.class);
        return dl;
    }

    @Override
    protected void doSubmitAction(Object command) throws Exception
    {
        EntityManager em = emf.createEntityManager();
        DocumentLocation dl = (DocumentLocation) command;
        LazyListHelper.removeDecoration(dl, "namespaces");
        
        EntityTransaction transaction = em.getTransaction();
        transaction.begin();
        em.persist(dl);
        transaction.commit();
        em.close();
    }

    public void setEmf(EntityManagerFactory emf)
    {
        this.emf = emf;
    }
}

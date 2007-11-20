package org.projectlaika.web;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.servlet.http.HttpServletRequest;

import org.projectlaika.models.ClinicalDocument;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.multipart.support.StringMultipartFileEditor;
import org.springframework.web.servlet.mvc.SimpleFormController;

/**
 * Handles the upload of a ClinicalDocumet into the database
 *
 * @author Andy Gregorowicz
 */
public class ClinicalDocumentUploadController extends SimpleFormController
{
    private EntityManagerFactory emf;

    @Override
    protected void doSubmitAction(Object command) throws Exception
    {
        EntityManager em = emf.createEntityManager();
        ClinicalDocument cd = (ClinicalDocument) command;
        EntityTransaction transaction = em.getTransaction();
        transaction.begin();
        em.persist(cd);
        transaction.commit();
        em.close();
    }

    /**
     * Lets Spring know how to handle translating the file upload into the clinical
     * document bean.
     */
    @Override
    protected void initBinder(HttpServletRequest request,
            ServletRequestDataBinder binder) throws Exception
    {
        binder.registerCustomEditor(String.class, new StringMultipartFileEditor());
    }

    public void setEmf(EntityManagerFactory emf)
    {
        this.emf = emf;
    }

}

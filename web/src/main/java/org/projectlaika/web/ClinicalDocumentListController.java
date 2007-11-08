package org.projectlaika.web;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

public class ClinicalDocumentListController extends AbstractController
{
    private EntityManagerFactory emf;
    
    @SuppressWarnings("unchecked")
    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request,
            HttpServletResponse response) throws Exception
    {
        EntityManager em = emf.createEntityManager();
        Query query = em.createQuery("select cd from ClinicalDocument cd");
        List docs = query.getResultList();
        em.close();
        return new ModelAndView("cd/list", "docs", docs);
    }

    public void setEmf(EntityManagerFactory emf)
    {
        this.emf = emf;
    }

}

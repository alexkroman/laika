package org.projectlaika.web;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ClinicalDocumentController
{
    private Logger log = LoggerFactory.getLogger(this.getClass());
    private EntityManagerFactory emf;
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/clinicalDocument/list.lk")
    public ModelMap list()
    {
        EntityManager em = emf.createEntityManager();
        Query query = em.createQuery("select cd from ClinicalDocument cd");
        List docs = query.getResultList();
        em.close();
        log.debug("Got {} clinical documents", docs.size());
        return new ModelMap("clinicalDocumentList", docs);
    }
    
    @Autowired
    public void setEmf(EntityManagerFactory emf)
    {
        this.emf = emf;
    }
}

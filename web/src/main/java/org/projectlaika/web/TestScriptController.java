package org.projectlaika.web;

import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.projectlaika.models.ClinicalDocument;
import org.projectlaika.models.DocumentLocation;
import org.projectlaika.models.Namespace;
import org.projectlaika.models.Rule;
import org.projectlaika.models.TestScript;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

public class TestScriptController extends AbstractController
{
    private EntityManagerFactory emf;
    
    @SuppressWarnings("unchecked")
    @Override
    protected ModelAndView handleRequestInternal(HttpServletRequest request,
            HttpServletResponse response) throws Exception
    {
    	String testScriptId = request.getParameter("id");    	
    	EntityManager em = emf.createEntityManager();
        
    	/*EntityTransaction transaction = em.getTransaction();
        transaction.begin();
    	DocumentLocation dl = new DocumentLocation(
    		"Patient First Name",
         	"/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:given");
       	dl.setDescription("The first name of the patient");
        em.persist(dl);
        transaction.commit();
        
        transaction.begin();
    	DocumentLocation dl2 = new DocumentLocation(
    		"Patient Last Name",
         	"/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:family");
       	dl2.setDescription("The last name of the patient");
        em.persist(dl2);
        transaction.commit();
        
        transaction.begin();
        Rule rule = new Rule("Robert", dl);
        rule.setDifferentValueErrorMessage("Patient first name wasn't Robert");
        rule.setMissingValueErrorMessage("Patient first name not found");
        em.persist(rule);
        transaction.commit();
        
        transaction.begin();
        Rule rule2 = new Rule("McCready", dl2);
        rule2.setDifferentValueErrorMessage("Patient last name wasn't McCready");
        rule2.setMissingValueErrorMessage("Patient last name not found");
        em.persist(rule2);
        transaction.commit();
        
        transaction.begin();
        TestScript testScript = new TestScript();
        testScript.addRule(rule);
        testScript.addRule(rule2);
        testScript.setName("Laika demo test v 0.0.1");
        em.persist(testScript);
        transaction.commit();*/
        
        Query query = em.createQuery("select t from TestScript t where t.id = :id");
        query.setParameter("id", new Integer(testScriptId));
        TestScript testScript = (TestScript) query.getSingleResult();
        
        List testScriptRules = testScript.getRules();
        for (Iterator it = testScriptRules.iterator();it.hasNext(); )
        {
        	Rule rule = (Rule) it.next();
        	System.out.println("Rule " + rule.getExpectedValue());
        	System.out.println("DocumentLocation " + rule.getDocumentLocation().getId());
        }
        em.close();
        
        return new ModelAndView("testscript/display", "testscript", testScript);
    }

    public void setEmf(EntityManagerFactory emf)
    {
        this.emf = emf;
    }

}

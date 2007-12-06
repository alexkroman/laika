package org.projectlaika.web;

import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.projectlaika.models.BoundVariable;
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
    	EntityManager em = emf.createEntityManager();
        
    	EntityTransaction transaction = em.getTransaction();
        
        transaction.begin();
        Namespace namespace = new Namespace("cda", "urn:hl7-org:v3");
        em.persist(namespace);
        transaction.commit();
        
        transaction.begin();
    	DocumentLocation dlFirstName = new DocumentLocation(
    		"Patient First Name",
         	"/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:given/text()=$name");
    	dlFirstName.addNamespace(namespace);
    	dlFirstName.setDescription("The first name of the patient");
        em.persist(dlFirstName);
        transaction.commit();
        
        transaction.begin();
    	DocumentLocation dlLastName = new DocumentLocation(
    		"Patient Last Name",
         	"/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:family/text()=$name");
    	dlLastName.addNamespace(namespace);
    	dlLastName.setDescription("The last name of the patient");
        em.persist(dlLastName);
        transaction.commit();
        
        transaction.begin();
        Rule rFirstName = new Rule(dlFirstName, new BoundVariable("name", "Robert"));
        rFirstName.setDifferentValueErrorMessage("Patient first name wasn't Robert");
        rFirstName.setMissingValueErrorMessage("Patient first name not found");
        em.persist(rFirstName);
        transaction.commit();
        
        transaction.begin();
        Rule rLastName = new Rule(dlLastName, new BoundVariable("name", "McCready"));
        rFirstName.setDifferentValueErrorMessage("Patient last name wasn't McCready");
        rFirstName.setMissingValueErrorMessage("Patient last name not found");
        em.persist(rFirstName);
        transaction.commit();
        
        transaction.begin();
        TestScript testScript = new TestScript();
        testScript.addRule(rFirstName);
        testScript.addRule(rLastName);
        testScript.setName("Laika demo test v 0.0.1");
        em.persist(testScript);
        transaction.commit();
        
        /*         
    	String testScriptId = request.getParameter("id"); 
        Query query = em.createQuery("select t from TestScript t where t.id = :id");
        query.setParameter("id", new Integer(testScriptId));
        TestScript testScript = (TestScript) query.getSingleResult();
        List testScriptRules = testScriptOut.getRules();
        for (Iterator it = testScriptRules.iterator();it.hasNext(); )
        {
        	Rule rule = (Rule) it.next();
        	DocumentLocation documentLocation = rule.getDocumentLocation();
        	System.out.println("DocumentLocation id: " + documentLocation.getId());
        	System.out.println("DocumentLocation name: " + documentLocation.getName());
        	List boundVariables = rule.getBoundVariables();
        	
        	for (Iterator itBoundVariables = boundVariables.iterator(); itBoundVariables.hasNext();)
        	{
        		BoundVariable boundVariable = (BoundVariable) itBoundVariables.next();
        		System.out.println("BoundVariable name: " + boundVariable.getName());
        		System.out.println("BoundVariable expected value: " + boundVariable.getExpectedValue());
        	}
        	
        }*/
        em.close();
        
        return new ModelAndView("testscript/display", "testscript", testScript);
    }

    public void setEmf(EntityManagerFactory emf)
    {
        this.emf = emf;
    }

}

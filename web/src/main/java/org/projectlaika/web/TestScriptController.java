package org.projectlaika.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;

import org.projectlaika.models.dao.TestScriptDAO;

import org.projectlaika.models.BoundVariable;
import org.projectlaika.models.ClinicalDocument;
import org.projectlaika.models.DocumentLocation;
import org.projectlaika.models.Namespace;
import org.projectlaika.models.Rule;
import org.projectlaika.models.TestScript;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TestScriptController 
{
    private EntityManagerFactory emf;
    private TestScriptDAO testScriptDAO;
    
    @Autowired
    public TestScriptController(EntityManagerFactory emf)
    {
        this.emf = emf;
    }
    
    @RequestMapping("/testscript/view.lk")
    public ModelMap view(@RequestParam(value="id") int id)
    {
    	/*EntityManager em = emf.createEntityManager();
    	EntityTransaction transaction = em.getTransaction();
        
        transaction.begin();
        Namespace namespace = new Namespace("cda", "urn:hl7-org:v3");
        em.persist(namespace);
        transaction.commit();
        
        transaction.begin();
    	DocumentLocation dlPatientName = new DocumentLocation(
    		"Patient Name",
         	"/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:given/text()=$firstName&&/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:family/text()=$lastName");
    	dlPatientName.addNamespace(namespace);
    	dlPatientName.setDescription("The name of the patient");
        em.persist(dlPatientName);
        transaction.commit();
       
        transaction.begin();
        BoundVariable bvFirstName = new BoundVariable("firstName", "Robert");
        em.persist(bvFirstName);
        transaction.commit();
        
        transaction.begin();
        BoundVariable bvLastName = new BoundVariable("lastName", "McCready");
        em.persist(bvLastName);
        transaction.commit();
        
        transaction.begin();
        List<BoundVariable> patientNameBoundVariables = new ArrayList<BoundVariable>();
        patientNameBoundVariables.add(bvFirstName);
        patientNameBoundVariables.add(bvLastName);
        Rule rulePatientName = new Rule(dlPatientName, patientNameBoundVariables);
        em.persist(rulePatientName);
        transaction.commit();
        
        transaction.begin();
        TestScript testScriptTest = new TestScript();
        testScriptTest.addRule(rulePatientName);
        testScriptTest.setName("Laika demo test v 0.0.2");
        em.persist(testScriptTest);
        transaction.commit();
        
        em.close();*/

    	TestScript testScript = testScriptDAO.find(id);
    	
    	/*System.out.println("Starting testing");
    	List testScriptRules = testScript.getRules();
        for (Iterator it = testScriptRules.iterator();it.hasNext(); )
        {
        	Rule rule = (Rule) it.next();
        	System.out.println("Got a rule");
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
    	
    	return new ModelMap("testscript", testScript);
    }

    public void setEmf(EntityManagerFactory emf)
    {
        this.emf = emf;
    }

    @Autowired
    public void setClinicalDocumentDAO(TestScriptDAO testScriptDAO)
    {
        this.testScriptDAO = testScriptDAO;
    }
    
}

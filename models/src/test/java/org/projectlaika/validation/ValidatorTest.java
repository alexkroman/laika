package org.projectlaika.validation;

import static org.junit.Assert.*;
import static org.hamcrest.core.Is.*;

import java.io.FileInputStream;
import java.util.LinkedList;

import org.jdom.Document;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.junit.Before;
import org.junit.Test;
import org.projectlaika.models.BoundVariable;
import org.projectlaika.models.DocumentLocation;
import org.projectlaika.models.Namespace;
import org.projectlaika.models.Rule;
import org.projectlaika.models.TestScript;

public class ValidatorTest
{
    private Document document;

    @Before
    public void setUp() throws Exception
    {
        SAXBuilder builder = new SAXBuilder();
        document = builder.build(new FileInputStream("src/test/data/SampleCCDDocument.xml"));
    }

    @Test
    public void testValidate() throws JDOMException
    {
        DocumentLocation dl = new DocumentLocation("Patient First Name",
           "/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:given/text()=$name");
        dl.addNamespace(new Namespace("cda", "urn:hl7-org:v3"));
        dl.setDescription("The first name of the patient");
        Rule rule = new Rule(dl, new BoundVariable("name", "Henry"));
        rule.setDifferentValueErrorMessage("Patient first name wasn't Henry");
        rule.setMissingValueErrorMessage("Patient first name not found");
        assertThat(Validator.validate(rule, document), is(true));

        LinkedList<BoundVariable> bvs = new LinkedList<BoundVariable>();
        BoundVariable bv = new BoundVariable();
        bv.setName("name");
        bv.setExpectedValue("Steve");
        bvs.add(bv);
        rule.setBoundVariables(bvs);
        assertThat(Validator.validate(rule, document), is(false));
        
        dl = new DocumentLocation("CCD Template Id", "/cda:ClinicalDocument/cda:templateId/@root=$templateId",
                                  "The template Id of the CCD");
        dl.addNamespace(new Namespace("cda", "urn:hl7-org:v3"));
        rule = new Rule(dl, new BoundVariable("templateId", "2.16.840.1.113883.10.20.1"));
        assertThat(Validator.validate(rule, document), is(true));
        
        TestScript testScript = new TestScript();
        testScript.addRule(rule);
        testScript.setName("A test");
        
        assertThat(testScript.getName(), is("A test"));
    }

}

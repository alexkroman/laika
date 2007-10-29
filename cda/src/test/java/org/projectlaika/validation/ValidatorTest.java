package org.projectlaika.validation;

import static org.junit.Assert.*;
import static org.hamcrest.core.Is.*;

import java.io.FileInputStream;

import org.jdom.Document;
import org.jdom.JDOMException;
import org.jdom.Namespace;
import org.jdom.input.SAXBuilder;
import org.junit.Before;
import org.junit.Test;

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
           "/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:given");
        dl.addNamespace(Namespace.getNamespace("cda", "urn:hl7-org:v3"));
        Rule rule = new Rule("Henry", dl);
        assertThat(Validator.validate(rule, document), is(true));

        rule.setExpectedValue("Steve");
        assertThat(Validator.validate(rule, document), is(false));
        
        dl.setXpathExpression("/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:given/text()");
        rule.setExpectedValue("Henry");
        assertThat(Validator.validate(rule, document), is(true));
        
        dl = new DocumentLocation("CCD Template Id", "/cda:ClinicalDocument/cda:templateId/@root");
        dl.addNamespace(Namespace.getNamespace("cda", "urn:hl7-org:v3"));
        rule = new Rule("2.16.840.1.113883.10.20.1", dl);
        assertThat(Validator.validate(rule, document), is(true));
    }

}

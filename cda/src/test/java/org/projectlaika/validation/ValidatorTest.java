package org.projectlaika.validation;

import static org.junit.Assert.*;
import static org.hamcrest.core.Is.*;

import java.io.FileInputStream;

import org.jdom.Document;
import org.jdom.JDOMException;
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
        Validator validator = new Validator(
                "Patient First Name",
                "/cda:ClinicalDocument/cda:recordTarget/cda:patientRole/cda:patient/cda:name/cda:given",
                "Henry");
        assertThat(validator.validate(document), is(true));
    }

}

package org.projectlaika.validation;

import java.io.File;
import java.io.FileNotFoundException;

import javax.xml.transform.TransformerConfigurationException;

import org.jdom.Document;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.junit.Test;
import static org.junit.Assert.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SchematronValidatorTest
{
    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Test
    public void testValidate()
    {
        try
        {
            XSLTProcessor warn = new XSLTProcessor(
                    "./resources/ccd-warnings.xslt");
            XSLTProcessor error = new XSLTProcessor(
                    "./resources/ccd-errors.xslt");
            SchematronValidator validator = new SchematronValidator();
            validator.setXsltProcessor(warn);
            SAXBuilder builder = new SAXBuilder();

            Document doc = builder.build(new File(
                    "./src/test/resources/ccd-good.xml"));

            ValidationContext context = new ValidationContext(doc);
            ValidationContext context2 = new ValidationContext(doc);
            validator.validate(context);

            validator.setXsltProcessor(error);
            validator.validate(context2);

            System.out.println(context.getResults());

            assertTrue("Context should have 1 results", context.getResults()
                    .size() == 1);
            
            assertTrue("Context should have 1 results", context2.getResults()
                    .size() == 1);
            
            assertFalse("IsValid should be false", context.isValid());
            assertFalse("IsValid should be true", context2.isValid());
            System.out.println(context.getResults().get(0).getErrors());
            // ValidationResult res = validator.validate(context);
            // logger.debug(res.getValidationReport().toString());

        }
        catch (TransformerConfigurationException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (FileNotFoundException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (JDOMException e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (Throwable e)
        {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

}

package org.projectlaika.validation;

import static org.junit.Assert.*;

import java.io.File;
import java.io.IOException;

import org.jdom.Document;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.junit.Test;
import org.xml.sax.SAXException;

public class XSDValidatorTest
{

    @Test
    public void testValidate()
    {
        try
        {
            XSDValidator validator = new XSDValidator();
            validator.setSchema("./resources/CDASchemas/cda/Schemas/CDA.xsd");
            SAXBuilder builder = new SAXBuilder();

            Document doc = builder.build(new File(
                    "./src/test/resources/ccd-good.xml"));
            Document ext = builder.build(new File(
                    "./src/test/resources/ccd-extention.xml"));
            ValidationContext context = new ValidationContext(doc);
            ValidationContext contextExt = new ValidationContext(ext);

            validator.validate(context);
            validator.validate(contextExt);

            if (!context.isValid())
            {
                fail("Should have been a good test ");
            }

            if (contextExt.isValid())
            {
                fail("Should have been a bad test ");
            }
        }
        catch (SAXException e)
        {
            fail(e.getMessage());
            e.printStackTrace();
        }
        catch (JDOMException e)
        {
            fail(e.getMessage());
            e.printStackTrace();
        }
        catch (IOException e)
        {
            fail(e.getMessage());
            e.printStackTrace();
        }
    }

}

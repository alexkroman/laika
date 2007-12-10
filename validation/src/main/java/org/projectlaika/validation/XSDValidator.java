package org.projectlaika.validation;

import java.io.File;
import java.io.IOException;

import javax.xml.XMLConstants;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.jdom.transform.JDOMSource;
import org.xml.sax.SAXException;

/**
 * Validator which will validate a given document against an xml schema
 * @author bobd
 *
 */
public class XSDValidator  extends AbstractValidator
{

    /**
     * Schema object to perform validation against
     */
    private Schema schema;

    /**
     * Set the schema
     * @param schemaFile  location of the schema file
     * @throws SAXException
     */
    public void setSchema(String schemaFile) throws SAXException
    {
        File file = new File(schemaFile);
        setSchema(file);
    }

    /**
     * Set the schema
     * @param schema  the schema to set
     */
    public void setSchema(Schema schema)
    {
        this.schema = schema;
    }

    /**
     * Set the schema 
     * @param file  the schema file
     * @throws SAXException
     */
    public void setSchema(File file) throws SAXException
    {
        // create a SchemaFactory capable of understanding WXS schemas
        SchemaFactory factory = SchemaFactory
                .newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        // load a WXS schema, represented by a Schema instance
        Source schemaFile = new StreamSource(file);
        setSchema(factory.newSchema(schemaFile));

    }

    /*
     * (non-Javadoc)
     * @see org.projectlaika.validation.Validator#validate(org.projectlaika.validation.ValidationContext)
     */
    public void validate(ValidationContext context)
    {
        ValidationResult res = new ValidationResult(this.getId());
        try
        {
            Source source = new JDOMSource(context.getDocument());
            Validator validator = schema.newValidator();
            validator.validate(source);
            res.setValid(true);
        }
        catch (SAXException e)
        {
            res.setValid(false);
            res.addError("",e.getLocalizedMessage(),e);
        }
        catch (IOException e)
        {
            res.addError("",e.getLocalizedMessage(),e);
            res.setValid(false);
        }
       context.add(res);
    }

}

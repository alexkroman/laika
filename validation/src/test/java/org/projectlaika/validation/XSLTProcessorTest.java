/**
 * 
 */
package org.projectlaika.validation;

import static org.junit.Assert.fail;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.StringBufferInputStream;
import java.io.StringWriter;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.junit.Test;

/**
 * @author bobd
 * 
 */
public class XSLTProcessorTest
{

    /**
     * Test method for
     * {@link org.projectlaika.validation.XSLTProcessor#SchematronValidator()}.
     */
    @Test
    public void testSchematronValidator()
    {
        new XSLTProcessor();
    }

    /**
     * Test method for
     * {@link org.projectlaika.validation.XSLTProcessor#setStyleSheet(java.lang.String)}.
     */
    @Test
    public void testSetStylesheet()
    {

        try
        {
            new XSLTProcessor("./asdfasdfasdfd.asfasdf");
            fail("FileNotFoundException should have been thrown from empty file location");
        }
        catch (FileNotFoundException ex)
        {

        }
        catch (TransformerConfigurationException ex)
        {

        }

        try
        {

            new XSLTProcessor("./src/test/resources/test.xslt");
        }
        catch (Exception ex)
        {
            fail("Should have processed the file correctly");
        }
    }

    /**
     * Test method for
     * {@link org.projectlaika.validation.XSLTProcessor#setStyleSheet(java.io.File)}.
     */
    @Test
    public void testSetStyleSheetFile()
    {
        try
        {
            new XSLTProcessor(new File("asdfasdf"));
            fail("FileNotFoundException should have been thrown from empty file location");
        }
        catch (FileNotFoundException ex)
        {

        }
        catch (TransformerConfigurationException ex)
        {

        }

        try
        {
            new XSLTProcessor(new File("./src/test/resources/test.xslt"));
        }
        catch (Exception ex)
        {
            fail("Should have processed the file correctly");
        }
    }

    /**
     * Test method for
     * {@link org.projectlaika.validation.XSLTProcessor#setStyleSheet(java.io.InputStream)}.
     */
    @Test
    public void testSetStyleSheetInputStream()
    {
        try
        {
            new XSLTProcessor(new StringBufferInputStream(""));
            fail("Empty String should have caused TransformerConfigurationException");
        }
        catch (TransformerConfigurationException ex)
        {

        }

        try
        {
            new XSLTProcessor(
                    new StringBufferInputStream(
                            "<?xml version='1.0'?>"
                                    + "<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' "
                                    + "xmlns:xalan='http://xml.apache.org/xalan' "
                                    + "xmlns:umls='xalan://org.projectlaika.validator.codesystem.XSLTValidator' "
                                    + "xmlns:cda='urn:hl7-org:v3' "
                                    + "extension-element-prefixes='umls' "
                                    + "version='1.0'></xsl:stylesheet>\n"));
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
            fail("Should have processed the inputstream correctly");
        }
    }

    /**
     * Test method for
     * {@link org.projectlaika.validation.XSLTProcessor#setStyleSheet(javax.xml.transform.Source)}.
     */
    @Test
    public void testSetStyleSheetSource()
    {
        // this should already be tested by the other methods
    }

    /**
     * Test method for
     * {@link org.projectlaika.validation.XSLTProcessor#transform(javax.xml.transform.Source,
     * javax.xml.transform.Result)}.
     */
    @Test
    public void testTransform()
    {
        StringWriter writer = new StringWriter();
        Result result = new StreamResult(writer);
        try
        {

            Source source = new StreamSource(new FileInputStream(
                    "./src/test/resources/test.xml"));
            XSLTProcessor processor = new XSLTProcessor(
                    "./src/test/resources/test.xslt");
            processor.transform(source, result);
        }
        catch (FileNotFoundException e)
        {
            fail("File not found");
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        catch (TransformerConfigurationException e)
        {
            fail("Tranformer configuration exception");
            e.printStackTrace();
        }
        catch (TransformerException e)
        {
            fail("transformer exception " + e);
            e.printStackTrace();
        }

        System.out.println(writer.toString());
    }

}

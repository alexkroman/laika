package org.projectlaika.validation;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Templates;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamSource;

/**
 * Not so much a validator in the sense that you will get a boolean back as to
 * whether a document passes validation but mor along the lines of a Schematron
 * runner which will perform a stylesheet transform on a given document based
 * off of schematron and return the resulting transformed document.
 * 
 * This class is pretty simple it uses a cached stylesheet to perform
 * transformations on given documents.
 * 
 * @author bobd
 * 
 */
public class XSLTProcessor
{
    /**
     * Cached stylesheet
     */
    private Templates styleSheet;

    /**
     * Factory used to create the cached stylesheet
     */
    private TransformerFactory transFact = TransformerFactory.newInstance();

    /**
     * Default constructor
     */
    public XSLTProcessor()
    {

    }

    /**
     * Create a new processor with the stylesheet at the given location on the
     * filesystem
     * 
     * @param location
     *            location of the stylesheet
     * @throws TransformerConfigurationException
     *             thrown if there is an error processing the stylesheet
     * @throws FileNotFoundException
     *             thrown if the file is not found at the location supplied
     */
    public XSLTProcessor(String location)
            throws TransformerConfigurationException, FileNotFoundException
    {
        setStyleSheet(location);
    }

    /**
     * Create a new Processor with the stylesheet pointed to by the file
     * 
     * @param file
     *            stylesheet file
     * @throws TransformerConfigurationException
     *             thrown if there is an error processing the stylesheet
     * @throws FileNotFoundException
     *             thrown if the file is not found at the location supplied
     */
    public XSLTProcessor(File file) throws TransformerConfigurationException,
            FileNotFoundException
    {
        setStyleSheet(file);
    }

    /**
     * Create a new processor with the stylesheet in the given input stream
     * 
     * @param in
     *            inputstream with the stylesheet in it
     * @throws TransformerConfigurationException
     *             thrown if there is an error processing the stylesheet
     */
    public XSLTProcessor(InputStream in)
            throws TransformerConfigurationException
    {
        setStyleSheet(in);
    }

    /**
     * Create a new Processor with the stylesheet represented by the source
     * object
     * 
     * @param source
     *            source object of the stylesheet
     * @throws TransformerConfigurationException
     *             thrown if there is an error processing the stylesheet
     */
    public XSLTProcessor(Source source)
            throws TransformerConfigurationException
    {
        setStyleSheet(source);
    }

    /**
     * Use the supplied location to load the stylesheet from.
     * 
     * @param location
     *            the location on the filesystem where the stylesheet resides
     * @throws TransformerConfigurationException
     *             thrown if there is an error processing the stylesheet
     * @throws FileNotFoundException
     *             thrown if the file is not found at the location supplied
     */
    public void setStyleSheet(String location)
            throws TransformerConfigurationException, FileNotFoundException
    {
        Source source = new StreamSource(new FileInputStream(location));
        loadTemplates(source);
    }

    /**
     * Use the supplied file object to load the stylesheet from.
     * 
     * @param file
     *            the file representing the location on the filesystem where the
     *            stylesheet resides
     * @throws TransformerConfigurationException
     *             thrown if there is an error processing the stylesheet
     * @throws FileNotFoundException
     *             thrown if the file is not found
     */
    public void setStyleSheet(File file)
            throws TransformerConfigurationException, FileNotFoundException
    {
        Source source = new StreamSource(new FileInputStream(file));
        loadTemplates(source);
    }

    /**
     * Load the stylesheet from the given inputstream
     * 
     * @param in
     *            The inputstream which contains the stylesheet data
     * @throws TransformerConfigurationException
     *             thrown if there is an error processing the stylesheet
     */
    public void setStyleSheet(InputStream in)
            throws TransformerConfigurationException 
    {
        Source source = new StreamSource(in);
        loadTemplates(source);
    }

    /**
     * Load the stylesheet form the given source Object
     * 
     * @param source
     *            the source object representing the stylesheet
     * @throws TransformerConfigurationException
     *             Thrown if there is an error processing the stylesheet.
     */
    public void setStyleSheet(Source source)
            throws TransformerConfigurationException
    {
        loadTemplates(source);
    }

    /**
     * Perform the transformation on the given source object into the given
     * Result object
     * 
     * @param source
     *            The document to perform the transformation on
     * @param result
     *            The result object to place the transformation into
     * @throws TransformerException
     */
    public void transform(Source source, Result result)
            throws TransformerException
    {

        styleSheet.newTransformer().transform(source, result);
    }

    /**
     * Load the templates from the supplied Source object
     * 
     * @param source
     *            The source representing the stylesheet
     * @throws TransformerConfigurationException
     *             thrown if there is an error processing the stylesheet
     */
    private void loadTemplates(Source source)
            throws TransformerConfigurationException
    {
        styleSheet = transFact.newTemplates(source);
    }


}

package org.projectlaika.validation;

import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.xpath.XPath;

/**
 * This class lets the user specify an XPath expression and a value that is expected to be found
 * at the end of the XPath expression. It is currently limited to validating the text content of a
 * single element.
 *
 * @author Andy Gregorowicz
 */
public class Validator
{
    private String name;
    private String xpathExpression;
    private String desiredValue;

    /**
     * @param name A name for the validator
     * @param xpathExpression The expression used to find the value
     */
    public Validator(String name, String xpathExpression)
    {
        this.name = name;
        this.xpathExpression = xpathExpression;
    }

    /**
     * @param name A name for the validator
     * @param xpathExpression The expression used to find the value
     * @param desiredValue The text that should be found inside of the element specified by the
     *                     XPath expression
     */
    public Validator(String name, String xpathExpression, String desiredValue)
    {
        this.name = name;
        this.xpathExpression = xpathExpression;
        this.desiredValue = desiredValue;
    }

    /**
     * Finds the first element specified by the XPath expression and checks its text contents
     * against the desired value.
     *
     * @param document Document to be validated
     * @return True if the element is present and contains the desired value. False otherwise
     * @throws JDOMException If there is a problem with the XPath expression
     */
    @SuppressWarnings("unchecked")
    public boolean validate(Document document) throws JDOMException
    {
        XPath xpath = XPath.newInstance(xpathExpression);
        xpath.addNamespace("cda", "urn:hl7-org:v3");
        List<Element> elements = xpath.selectNodes(document);
        if (elements.isEmpty())
        {
            return false;
        }
        else
        {
            Element element = elements.get(0);
            return element.getText().equals(desiredValue);
        }
    }
    
    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getXpathExpression()
    {
        return xpathExpression;
    }

    public void setXpathExpression(String xpathExpression)
    {
        this.xpathExpression = xpathExpression;
    }

    public String getDesiredValue()
    {
        return desiredValue;
    }

    public void setDesiredValue(String desiredValue)
    {
        this.desiredValue = desiredValue;
    }

}

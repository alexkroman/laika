package org.projectlaika.validation;

import java.util.List;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.xpath.XPath;

/**
 * This class lets the user test a Rule against a document It is currently limited to validating
 * the text content of a single element.
 *
 * @author Andy Gregorowicz
 */
public class Validator
{
    /**
     * Prevent users from instantiating the class
     */
    private Validator()
    {
        //do nothing
    }

    /**
     * Finds the first element specified by the XPath expression defined in the DocumentLocation
     * referenced by the rule and checks its text contents against the expected value specified in
     * the rule.
     *
     * @param rule Rule to be applied to the document
     * @param document Document to be validated
     * @return True if the element is present and contains the desired value. False otherwise
     * @throws JDOMException If there is a problem with the XPath expression
     */
    @SuppressWarnings("unchecked")
    public static boolean validate(Rule rule, Document document) throws JDOMException
    {
        XPath xpath = XPath.newInstance(rule.getDocumentLocation().getXpathExpression());
        xpath.addNamespace("cda", "urn:hl7-org:v3");
        List<Element> elements = xpath.selectNodes(document);
        if (elements.isEmpty())
        {
            return false;
        }
        else
        {
            Element element = elements.get(0);
            return element.getText().equals(rule.getExpectedValue());
        }
    }
}

package org.projectlaika.validation;

import org.jdom.Attribute;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.Text;
import org.jdom.xpath.XPath;
import org.projectlaika.models.Namespace;
import org.projectlaika.models.Rule;

/**
 * This class lets the user test a Rule against a document.
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
    public static boolean validate(Rule rule, Document document) throws JDOMException
    {
        XPath xpath = XPath.newInstance(rule.getDocumentLocation().getXpathExpression());
        for (Namespace namespace : rule.getDocumentLocation().getNamespaces())
        {
            xpath.addNamespace(namespace.toJDomNamespace());
        }
        Object target = xpath.selectSingleNode(document);
        if (target == null)
        {
            return false;
        }
        else
        {
            return getTextFromNode(target).equals(rule.getExpectedValue());
        }
    }

    /**
     * Tries to find a text value for a single Node.
     * @param target An Object that can be cast to an Element, Attribute or Text
     * @return The text value for the node
     */
    private static String getTextFromNode(Object target)
    {
        String targetText;
        if (target instanceof Element)
        {
            Element targetElement = (Element) target;
            targetText = targetElement.getText();
        }
        else if (target instanceof Text)
        {
            Text targetJdomText = (Text) target;
            targetText = targetJdomText.getText();
        }
        else if (target instanceof Attribute)
        {
            Attribute targetAttribute = (Attribute) target;
            targetText = targetAttribute.getValue();
        }
        else
        {
            throw new IllegalArgumentException(
                    String.format("Don't know how to get text from class %s",
                            target.getClass().getName()));
        }
        return targetText;
    }
}

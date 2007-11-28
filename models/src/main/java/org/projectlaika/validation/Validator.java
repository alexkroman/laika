package org.projectlaika.validation;

import org.jdom.Document;
import org.jdom.JDOMException;
import org.jdom.xpath.XPath;
import org.projectlaika.models.BoundVariable;
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
        for (BoundVariable bv: rule.getBoundVariables())
        {
            xpath.setVariable(bv.getName(), bv.getExpectedValue());
        }
        Object target = xpath.selectSingleNode(document);
        if (target != null && target instanceof Boolean)
        {
            Boolean bool = (Boolean) target;
            return bool.booleanValue();
        }
        else
        {
            return false;
        }
    }
}

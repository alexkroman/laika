package org.projectlaika.validation;

import java.util.LinkedList;
import java.util.List;

import org.jdom.Namespace;

/**
 * Describes a specific location in a CDA/CCD/C32 document by an XPath expression. Allows the user
 * to provide a name for the location and a description as well.
 *
 * @author Andy Gregorowicz
 */
public class DocumentLocation
{
    private String name;
    private String xpathExpression;
    private String description;
    private List<Namespace> namespaces;

    public DocumentLocation(String name, String xpathExpression)
    {
        this.name = name;
        this.xpathExpression = xpathExpression;
        this.namespaces = new LinkedList<Namespace>();
    }

    public DocumentLocation(String name, String xpathExpression, String description)
    {
        this.name = name;
        this.xpathExpression = xpathExpression;
        this.description = description;
        this.namespaces = new LinkedList<Namespace>();
    }

    public DocumentLocation(String name, String xpathExpression,
            String description, List<Namespace> namespaces)
    {
        this.name = name;
        this.xpathExpression = xpathExpression;
        this.description = description;
        this.namespaces = namespaces;
    }

    /**
     * Adds a namespace that will be used in evaluating the XPath expression against the instance
     * document
     * @param namespace
     */
    public void addNamespace(Namespace namespace)
    {
        namespaces.add(namespace);
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

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    public List<Namespace> getNamespaces()
    {
        return namespaces;
    }

    public void setNamespaces(List<Namespace> namespaces)
    {
        this.namespaces = namespaces;
    }


}

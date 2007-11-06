package org.projectlaika.validation;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 * Describes a specific location in a CDA/CCD/C32 document by an XPath expression. Allows the user
 * to provide a name for the location and a description as well.
 *
 * @author Andy Gregorowicz
 */
@Entity
@Table(name="document_locations")
public class DocumentLocation implements Serializable
{
    private static final long serialVersionUID = -4165136646036981675L;
    
    private int id;
    private String name;
    private String xpathExpression;
    private String description;
    private List<Namespace> namespaces;

    public DocumentLocation()
    {
        this.namespaces = new LinkedList<Namespace>();
    }

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

    @Column(length=100)
    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    @Column(length=200)
    public String getXpathExpression()
    {
        return xpathExpression;
    }

    public void setXpathExpression(String xpathExpression)
    {
        this.xpathExpression = xpathExpression;
    }

    @Basic
    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }

    @ManyToMany
    public List<Namespace> getNamespaces()
    {
        return namespaces;
    }

    public void setNamespaces(List<Namespace> namespaces)
    {
        this.namespaces = namespaces;
    }

    @Id
    @GeneratedValue
    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }
}

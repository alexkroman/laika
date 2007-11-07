package org.projectlaika.models;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/**
 * Class that represents an XML Namespace
 * 
 * @author Andy Gregorowicz
 */
@Entity
public class Namespace implements Serializable
{
    private static final long serialVersionUID = -7075048662657354692L;

    private int id;
    private String prefix;
    private String uri;

    public Namespace()
    {
        //do nothing
    }

    public Namespace(String prefix, String uri)
    {
        this.prefix = prefix;
        this.uri = uri;
    }

    /**
     * Converts the Laika representation of a Namespace into the JDom representation.
     * @return
     */
    public org.jdom.Namespace toJDomNamespace()
    {
        return org.jdom.Namespace.getNamespace(getPrefix(), getUri());
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

    @Basic
    public String getPrefix()
    {
        return prefix;
    }

    public void setPrefix(String prefix)
    {
        this.prefix = prefix;
    }

    @Basic
    public String getUri()
    {
        return uri;
    }

    public void setUri(String uri)
    {
        this.uri = uri;
    }
}

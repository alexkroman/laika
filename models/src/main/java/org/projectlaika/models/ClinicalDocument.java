package org.projectlaika.models;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;

/**
 * This class holds an instance of an XML clinical document
 *
 * @author Andy Gregorowicz
 */
@Entity
public class ClinicalDocument implements Serializable
{
    private static final long serialVersionUID = 6406086406777808640L;
    
    private int id;
    private String name;
    private String xmlContent;
    
    public ClinicalDocument()
    {
        //do nothing
    }

    public ClinicalDocument(String name, String xmlContent)
    {
        this.name = name;
        this.xmlContent = xmlContent;
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
    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    @Lob
    @Column(columnDefinition="CLOB(1 M)")
    public String getXmlContent()
    {
        return xmlContent;
    }

    public void setXmlContent(String xmlContent)
    {
        this.xmlContent = xmlContent;
    }
}

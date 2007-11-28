package org.projectlaika.models;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/**
 * Container for Rules to bind values to variables in the XPath
 * expression specified in the document location.
 * 
 * @author Andy Gregorowicz
 */
@Entity
public class BoundVariable implements Serializable
{
    private static final long serialVersionUID = 1592925784301070714L;
    
    private int id;
    private String name;
    private String expectedValue;
    
    public BoundVariable()
    {
        //do nothing
    }

    public BoundVariable(String name, String expectedValue)
    {
        this.name = name;
        this.expectedValue = expectedValue;
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

    @Basic
    public String getExpectedValue()
    {
        return expectedValue;
    }

    public void setExpectedValue(String expectedValue)
    {
        this.expectedValue = expectedValue;
    }
}

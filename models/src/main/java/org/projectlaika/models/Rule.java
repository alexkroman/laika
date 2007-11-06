package org.projectlaika.models;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Provides an expected value for a particular DocumentLocation. Also lets the user define error
 * messages for when the DocumentLocation does not exist, or is not the correct value.
 *
 * @author Andy Gregorowicz
 */
@Entity
@Table(name="rules")
public class Rule implements Serializable
{
    private static final long serialVersionUID = -4451635264898670376L;

    private int id;
    private String expectedValue;
    private String differentValueErrorMessage;
    private String missingValueErrorMessage;
    private DocumentLocation documentLocation;

    public Rule()
    {
        //do nothing
    }

    public Rule(String expectedValue, DocumentLocation documentLocation)
    {
        this.expectedValue = expectedValue;
        this.documentLocation = documentLocation;
    }

    public Rule(String expectedValue, String differentValueErrorMessage,
            String missingValueErrorMessage, DocumentLocation documentLocation)
    {
        this.expectedValue = expectedValue;
        this.differentValueErrorMessage = differentValueErrorMessage;
        this.missingValueErrorMessage = missingValueErrorMessage;
        this.documentLocation = documentLocation;
    }

    @ManyToOne
    public DocumentLocation getDocumentLocation()
    {
        return documentLocation;
    }

    public void setDocumentLocation(DocumentLocation documentLocation)
    {
        this.documentLocation = documentLocation;
    }

    @Column(length=200, nullable=false)
    public String getExpectedValue()
    {
        return expectedValue;
    }

    public void setExpectedValue(String expectedValue)
    {
        this.expectedValue = expectedValue;
    }

    @Basic
    public String getDifferentValueErrorMessage()
    {
        return differentValueErrorMessage;
    }

    public void setDifferentValueErrorMessage(String differentValueErrorMessage)
    {
        this.differentValueErrorMessage = differentValueErrorMessage;
    }

    @Basic
    public String getMissingValueErrorMessage()
    {
        return missingValueErrorMessage;
    }

    public void setMissingValueErrorMessage(String missingValueErrorMessage)
    {
        this.missingValueErrorMessage = missingValueErrorMessage;
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

package org.projectlaika.models;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

/**
 * Provides an expected value for a particular DocumentLocation. Also lets the user define error
 * messages for when the DocumentLocation does not exist, or is not the correct value.
 *
 * @author Andy Gregorowicz
 */
@Entity
public class Rule implements Serializable
{
    private static final long serialVersionUID = -4451635264898670376L;

    private int id;
    private String differentValueErrorMessage;
    private String missingValueErrorMessage;
    private DocumentLocation documentLocation;
    private List<BoundVariable> boundVariables;

    public Rule()
    {
        //do nothing
    }

    public Rule(DocumentLocation documentLocation,
            List<BoundVariable> boundVariables)
    {
        this.documentLocation = documentLocation;
        this.boundVariables = boundVariables;
    }

    public Rule(DocumentLocation documentLocation,
                BoundVariable boundVariable)
    {
        this.documentLocation = documentLocation;
        this.boundVariables = new LinkedList<BoundVariable>();
        this.boundVariables.add(boundVariable);
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
    
    @OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
    public List<BoundVariable> getBoundVariables()
    {
        return boundVariables;
    }

    
    public void setBoundVariables(List<BoundVariable> boundVariables)
    {
        this.boundVariables = boundVariables;
    }
}

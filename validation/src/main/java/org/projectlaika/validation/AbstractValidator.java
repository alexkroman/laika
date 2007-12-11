/**
 * 
 */
package org.projectlaika.validation;

/**
 * @author bobd
 * 
 */
public abstract class AbstractValidator implements Validator
{

    private String id;

    /*
     * (non-Javadoc)
     * 
     * @see org.projectlaika.validation.Validator#getId()
     */
    public String getId()
    {

        return id;
    }

    /*
     * (non-Javadoc)
     * 
     * @see org.projectlaika.validation.Validator#setId(java.lang.String)
     */
    public void setId(String id)
    {
        this.id = id;

    }

}

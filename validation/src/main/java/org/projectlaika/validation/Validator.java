package org.projectlaika.validation;

/**
 * Interface for validator's.
 * 
 * @author bobd
 * 
 */
public interface Validator
{
    /**
     * Get the assigned id of the validator
     * 
     * @return
     */
    String getId();

    /**
     * set the assigned id of the validator
     * 
     * @param id
     */
    void setId(String id);

    /**
     * Validate the document in the given context
     * 
     * @param context
     *            the document context to validate against
     * @return the result of the validation
     */
    void validate(ValidationContext context);
}

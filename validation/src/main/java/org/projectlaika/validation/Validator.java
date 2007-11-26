package org.projectlaika.validation;

/**
 * Interface for validator's. 
 * @author bobd
 *
 */
public interface Validator
{

    /**
     * Validate the document in the given context
     * @param context  the document context to validate against
     * @return  the result of the validation
     */
    ValidationResult validate(ValidationContext context);
}

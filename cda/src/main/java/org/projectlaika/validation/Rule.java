package org.projectlaika.validation;

/**
 * Provides an expected value for a particular DocumentLocation. Also lets the user define error
 * messages for when the DocumentLocation does not exist, or is not the correct value.
 *
 * @author Andy Gregorowicz
 */
public class Rule
{
    private String expectedValue;
    private String differentValueErrorMessage;
    private String missingValueErrorMessage;
    private DocumentLocation documentLocation;

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

    public DocumentLocation getDocumentLocation()
    {
        return documentLocation;
    }

    public void setDocumentLocation(DocumentLocation documentLocation)
    {
        this.documentLocation = documentLocation;
    }

    public String getExpectedValue()
    {
        return expectedValue;
    }

    public void setExpectedValue(String expectedValue)
    {
        this.expectedValue = expectedValue;
    }

    public String getDifferentValueErrorMessage()
    {
        return differentValueErrorMessage;
    }

    public void setDifferentValueErrorMessage(String differentValueErrorMessage)
    {
        this.differentValueErrorMessage = differentValueErrorMessage;
    }

    public String getMissingValueErrorMessage()
    {
        return missingValueErrorMessage;
    }

    public void setMissingValueErrorMessage(String missingValueErrorMessage)
    {
        this.missingValueErrorMessage = missingValueErrorMessage;
    }
}

package org.projectlaika.validation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.jdom.Content;
import org.jdom.Document;
import org.jdom.Element;

public class ValidationContext
{
    /**
     * Set of properties that can be used to pass additional information on to the 
     * validator's
     */
    private Map<String,Object> validationProperties = new HashMap<String,Object>();
    private Document document;
    private List<ValidationResult> results = new ArrayList<ValidationResult>();
    
    
    /**
     * Constructor
     * @param doc the document that is under validation
     */
    public ValidationContext(Document doc){
        this.document=doc;
        
    }
    
    /**
     * @return the validationProperties
     */
    public Map getValidationProperties()
    {
        return validationProperties;
    }
    /**
     * @param validationProperties the validationProperties to set
     */
    public void setValidationProperties(Map<String,Object> validationProperties)
    {
        this.validationProperties = validationProperties;
    }
    /**
     * @return the validationObject
     */
    public Document getDocument()
    {
        return document;
    }
    
    /**
     * Set a validation property
     * @param prop  the property name
     * @param value  the property value
     */
    public void setProperty(String prop, Object value){
        validationProperties.put(prop, value);
    }
    
    /**
     * Retrieve a validation property
     * @param prop  name of the property to get
     * @return  the value of the property
     */
    public Object getProperty(String prop){
        return validationProperties.get(prop);
    }

    /**
     * @return the results
     */
    public List<ValidationResult> getResults()
    {
        return results;
    }

    /**
     * 
     * Add a validation result to the context list
     * @param result the result to add
     * @return
     * @see java.util.List#add(java.lang.Object)
     */
    public boolean add(ValidationResult result)
    {
        return results.add(result);
    }
    
    
    /**
     * Is the validation valid
     * @return
     */
    public boolean isValid(){
        boolean isValid = true;
        for (Iterator iterator = results.iterator(); iterator.hasNext();)
        {
            ValidationResult result = (ValidationResult) iterator.next();
            isValid = isValid && result.isValid();
        }
        
        return isValid;
    }
    
    

}

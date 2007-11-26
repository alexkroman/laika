package org.projectlaika.validation;

import java.util.HashMap;
import java.util.Map;

import org.jdom.Document;

public class ValidationContext
{
    /**
     * Set of properties taht can be used to pass addional infor mation on to the 
     * validator's
     */
    private Map<String,Object> validationProperties = new HashMap<String,Object>();
    private Document document;
    
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

}

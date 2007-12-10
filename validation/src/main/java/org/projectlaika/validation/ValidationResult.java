package org.projectlaika.validation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.jdom.Content;
import org.jdom.Element;
import org.jdom.Text;

public class ValidationResult
{
    /**
     * ID of the validator for the results
     */
    private String validatorId;
    

    
    /** 
     * Boolean used to tell if the validation is successful or not
     * Set to true at first
     */
    private boolean isValid = true;
    
    /**
     * Validation properties that can be used by validators to convey additional information to the 
     * client
     */
    private Map<String,Object> validationProperties = new HashMap<String,Object>();
    
    /**
     * List of errors that may have occurred during validation
     */
    private List<ValidationMsg> errors = new ArrayList<ValidationMsg>();

    
    private List<ValidationMsg> warnings = new ArrayList<ValidationMsg>();
    /**
     * Constructor
     * @param id id of the validator the results are for
     */
    public ValidationResult(String id){
        this.validatorId = id;
       
        
    }
    
    /**
     * Gett the id of the validator that the result is for
     * @return
     */
    public String getValidatorId(){
        return validatorId;
    }
    
    
    /**
     * @return the isValid
     */
    public boolean isValid()
    {
        return isValid;
    }

    /**
     * @param isValid
     *            the isValid to set
     */
    public void setValid(boolean isValid)
    {
        this.isValid = isValid;
    }

    /**
     * Add an error to the list
     * @param msg the error msg
     * @param obj the error object
     */
    public void addError(String location, String msg, Object obj)
    {
        ValidationMsg e = new ValidationMsg(location,msg,obj);
        errors.add(e);
    }
    
    /**
     * Add an error to the list
     * @param e the error
     */
    public void addWarning(String location,String msg, Object obj)
    {
        ValidationMsg e = new ValidationMsg(location,msg,obj);
        warnings.add(e);
    }    

    /**
     * Get the list of Errors
     * @return
     */
    public List getErrors(){
        return errors;
    }
    
    
    /**
     * Get the list of Errors
     * @return
     */
    public List getWarnings(){
        return warnings;
    }
    

    
    
   
    
    /**
     * Simple wrapper class to store error information
     * @author bobd
     *
     */
    public class ValidationMsg{
        String msg;
        Object errorObject;
        String location;
        public ValidationMsg(String location,String msg, Object errorObject)
        {
            this.location=location;
            this.msg = msg;
            this.errorObject = errorObject;
        }
        
        /**
         * @return the msg
         */
        public String getMsg()
        {
            return msg;
        }
        /**
         * @param msg the msg to set
         */
        public void setMsg(String msg)
        {
            this.msg = msg;
        }
        /**
         * @return the errorObject
         */
        public Object getErrorObject()
        {
            return errorObject;
        }
        
        /**
         * @param errorObject the errorObject to set
         */
        public void setErrorObject(Object errorObject)
        {
            this.errorObject = errorObject;
        }
        
        @Override
        public String toString(){
            return this.msg + ((errorObject == null)? "" :errorObject);
        }

        public String getLocation()
        {
            return location;
        }

        public void setLocation(String location)
        {
            this.location = location;
        }
       
    }

}

package org.projectlaika.validation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ValidationResult
{
    /** 
     * Boolean used to tell if the validation is successful or not
     */
    private boolean isValid;
    
    /**
     * Validation properties that can be used by validators to convey additional information to the 
     * client
     */
    private Map<String,Object> validationProperties = new HashMap<String,Object>();
    
    /**
     * List of errors that may have occurred during validation
     */
    private List<Error> errors = new ArrayList<Error>();

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
    public void addError(String msg, Object obj)
    {
        Error e = new Error(msg,obj);
        errors.add(e);
    }
    
    /**
     * Add an error to the list
     * @param e the error
     */
    public void addError(Error e)
    {
        
        errors.add(e);
    }    

    /**
     * Set a validation property 
     * @param prop property name
     * @param value property value
     */
    public void setProperty(String prop, Object value)
    {
        validationProperties.put(prop, value);
    }
    
    /**
     * Simple wrapper class to store error information
     * @author bobd
     *
     */
    public class Error{
        String msg;
        Object errorObject;
        public Error(String msg, Object errorObject)
        {
            
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
       
    }

}

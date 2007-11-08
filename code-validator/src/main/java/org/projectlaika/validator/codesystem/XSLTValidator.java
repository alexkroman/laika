package org.projectlaika.validator.codesystem;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.w3c.dom.NodeList;


/**
 * Simple class used to aggregate the validation of other validators into one entry point.
 * Thought it would be somewhat benificial at first to have one interface that we
 * could use to validate different codeSystems.
 * @author bobd
 *
 */
public class XSLTValidator{
	
	
	static private Map<String, Validator> systemValidators = Collections.synchronizedMap(new HashMap<String, Validator>());
    static public Validator val = null;
    public static void registerSystemValidator(String systemOID, Validator validator){
    	
    	systemValidators.put(systemOID, validator);
    }
	
    
    public static void removeSystemValidator(String systemOID){
    	
    	systemValidators.remove(systemOID);
    }

    
    public static boolean validateCode(String system, String code, boolean includeInActive){
    	//Validator validator = systemValidators.get(system);
    	//return validator.validateCode(system,code,includeInActive);
    	System.out.println(system + " " + code +" " + includeInActive);
    	return val.validateCode(system, code, includeInActive);
    }

    
    public static boolean hasValidator(String systemOID){
    	return (systemValidators.get(systemOID) != null);
    }
   


}

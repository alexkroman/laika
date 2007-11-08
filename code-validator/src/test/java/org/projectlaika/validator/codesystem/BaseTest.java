package org.projectlaika.validator.codesystem;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import junit.framework.TestCase;

import org.ho.yaml.Yaml;
import org.projectlaika.validator.codesystem.Validator;

public abstract class BaseTest extends TestCase {

	private static String VALIDATE_CODES = "ValidateCode";
	private static String VALIDATE_RELATIONSHIPS = "ValidateRelationship";
	Map testConfig = new HashMap();
	Validator validator;
	
	public BaseTest(){
		super();
	}
	
	public BaseTest(String name){
		super(name);
	}
	
	protected void setValidator(Validator val){
		this.validator = val;
	}
	
	protected void setUp()throws Exception{
		
	}
	
	/**
	 * Test method for {@link org.projectlaika.validator.codesystem.UMLSValidator#validateCode(java.lang.String, java.lang.String, boolean)}.
	 */
	public void testValidateCode() {
		List<Map> codeTests = (List)testConfig.get(VALIDATE_CODES);
		
		for (Map test : codeTests) {
			boolean result = validator.validateCode((String)test.get("system"),
							(String)test.get("code"), 
							((Boolean)test.get("useInactive")).booleanValue());
			boolean expected =((Boolean)test.get("expected")).booleanValue();
			if(result!= expected){
				fail("Wrong expected value for test " + test.toString());
			}
		}

	}

	/**
	 * Test method for {@link org.projectlaika.validator.codesystem.UMLSValidator#validateRelationship(java.lang.String, java.lang.String, java.lang.String, java.lang.String)}.
	 */
	public void testValidateRelationship() {
	//	fail("Not yet implemented");
	}


	
	protected void loadTestsConfig(File file)throws Exception{
		testConfig = (Map)Yaml.load(file);
		
	}
	
}

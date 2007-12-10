package org.projectlaika.validator.codesystem;

/**
 * Interface class for creating Code validators for CDA documents.
 * 
 * @author bobd
 * 
 */
public interface Validator
{

    /**
     * Determine whether or not a code exist in a given code system.
     * 
     * @param system
     *            the code system to validate the code against
     * @param code
     *            the code
     * @param includeInActive
     *            whether or not to include inactive codes while performing the
     *            validation
     * @return
     */
    boolean validateCode(String system, String code, boolean includeInActive);

    /**
     * Determine whether or not a given code with the given name exists in a
     * given code system.
     * 
     * @param system
     *            The code system to validate the code against
     * @param code
     *            The code to validate
     * @param codeName
     *            The name of the code
     * @param includeInActive
     *            Whether or not to include inactive codes in the validation
     * @return
     */
    boolean validateCode(String system, String code, String codeName,
            boolean includeInActive);

    /**
     * Determine whether or not there exists a relationship between 2 codes in a
     * given code system.
     * 
     * @param system
     *            The code system to check against
     * @param code1
     *            The first code
     * @param code2
     *            The second code
     * @param relationship
     *            The relationship to check for
     * @param useInactive
     *            Whether or not to use inactive codes
     * @return
     */
    boolean validateRelationship(String system, String code1, String code2,
            String relationship, boolean useInactive);
    
    /**
     * Determine whether or not there exists a relationship between 2 codes in a
     * given code system.
     * 
     * @param system
     *            The code system to check against
     * @param parent
     *            the code that would be the higher in the hierarchy the the child
     * @param child
     *            the code that would be lower in the hierarchy then the parent
     * @return
     *    true if there exist a condition where the parent code is in a tree with the child code 
     *    in a sub tree under the parent code, false otherwise
     */
    boolean validateHierarchyRelationship(String system, String parent, String child);
}

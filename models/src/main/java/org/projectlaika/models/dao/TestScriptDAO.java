package org.projectlaika.models.dao;

import org.projectlaika.models.TestScript;

/**
 * Data access object for TestScripts
 * @author Andy Gregorowicz
 */
public class TestScriptDAO extends AbstractDAOBase<TestScript>
{
    public TestScriptDAO()
    {
        setModel(TestScript.class);
    }
}

package org.projectlaika.models;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

/**
 * This class holds a list of Rules that are to be run against an
 * instance clinical document as part of a validation process.
 *
 * @author Andy Gregorowicz
 */
@Entity
public class TestScript implements Serializable
{
    private static final long serialVersionUID = 1645353676274869058L;
    
    private int id;
    private String name;
    private List<Rule> rules;
    
    public TestScript()
    {
        this.rules = new LinkedList<Rule>();
    }

    public TestScript(String name, List<Rule> rules)
    {
        super();
        this.name = name;
        this.rules = rules;
    }

    /**
     * Adds a rule to this TestScript
     * @param rule
     */
    public void addRule(Rule rule)
    {
        this.rules.add(rule);
    }

    @Id
    @GeneratedValue
    public int getId()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    @Basic
    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    @ManyToMany
    public List<Rule> getRules()
    {
        return rules;
    }

    public void setRules(List<Rule> rules)
    {
        this.rules = rules;
    }
    
    

}

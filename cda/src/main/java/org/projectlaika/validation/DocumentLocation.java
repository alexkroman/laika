package org.projectlaika.validation;

/**
 * Describes a specific location in a CDA/CCD/C32 document by an XPath expression. Allows the user
 * to provide a name for the location and a description as well.
 *
 * @author Andy Gregorowicz
 */
public class DocumentLocation
{
    private String name;
    private String xpathExpression;
    private String description;

    public DocumentLocation(String name, String xpathExpression)
    {
        this.name = name;
        this.xpathExpression = xpathExpression;
    }

    public DocumentLocation(String name, String xpathExpression, String description)
    {
        this.name = name;
        this.xpathExpression = xpathExpression;
        this.description = description;
    }

    public String getName()
    {
        return name;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public String getXpathExpression()
    {
        return xpathExpression;
    }

    public void setXpathExpression(String xpathExpression)
    {
        this.xpathExpression = xpathExpression;
    }

    public String getDescription()
    {
        return description;
    }

    public void setDescription(String description)
    {
        this.description = description;
    }


}

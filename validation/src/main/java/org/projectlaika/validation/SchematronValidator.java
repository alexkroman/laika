package org.projectlaika.validation;

import java.util.List;

import javax.xml.transform.Source;
import javax.xml.transform.TransformerException;

import org.jdom.JDOMException;
import org.jdom.transform.JDOMResult;
import org.jdom.transform.JDOMSource;
import org.jdom.xpath.XPath;

/**
 * A validation class that will run the schematron xslt transform on a given document and then check 
 * for the existence of any assert reports for the given phase.  If there are reports for the given
 * phase then the validation will be considered to have failed.
 * @author bobd
 *
 */
public class SchematronValidator implements Validator
{
   
    /**
     * The xslt processor that will do the transform
     */
    private XSLTProcessor xsltProcessor;
    
    /**
     * The error phased to look for
     */
    private String phase;
    
    /**
     * Default constructor
     */
    public SchematronValidator(){
        
    }

    /**
     * @return the xsltProcessor
     */
    public XSLTProcessor getXsltProcessor()
    {
        return xsltProcessor;
    }

    /**
     * @param xsltProcessor the xsltProcessor to set
     */
    public void setXsltProcessor(XSLTProcessor xsltProcessor)
    {
        this.xsltProcessor = xsltProcessor;
    }

    /**
     * @return the phase
     */
    public String getPhase()
    {
        return phase;
    }

    /**
     * @param phase the phase to set
     */
    public void setPhase(String phase)
    {
        this.phase = phase;
    }

    /* (non-Javadoc)
     * @see org.projectlaika.validation.Validator#validate(org.projectlaika.validation.ValidationContext)
     */
    public ValidationResult validate(ValidationContext context)
    {
        ValidationResult result = new ValidationResult();
        JDOMResult res = new JDOMResult();
        
        try{
        Source source = new JDOMSource(context.getDocument());
        xsltProcessor.transform(source, res);
        // find all of the phased errors
        XPath xpath = XPath.newInstance("");
        List nodes = xpath.selectNodes(res.getDocument());
        if(nodes.size() > 0){
          result.setValid(false);  
        }
        
        result.setProperty("", res.getDocument());
        }
        catch (JDOMException e) {
            result.setValid(false); 
            result.addError(e.getLocalizedMessage(),e);
        }
        catch (TransformerException e) {
            result.setValid(false); 
            result.addError(e.getLocalizedMessage(),e);
        }
        return result;
    }
    
    
    

    
}

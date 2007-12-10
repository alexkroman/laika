package org.projectlaika.validation;

import java.util.Iterator;
import java.util.List;

import javax.xml.transform.Source;
import javax.xml.transform.TransformerException;

import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.Namespace;
import org.jdom.transform.JDOMResult;
import org.jdom.transform.JDOMSource;
import org.jdom.xpath.XPath;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A validation class that will run the schematron xslt transform on a given document and then check 
 * for the existence of any assert reports for the given phase.  If there are reports for the given
 * phase then the validation will be considered to have failed.
 * @author bobd
 *
 */
public class SchematronValidator extends AbstractValidator
{
    
    private static Namespace SVRL = Namespace.getNamespace("svrl","http://purl.oclc.org/dsdl/svrl");
    
   private static Logger logger = LoggerFactory.getLogger(SchematronValidator.class);
   
    /**
     * The xslt processor that will do the transform
     */
    private XSLTProcessor xsltProcessor = new XSLTProcessor();;
    
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

    
    public void setStyleSheet(String sheet)throws Exception{
        xsltProcessor.setStyleSheet(sheet);
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
    public void validate(ValidationContext context)
    {
        ValidationResult result = new ValidationResult(this.getId());
        JDOMResult res = new JDOMResult();
        
        try{
        Source source = new JDOMSource(context.getDocument());
        xsltProcessor.transform(source, res);
        // find all of the phased errors
        XPath xpath = XPath.newInstance("//svrl:failed-assert");
        xpath.addNamespace(SVRL);
        List nodes = xpath.selectNodes(res.getDocument());
        logger.debug("Number of results is "+nodes.size());
        if(nodes.size() > 0){            
          result.setValid(false);  
        }
        
        for (Iterator iterator = nodes.iterator(); iterator.hasNext();)
        {
            Element el = (Element) iterator.next();            
            result.addError(el.getAttributeValue("location"),el.getChild("srvl:text", SVRL).getText(), el);           
        }

        logger.debug("Processed document is " + res.getDocument());
        }
        catch (JDOMException e) {
            logger.error("Error validating document " , e);
            result.setValid(false); 
            result.addError("",e.getLocalizedMessage(),e);
        }
        catch (TransformerException e) {
            logger.error("Error validating document " , e);
            result.setValid(false); 
            result.addError("",e.getLocalizedMessage(),e);
        }
        context.add(result);
        
    }
    
  

    
}

package org.projectlaika.models.serialization;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import org.jdom.Document;
import org.jdom.JDOMException;
import org.jdom.Text;
import org.jdom.input.SAXBuilder;
import org.jdom.xpath.XPath;
import org.junit.Test;
import org.projectlaika.models.DocumentLocation;
import org.projectlaika.models.Namespace;

import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;

public class XmlHandlerTest
{
    @Test
    public void testDumpDocumentLocations() throws JDOMException, IOException
    {
        DocumentLocation dl1 = new DocumentLocation("Name", "/cda:foo/cda:name");
        dl1.addNamespace(new Namespace("cda", "http://cda.org"));
        
        DocumentLocation dl2 = new DocumentLocation("Age", "/cda:foo/cda:age");
        dl2.addNamespace(new Namespace("cda", "http://cda.org"));
        
        List<DocumentLocation> docs = new ArrayList<DocumentLocation>();
        docs.add(dl1);
        docs.add(dl2);
        String xml = XmlHandler.dumpDocumentLocations(docs);
        SAXBuilder builder = new SAXBuilder();
        Document document = builder.build(new StringReader(xml));
        XPath xpath = XPath.newInstance("/list/documentLocation[1]/name/text()");
        Text firstNameTag = (Text) xpath.selectSingleNode(document);
        assertThat(firstNameTag.getText(), is("Name"));
        
        xpath = XPath.newInstance("/list/documentLocation[2]/name/text()");
        Text secondNameTag = (Text) xpath.selectSingleNode(document);
        assertThat(secondNameTag.getText(), is("Age"));
    }
    
    @Test
    public void testReadDocumentLocations() throws FileNotFoundException
    {
        Reader xmlStream = new FileReader("src/test/data/SampleDocumentLocationDump.xml");
        List<DocumentLocation> docs = XmlHandler.readDocumentLocations(xmlStream);
        assertThat(docs.get(0).getName(), is("Name"));
    }
}

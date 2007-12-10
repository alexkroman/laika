package org.projectlaika.models.serialization;

import java.io.InputStream;
import java.util.List;

import org.projectlaika.models.DocumentLocation;
import org.projectlaika.models.Namespace;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

/**
 * Class that allows easy import and export of Laika data as XML.
 *
 * @author Andy Gregorowicz
 */
public class XmlHandler
{
    private static XStream xstream;
    
    static
    {
        xstream = new XStream(new DomDriver());
        xstream.alias("documentLocation", DocumentLocation.class);
        xstream.alias("namespace", Namespace.class);
    }

    /**
     * Dump a list of DocumentLocations as XML into a String
     * @param docs
     * @return
     */
    public static String dumpDocumentLocations(List<DocumentLocation> docs)
    {
        return xstream.toXML(docs);
    }

    /**
     * Parse the XML to create a set of DocumentLocations
     * @param xml
     * @return
     */
    @SuppressWarnings("unchecked")
    public static List<DocumentLocation> readDocumentLocations(InputStream xml)
    {
        return (List<DocumentLocation>) xstream.fromXML(xml);
    }
}

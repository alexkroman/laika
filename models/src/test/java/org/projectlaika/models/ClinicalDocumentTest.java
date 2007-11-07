package org.projectlaika.models;

import static org.junit.Assert.*;
import static org.hamcrest.core.Is.*;

import java.io.FileReader;
import java.io.LineNumberReader;
import java.util.Properties;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ClinicalDocumentTest
{
    private EntityManager em;
    private EntityManagerFactory emf;
    
    @Before
    public void setUp() throws Exception
    {
        Properties props = new Properties();
        props.put("openjpa.ConnectionDriverName", "org.apache.derby.jdbc.EmbeddedDriver");
        props.put("openjpa.ConnectionURL", "jdbc:derby:target/db/laika-test-database;create=true");
        props.put("openjpa.ConnectionUserName", "");
        props.put("openjpa.ConnectionPassword", "");
        props.put("openjpa.jdbc.SynchronizeMappings", "buildSchema");
        props.put("openjpa.Log", "DefaultLevel=INFO,SQL=TRACE");
        
        emf = Persistence.createEntityManagerFactory("laika", props);
        em = emf.createEntityManager();
    }

    @Test
    public void testStoringXML() throws Exception
    {
        LineNumberReader reader = new LineNumberReader(
                                    new FileReader("src/test/data/SampleCCDDocument.xml"));
        StringBuffer buffer = new StringBuffer(70000);
        String temp = reader.readLine();
        while (temp != null)
        {
            buffer.append(temp);
            buffer.append('\n');
            temp = reader.readLine();
        }
        
        reader.close();
        
        String xmlDoc = buffer.toString();
        ClinicalDocument cd = new ClinicalDocument("Test Patient", xmlDoc);
        em.getTransaction().begin();
        em.persist(cd);
        em.getTransaction().commit();
        int cdId = cd.getId();

        ClinicalDocument savedCd = em.find(ClinicalDocument.class, cdId);
        assertThat(savedCd.getXmlContent(), is(xmlDoc));
        assertThat(savedCd.getName(), is("Test Patient"));
    }
    
    @After
    public void tearDown() throws Exception
    {
        em.close();
        emf.close();
    }

}

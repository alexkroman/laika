package org.projectlaika.models;

import static org.junit.Assert.*;
import static org.hamcrest.core.Is.*;

import java.util.Properties;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.projectlaika.models.Namespace;

public class PersistenceTest
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
        em.getTransaction().begin();
        em.createQuery("delete from Namespace n").executeUpdate();
        em.getTransaction().commit();
    }
    
    @After
    public void tearDown() throws Exception
    {
        em.close();
        emf.close();
    }
    
    @Test
    public void testPersistence() throws Exception
    {
        em.getTransaction().begin();
        em.persist(new Namespace("cda", "urn:hl7-org:v3"));
        em.getTransaction().commit();
        
        Query query = em.createQuery("select n from Namespace n where n.prefix = 'cda'");
        Namespace namespace = (Namespace) query.getSingleResult();
        
        assertThat(namespace.getUri(), is("urn:hl7-org:v3"));
    }

}

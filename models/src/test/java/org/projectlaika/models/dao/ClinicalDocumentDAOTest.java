package org.projectlaika.models.dao;

import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.core.Is.is;

import java.io.FileReader;
import java.io.LineNumberReader;
import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.projectlaika.models.ClinicalDocument;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

@ContextConfiguration(locations={"/spring.xml"})
public class ClinicalDocumentDAOTest extends AbstractTransactionalJUnit4SpringContextTests
{
    private ClinicalDocumentDAO clinicalDocumentDAO;

    @Autowired
    public void setClinicalDocumentDAO(ClinicalDocumentDAO clinicalDocumentDAO)
    {
        this.clinicalDocumentDAO = clinicalDocumentDAO;
    }
    @Before
    public void setUpDB()
    {
        deleteFromTables("CLINICALDOCUMENT");
        simpleJdbcTemplate.update("insert into CLINICALDOCUMENT (id, name, xmlContent) values (?, ?, ?)",
                5000, "Test Patient 1", "<ClinicalDocument>medical data</ClinicalDocument>");
        simpleJdbcTemplate.update("insert into CLINICALDOCUMENT (id, name, xmlContent) values (?, ?, ?)",
                5001, "Test Patient 2", "<ClinicalDocument>more medical data</ClinicalDocument>");
    }
    
    @Test
    public void testFindAll()
    {
        List<ClinicalDocument> docs = clinicalDocumentDAO.findAll();
        assertThat(docs.size(), is(2));
    }

    @Test
    public void testFind()
    {
        ClinicalDocument cd = clinicalDocumentDAO.find(5000);
        assertThat(cd.getName(), is("Test Patient 1"));
        assertThat(cd.getXmlContent(), is("<ClinicalDocument>medical data</ClinicalDocument>"));
    }

    @Test
    public void testDelete() throws Exception
    {
        clinicalDocumentDAO.delete(5000);
        assertThat(clinicalDocumentDAO.find(5000), is(nullValue()));
    }
    
    @Test
    public void testSave() throws Exception
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
        clinicalDocumentDAO.save(cd);
        ClinicalDocument savedCd = clinicalDocumentDAO.find(cd.getId());
        assertThat(savedCd.getXmlContent(), is(xmlDoc));
        assertThat(savedCd.getName(), is("Test Patient"));
    }
    
    @Test
    public void testUpdate()
    {
        ClinicalDocument cd = clinicalDocumentDAO.find(5000);
        cd.setName("A New Name");
        clinicalDocumentDAO.save(cd);
        ClinicalDocument renamedCd = clinicalDocumentDAO.find(5000);
        assertThat(renamedCd.getName(), is("A New Name"));
    }

}

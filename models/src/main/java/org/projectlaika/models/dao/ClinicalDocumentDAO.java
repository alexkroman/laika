package org.projectlaika.models.dao;

import org.projectlaika.models.ClinicalDocument;

/**
 * Data access object for ClinicalDocuments
 * @author Andy Gregorowicz
 */
public class ClinicalDocumentDAO extends AbstractDAOBase<ClinicalDocument>
{
    public ClinicalDocumentDAO()
    {
        setModel(ClinicalDocument.class);
    }
}

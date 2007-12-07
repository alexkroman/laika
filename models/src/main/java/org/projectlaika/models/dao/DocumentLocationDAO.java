package org.projectlaika.models.dao;

import org.projectlaika.models.DocumentLocation;

/**
 * Data access object for DocumentLocations
 * @author Andy Gregorowicz
 */
public class DocumentLocationDAO extends AbstractDAOBase<DocumentLocation>
{
    public DocumentLocationDAO()
    {
        setModel(DocumentLocation.class);
    }
}

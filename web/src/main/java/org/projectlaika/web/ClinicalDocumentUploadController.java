package org.projectlaika.web;

import javax.servlet.http.HttpServletRequest;

import org.projectlaika.models.ClinicalDocument;
import org.projectlaika.models.dao.ClinicalDocumentDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.support.StringMultipartFileEditor;
import org.springframework.web.servlet.mvc.SimpleFormController;

/**
 * Handles the upload of a ClinicalDocumet into the database
 *
 * @author Andy Gregorowicz
 */
@Controller
@RequestMapping("/clinicalDocument/upload.lk")
public class ClinicalDocumentUploadController extends SimpleFormController
{
    private ClinicalDocumentDAO clinicalDocumentDAO;
    
    @Autowired
    public ClinicalDocumentUploadController(ClinicalDocumentDAO clinicalDocumentDAO)
    {
        this.clinicalDocumentDAO = clinicalDocumentDAO;
        setCommandClass(ClinicalDocument.class);
        setCommandName("clinicalDocument");
        setFormView("clinicalDocument/uploadForm");
        setSuccessView("clinicalDocument/view");
    }

    @Override
    protected void doSubmitAction(Object command) throws Exception
    {
        ClinicalDocument cd = (ClinicalDocument) command;
        clinicalDocumentDAO.save(cd);
    }

    /**
     * Lets Spring know how to handle translating the file upload into the clinical
     * document bean.
     */
    @Override
    protected void initBinder(HttpServletRequest request,
            ServletRequestDataBinder binder) throws Exception
    {
        binder.registerCustomEditor(String.class, new StringMultipartFileEditor());
    }

}

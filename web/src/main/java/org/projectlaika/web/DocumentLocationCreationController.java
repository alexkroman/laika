package org.projectlaika.web;

import javax.servlet.http.HttpServletRequest;

import org.projectlaika.models.DocumentLocation;
import org.projectlaika.models.Namespace;
import org.projectlaika.models.dao.DocumentLocationDAO;
import org.projectlaika.web.util.LazyListHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.SimpleFormController;

/**
 * Controller that allows users to create DocumentLocations via a web
 * interface
 *
 * @author Andy Gregorowicz
 */
@Controller
@RequestMapping("/documentLocation/edit.lk")
public class DocumentLocationCreationController extends SimpleFormController
{
    private DocumentLocationDAO documentLocationDAO;
    
    @Autowired
    public DocumentLocationCreationController(DocumentLocationDAO documentLocationDAO)
    {
        this.documentLocationDAO = documentLocationDAO;
        setCommandClass(DocumentLocation.class);
        setCommandName("documentLocation");
        setFormView("documentLocation/create");
        setSuccessView("documentLocation/display");
    }

    @Override
    protected Object formBackingObject(HttpServletRequest request)
            throws Exception
    {
        String id = request.getParameter("dl_id");
        DocumentLocation dl = null;
        if (id != null)
        {
            dl = documentLocationDAO.find(Integer.parseInt(id));
        }
        else
        {
            dl = new DocumentLocation();
        }
        
        LazyListHelper.decorateList(dl, "namespaces", Namespace.class);
        
        return dl;
    }

    @Override
    protected void doSubmitAction(Object command) throws Exception
    {
        DocumentLocation dl = (DocumentLocation) command;
        LazyListHelper.removeDecoration(dl, "namespaces");
        if (dl.getId() != 0)
        {
            documentLocationDAO.update(dl);
        }
        else
        {
            documentLocationDAO.save(dl);
        }
    }
}

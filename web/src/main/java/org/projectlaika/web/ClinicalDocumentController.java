package org.projectlaika.web;

import java.util.List;

import org.projectlaika.models.dao.ClinicalDocumentDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ClinicalDocumentController
{
    private Logger log = LoggerFactory.getLogger(this.getClass());
    private ClinicalDocumentDAO clinicalDocumentDAO;
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/clinicalDocument/list.lk")
    public ModelMap list()
    {
        List docs = clinicalDocumentDAO.findAll();
        log.debug("Got {} clinical documents", docs.size());
        return new ModelMap("clinicalDocumentList", docs);
    }

    @RequestMapping("/clinicalDocument/delete.lk")
    public String delete(@RequestParam(value="cd_id") int id)
    {
        clinicalDocumentDAO.delete(id);
        return "redirect:/clinicalDocument/list.lk";
    }

    @Autowired
    public void setClinicalDocumentDAO(ClinicalDocumentDAO clinicalDocumentDAO)
    {
        this.clinicalDocumentDAO = clinicalDocumentDAO;
    }

}

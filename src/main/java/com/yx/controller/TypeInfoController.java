package com.yx.controller;

import com.github.pagehelper.PageInfo;
import com.yx.po.TypeInfo;
import com.yx.service.TypeInfoService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
public class TypeInfoController {

    @Autowired
    private TypeInfoService typeInfoService;

    /**
     * Page index de la gestion des types
     * @return
     */
    @GetMapping("/typeIndex")
    public String typeIndex(){
        return "type/typeIndex";
    }

    /**
     * Obtenir des informations sur les données de type, pagination
     */
    @RequestMapping("/typeAll")
    // @ResponseBody convertit l'objet Java en données au format json, indiquant que le résultat de retour
    // de cette méthode est directement écrit dans le body de la réponse HTTP. Généralement, les informations
    // et la pagination sont utilisées lorsque l'ajax asynchrone obtient des données.
    @ResponseBody
    public DataInfo typeAll(String name, @RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "10") Integer limit){
        PageInfo<TypeInfo> pageInfo = typeInfoService.queryTypeInfoAll(name,pageNum,limit);
        return DataInfo.ok("Success",pageInfo.getTotal(),pageInfo.getList());
        // Le nombre total d'éléments est getTotal, et les données sont encapsulées dans une liste pour
        // le chargement et l'affichage de la pagination. Puisque le ResponseBody est ajouté, un String sera renvoyée.
    }

    /**
     * Ajouter un type
     */
    @GetMapping("/typeAdd")
    public String typeAdd(){
        return "type/typeAdd";
    }

    /**
     * Soumission de l'ajout
     */
    @PostMapping("/addTypeSubmit")
    @ResponseBody
    public DataInfo addTypeSubmit(TypeInfo info){
        typeInfoService.addTypeSubmit(info);
        return DataInfo.ok();
    }

    /**
     * Rechercher par id (modification)
     */
    @GetMapping("/queryTypeInfoById")
    public String queryTypeInfoById(Integer id, Model model){
        TypeInfo info= typeInfoService.queryTypeInfoById(id);
        model.addAttribute("info",info);
        return "type/updateType";
    }

    /**
     * Soumission de modification
     */

    @RequestMapping("/updateTypeSubmit")
    @ResponseBody
    public DataInfo updateTypeSubmit(@RequestBody TypeInfo info){
        typeInfoService.updateTypeSubmit(info);
        return DataInfo.ok();
    }

    /**
     * Suppression de type
     */
    @RequestMapping("/deleteType")
    @ResponseBody
    public DataInfo deleteType(String ids){
        List<String> list= Arrays.asList(ids.split(","));
        typeInfoService.deleteTypeByIds(list);
        return DataInfo.ok();
    }
}

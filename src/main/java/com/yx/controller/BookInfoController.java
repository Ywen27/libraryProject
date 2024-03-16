package com.yx.controller;

import com.github.pagehelper.PageInfo;
import com.yx.po.BookInfo;
import com.yx.po.TypeInfo;
import com.yx.service.BookInfoService;
import com.yx.service.TypeInfoService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@Controller
public class BookInfoController {

    @Autowired
    private BookInfoService bookInfoService;

    @Autowired
    private TypeInfoService typeInfoService;

    /**
     * Page d'accueil de la gestion des livres
     * @return
     */
    @GetMapping("/bookIndex")
    public String bookIndex(){
        return "book/bookIndex";
    }

    @GetMapping("/bookIndexForReader")
    public String bookIndexForReader(){
        return "book/bookIndexForReader";
    }

    /**
     * Obtenez des informations sur le livre et encapsulez-les dans JSON
     * @param bookInfo
     * @param pageNum
     * @param limit
     * @return
     */
    @RequestMapping("/bookAll")
    @ResponseBody       // @ResponseBody convertit l'objet Java en données au format json, indiquant que le résultat de
                        // retour de cette méthode est directement écrit dans le corps de la réponse HTTP. Il est
                        // généralement utilisé lorsqu'un ajax asynchrone obtient des données.
    public DataInfo bookAll(BookInfo bookInfo, @RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "15") Integer limit){
        PageInfo<BookInfo> pageInfo = bookInfoService.queryBookInfoAll(bookInfo,pageNum,limit);
        return DataInfo.ok("Success",pageInfo.getTotal(),pageInfo.getList());//Le nombre total d'éléments est getTotal,
        // et les données sont encapsulées dans une liste pour le chargement et l'affichage de la pagination.
        // Puisque le ResponseBody est ajouté, une chaîne sera renvoyée.
    }

    /**
     * Page ajouter une livre
     */
    @GetMapping("/bookAdd")
    public String bookAdd(){
        return "book/bookAdd";
    }

    /**
     * Soumettre l'ajout
     */
    @RequestMapping("/addBookSubmit")
    @ResponseBody
    public DataInfo addBookSubmit(BookInfo info){
        bookInfoService.addBookSubmit(info);
        return DataInfo.ok();
    }

    /**
     * Rechercher par ids (modification)
     */
    @GetMapping("/queryBookInfoById")
    public String queryTypeInfoById(Integer id, Model model){
        BookInfo bookInfo= bookInfoService.queryBookInfoById(id);
        model.addAttribute("info",bookInfo);
        return "book/updateBook";
    }

    /**
     * Soumettre modification
     */

    @RequestMapping("/updateBookSubmit")
    @ResponseBody
    public DataInfo updateBookSubmit(@RequestBody BookInfo info){
        bookInfoService.updateBookSubmit(info);
        return DataInfo.ok();
    }
    /**
     * Suppression des livres
     */

    @RequestMapping("/deleteBook")
    @ResponseBody
    public DataInfo deleteBook(String ids){
        List<String> list= Arrays.asList(ids.split(","));
        bookInfoService.deleteBookByIds(list);
        return DataInfo.ok();
    }

    @RequestMapping("/findAllList")
    @ResponseBody
    public List<TypeInfo> findAll(){
        PageInfo<TypeInfo> pageInfo = typeInfoService.queryTypeInfoAll(null,1,100);
        List<TypeInfo> lists = pageInfo.getList();
        return lists;
    }
}

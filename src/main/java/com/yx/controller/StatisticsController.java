package com.yx.controller;

import com.yx.po.BookInfo;
import com.yx.service.BookInfoService;
import com.yx.service.TypeInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class StatisticsController {

    @Autowired
    private BookInfoService bookInfoService;

    @Autowired
    private TypeInfoService typeInfoService;

    @GetMapping("statisticIndex")
    public String statistics(Model model){
        //Le nombre de livres en fonction du type de livre
        List<BookInfo> list = bookInfoService.getBookCountByType();
        model.addAttribute("list",list);
        return "count/statisticIndex";
    }
}

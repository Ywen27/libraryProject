package com.yx.controller;

import com.github.pagehelper.PageInfo;
import com.yx.po.Notice;
import com.yx.service.NoticeService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    /**
     *  Notice for admin
     */
    @GetMapping("/noticeIndexOfBack")
    public String noticeIndexOfBack(){
        return "notice/noticeIndexOfBack";
    }
    /**
     *  Notice for reader
     */
    @GetMapping("/noticeIndexOfReader")
    public String noticeIndexOfReader(){
        return "notice/noticeIndexOfReader";
    }

    /**
     * Rechercher toutes les informations sur l'annonce
     */
    @RequestMapping("/noticeAll")
    @ResponseBody
    public DataInfo noticeAll(Notice notice,@RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "10")Integer limit){
        PageInfo<Notice> pageInfo = noticeService.queryAllNotice(notice, pageNum, limit);
        return DataInfo.ok("Success",pageInfo.getTotal(),pageInfo.getList());
    }
    /**
     * Ajouter une annonce
     */
    @GetMapping("/noticeAdd")
    public String noticeAdd(){
        return "notice/noticeAdd";
    }

    /**
     * Soumettre l'ajout
     */
    @RequestMapping("/addNoticeSubmit")
    @ResponseBody
    public DataInfo addNoticeSubmit(HttpServletRequest request, Notice notice){
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        notice.setAuthor(username);
        notice.setCreateDate(new Date());
        noticeService.addNotice(notice);
        return DataInfo.ok();
    }

    /**
     * Afficher les détails
     */
    @GetMapping("/queryNoticeById")
    public String queryNoticeById(Integer id, Model model){
        Notice notice = noticeService.queryNoticeById(id);
        model.addAttribute("info",notice);
        return "notice/updateNotice";
    }

    /**
     * Supprimer l'annonce
     */
    @RequestMapping("/deleteNoticeByIds")
    @ResponseBody
    public DataInfo deleteNoticeByIds(String ids){
        List<String> list = Arrays.asList(ids.split(","));
        noticeService.deleteNoticeByIds(list);
        return DataInfo.ok();
    }
}

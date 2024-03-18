package com.yx.controller;

import com.github.pagehelper.PageInfo;
import com.yx.po.Notice;
import com.yx.service.NoticeService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.xml.crypto.Data;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Controller
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    /**
     *  后台公告
     */
    @GetMapping("/noticeIndexOfBack")
    public String noticeIndexOfBack(){
        return "notice/noticeIndexOfBack";
    }
    /**
     *  后台公告
     */
    @GetMapping("/noticeIndexOfReader")
    public String noticeIndexOfReader(){
        return "notice/noticeIndexOfReader";
    }

    /**
     * 查询所有公告信息
     */
    @RequestMapping("/noticeAll")
    @ResponseBody
    public DataInfo noticeAll(Notice notice,@RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "15")Integer limit){
        PageInfo<Notice> pageInfo = noticeService.queryAllNotice(notice, pageNum, limit);
        return DataInfo.ok("成功",pageInfo.getTotal(),pageInfo.getList());
    }
    /**
     * 添加
     */
    @GetMapping("/noticeAdd")
    public String noticeAdd(){
        return "notice/noticeAdd";
    }

    /**
     * 添加提交
     */
    @RequestMapping("/addNoticeSubmit")
    @ResponseBody
    public DataInfo addNoticeSubmit(Notice notice){
        //主题和内容可以页面获取，作者和时间在后台自动获取
        notice.setAuthor("admin");//这里先暂且写admin
        notice.setCreateDate(new Date());
        noticeService.addNotice(notice);
        return DataInfo.ok();
    }

    /**
     * 查看详情（修改）
     */
    @GetMapping("/queryNoticeById")
    public String queryNoticeById(Integer id, Model model){
        Notice notice = noticeService.queryNoticeById(id);
        model.addAttribute("info",notice);
        return "notice/updateNotice";
    }

    /**
     * 删除公告
     */
    @RequestMapping("/deleteNoticeByIds")
    @ResponseBody
    public DataInfo deleteNoticeByIds(String ids){
        List<String> list = Arrays.asList(ids.split(","));
        noticeService.deleteNoticeByIds(list);
        return DataInfo.ok();
    }
}

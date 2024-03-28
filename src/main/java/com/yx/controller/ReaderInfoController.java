package com.yx.controller;

import com.github.pagehelper.PageInfo;
import com.yx.po.Admin;
import com.yx.po.ReaderInfo;
import com.yx.service.AdminService;
import com.yx.service.ReaderInfoService;
import com.yx.utils.DataInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;
import java.util.Date;

@Controller
public class ReaderInfoController {

    @Autowired
    private ReaderInfoService readerInfoService;

    @Autowired
    private AdminService adminService;

    /**
     * Accéder à la page de gestion des lecteurs
     */
    @GetMapping("/readerIndex")
    public String readerIndex(){
        return "reader/readerIndex";
    }

    /**
     * Rechercher tous les lecteurs
     */
    @RequestMapping("/readerAll")
    @ResponseBody
    public DataInfo queryReaderAll(ReaderInfo readerInfo, @RequestParam(defaultValue = "1") Integer pageNum, @RequestParam(defaultValue = "10") Integer limit){
        PageInfo<ReaderInfo> pageInfo = readerInfoService.queryAllReaderInfo(readerInfo,pageNum,limit);
        return DataInfo.ok("Success",pageInfo.getTotal(),pageInfo.getList());
    }

    /**
     * Accéder à la page d'ajout
     */
    @RequestMapping("/readerAdd")
    public String readerAdd(){
        return "reader/readerAdd";
    }

    /**
     * Soumettre l'ajout
     */
    @RequestMapping("/addReaderSubmit")
    @ResponseBody
    public DataInfo addReaderSubmit(@RequestBody ReaderInfo readerInfo){
        readerInfo.setPassword("123456");// Le mot de passe par défaut
        readerInfo.setRegisterDate(new Date()); // Set the current date and time as the register date
        readerInfoService.addReaderInfoSubmit(readerInfo);
        return DataInfo.ok();
    }

    /**
     * Interrogez les données en fonction de ID, puis accéder à la page de modification
     */
    @GetMapping("/queryReaderInfoById")
    public String queryReaderInfoById(@RequestParam(value = "id", required = false) Integer id, HttpServletRequest request, Model model){
        ReaderInfo readerInfo;
        if (id != null) {
            readerInfo = readerInfoService.queryReaderInfoById(id);
        } else {
            readerInfo = (ReaderInfo) request.getSession().getAttribute("user");
        }

        model.addAttribute("id", id);
        model.addAttribute("info", readerInfo);
        return "reader/updateReader";
    }

    /**
     * Soumettre la modification
     */
    @RequestMapping("/updateReaderSubmit")
    @ResponseBody
    public DataInfo updateReaderSubmit(@RequestBody ReaderInfo readerInfo){
        readerInfoService.updateReaderInfoSubmit(readerInfo);
        return DataInfo.ok();
    }

    /**
     * Suppression
     */
    @RequestMapping("/deleteReader")
    @ResponseBody
    public DataInfo deleteReader(String ids){
        List<String> list= Arrays.asList(ids.split(","));
        readerInfoService.deleteReaderInfoByIds(list);
        return DataInfo.ok();
    }

    /**
     * Changer le mot de passe dans le coin supérieur droit
     */
    @RequestMapping("/updatePwdSubmit2")
    @ResponseBody
    public DataInfo updatePwdSubmit(HttpServletRequest request, String oldPwd, String newPwd){
        HttpSession session = request.getSession();
        if(session.getAttribute("type")=="admin"){
            //Admin
            Admin admin = (Admin)session.getAttribute("user");
            Admin admin1 = (Admin)adminService.queryAdminById(admin.getId());
            if (!oldPwd.equals(admin1.getPassword())){
                return DataInfo.fail("The old password entered is wrong");
            }else{
                admin1.setPassword(newPwd);
                adminService.updateAdminSubmit(admin1);// Modification de la base de données
            }
        }else{
            //Lecteur
            ReaderInfo readerInfo = (ReaderInfo) session.getAttribute("user");
            ReaderInfo readerInfo1 = readerInfoService.queryReaderInfoById(readerInfo.getId());//
            if (!oldPwd.equals(readerInfo1.getPassword())){
                return DataInfo.fail("The old password entered is wrong");
            }else{
                readerInfo1.setPassword(newPwd);
                readerInfoService.updateReaderInfoSubmit(readerInfo1);// Modification de la base de données
            }
        }
        return DataInfo.ok();
    }
}

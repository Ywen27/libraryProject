package com.yx.controller;
import com.yx.codeutil.IVerifyCodeGen;
import com.yx.codeutil.SimpleCharVerifyCodeGenImpl;
import com.yx.codeutil.VerifyCode;
import com.yx.po.Admin;
import com.yx.po.ReaderInfo;
import com.yx.service.AdminService;
import com.yx.service.ReaderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class LoginController {
    @Autowired
    private AdminService adminService;
    @Autowired
    private ReaderInfoService readerService;
    /**
     * Redirection de la page de connexion
     */
    @GetMapping("/login")
    public String login(){
        return "login";
    }

    /**
     * Obtenir le code de vérification
     * @param request
     * @param response
     */
    @RequestMapping("/verifyCode")
    public void verifyCode(HttpServletRequest request, HttpServletResponse response) {
        IVerifyCodeGen iVerifyCodeGen = new SimpleCharVerifyCodeGenImpl();
        try {
            // Définir la longueur et la largeur
            VerifyCode verifyCode = iVerifyCodeGen.generate(80, 28);
            String code = verifyCode.getCode();
            // Lier VerifyCode à la session
            request.getSession().setAttribute("VerifyCode", code);
            // Définir les en-têtes de response
            response.setHeader("Pragma", "no-cache");
            // Définir les en-têtes de response
            response.setHeader("Cache-Control", "no-cache");
            // Empêcher la mise en mémoire tampon côté serveur proxy
            response.setDateHeader("Expires", 0);
            // Définir le type de contenu de la réponse
            response.setContentType("image/jpeg");
            response.getOutputStream().write(verifyCode.getImgBytes());
            response.getOutputStream().flush();
        } catch (IOException e) {
            System.out.println("Exception handling");
        }
    }

    /**
     * Login authentication
     */
    @RequestMapping("/loginIn")
    public String loginIn(HttpServletRequest request, Model model){
        // Obtenir le nom d'utilisateur et le mot de passe
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String code = request.getParameter("captcha");
        String type = request.getParameter("type");

        // Déterminer si le code de vérification est correct (le code de vérification a été mis dans la session)
        HttpSession session = request.getSession();
        String realCode = (String)session.getAttribute("VerifyCode");
        if (!realCode.toLowerCase().equals(code.toLowerCase())){
            model.addAttribute("msg","Incorrect verification code");
            return "login";
        }else{
            // Si le code de vérification est correct, déterminer le nom d'utilisateur et le mot de passe.
            if(type.equals("1")){ // Administrateur
                // Le nom d'utilisateur et le mot de passe sont-ils corrects?
                Admin admin=adminService.queryUserByNameAndPassword(username,password);
                if(admin==null){ // Cet utilisateur n'existe pas
                    model.addAttribute("msg","Wrong username or password");
                    return "login";
                }
                session.setAttribute("user",admin);
                session.setAttribute("type","admin");
                session.setAttribute("adminType", admin.getAdmintype());
                session.setAttribute("username", admin.getUsername());
            }else{ // Lecteur
                ReaderInfo readerInfo=readerService.queryUserInfoByNameAndPassword(username,password);
                if(readerInfo==null){
                    model.addAttribute("msg","Wrong username or password");
                    return "login";
                }
                session.setAttribute("user",readerInfo);
                session.setAttribute("readerId",readerInfo.getId());
                session.setAttribute("type","reader");
            }

            return "index";
        }
    }
    /**
     * Se déconnecter
     */
    @GetMapping("loginOut")
    public String loginOut(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.invalidate();//注销
        return "/login";
    }
}

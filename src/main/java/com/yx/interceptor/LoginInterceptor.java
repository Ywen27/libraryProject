package com.yx.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("Executed after handling the request and before sending the response....");
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        //Intercepter pendant le traitement
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // Si on est connecté, on serait autorisé, sinon on serait intercepté.
        HttpSession session=request.getSession();
        if(session.getAttribute("user")!=null){
            return true;
        }else{
            response.sendRedirect(request.getContextPath()+"/login");
            return false;
        }
    }
}

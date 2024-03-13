package com.yx.service;

import com.github.pagehelper.PageInfo;
import com.yx.po.Admin;

import java.util.List;
public interface AdminService {

    /**
     * Rechercher tous les administrateurs (pagination)
     */
    PageInfo<Admin> queryAdminAll(Admin admin,Integer pageNum,Integer limit);

    /**
     * Soummettre l'ajout
     */
    void addAdminSubmit(Admin admin);

    /**
     * Requête par id (modification)
     */
    Admin queryAdminById(Integer id);

    /**
     * Soumettre la modification
     */
    void updateAdminSubmit(Admin admin);

    /**
     * Suppression
     */
    void deleteAdminByIds(List<String> ids);

    /**
     * Rechercher les informations d'utilisateur à l'aide de username et du mot de passe
     */
    Admin queryUserByNameAndPassword(String username,String password);
}

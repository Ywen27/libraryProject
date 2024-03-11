package com.yx.dao;

import com.yx.po.TypeInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TypeInfoMapper {
    /**
     * Rechercher toutes les informations enregistrés.
     */
    List<TypeInfo> queryTypeInfoAll(@Param(value = "name") String name);

    /**
     * Ajout d'un livre
     */
    void addTypeSubmit(TypeInfo info);

    /**
     * Modifier un livre: rechercher les informations en fonction de ID, la requête
     * fera apparaître la fenêtre de modification, puis modifiera et confirmera la soumission.
     */
    TypeInfo queryTypeInfoById(Integer id);

    /**
     * Soumettre la modification
     */
    void updateTypeSubmit(TypeInfo info);

    /**
     * Supression par ID
     */
    void deleteTypeByIds(List<Integer> id);

    //List<TypeInfo> queryTypeName();
}
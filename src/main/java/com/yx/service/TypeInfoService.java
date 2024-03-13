package com.yx.service;

import com.github.pagehelper.PageInfo;
import com.yx.po.TypeInfo;

import java.util.List;

public interface TypeInfoService {
    /**
     * Rechercher tous les types
     */
    PageInfo<TypeInfo> queryTypeInfoAll(String name, Integer pageNum, Integer limit);

    /**
     * Ajouter un type
     */
    void addTypeSubmit(TypeInfo info);

    /**
     * Modifier les informations de type à l'aide de la requête par id
     */
    TypeInfo queryTypeInfoById(Integer id);

    /**
     * Soumettre la modification
     */
    void updateTypeSubmit(TypeInfo info);

    /**
     * Supprimer les types en fonction des ids
     */
    void deleteTypeByIds(List<String> id);

}

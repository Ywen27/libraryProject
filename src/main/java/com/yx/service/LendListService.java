package com.yx.service;

import com.github.pagehelper.PageInfo;
import com.yx.po.LendList;

import java.util.List;

public interface LendListService {

    //Requête de pagination
    PageInfo<LendList> queryLendListAll(LendList lendList, int page, int limit);

    //Ajouter un emprunt
    void addLendListSubmit(LendList lendList);


    /**
     * Supression
     */
    void deleteLendListById(List<String> ids, List<String> bookIds);

    /**
     * Retourner le livre
     */
    void updateLendListSubmit(List<String> ids, List<String> bookIds);

    /**
     * Retour de livre anormal
     */
    void backBook(LendList lendList);

    /**
     * Requête de chronologie
     */
    List<LendList> queryLookBookList(Integer rid, Integer bid);
}

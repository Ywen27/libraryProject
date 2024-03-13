package com.yx.service;

import com.github.pagehelper.PageInfo;
import com.yx.po.ReaderInfo;

import java.util.List;

public interface ReaderInfoService {

    /**
     * Rechercher tous les lecteurs
     */
    PageInfo<ReaderInfo> queryAllReaderInfo(ReaderInfo readerInfo,Integer pageNum,Integer limit);

    /**
     * Ajouter un lecteur
     */
    void addReaderInfoSubmit(ReaderInfo readerInfo);

    /**
     * Requête (requête avant modification)
     */
    ReaderInfo queryReaderInfoById(Integer id);

    /**
     * Soumettre la modification
     */
    void updateReaderInfoSubmit(ReaderInfo readerInfo);

    /**
     * Suppression
     */
    void deleteReaderInfoByIds(List<String> ids);

    /**
     *  Rechercher les informations d'utilisateur à l'aide d'username et du mot de passe
     */
    ReaderInfo queryUserInfoByNameAndPassword(String username,String password);
}

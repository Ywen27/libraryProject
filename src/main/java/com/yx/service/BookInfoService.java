package com.yx.service;

import com.github.pagehelper.PageInfo;
import com.yx.po.BookInfo;

import java.util.List;

public interface BookInfoService {

    /**
     * Rechercher tous les livres
     */
    PageInfo<BookInfo> queryBookInfoAll(BookInfo bookInfo,Integer pageNum,Integer limit);

    /**
     * Ajouter le livre
     */
    void addBookSubmit(BookInfo bookInfo);

    /**
     * Modifier les informations du livre de requête en fonction de id
     */
    BookInfo queryBookInfoById(Integer id);

    /**
     * Soumettre la modification
     */
    void updateBookSubmit(BookInfo info);

    /**
     * Supprimer les livres en fonction des ids
     */
    void deleteBookByIds(List<String> ids);

    /**
     * Obtenez le nombre de livres par type
     */
    List<BookInfo> getBookCountByType();
}

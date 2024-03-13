package com.yx.service;

import com.github.pagehelper.PageInfo;
import com.yx.po.Notice;

import java.util.List;

public interface NoticeService {

    /**
     * Rechercher toutes les annonces
     */
    PageInfo<Notice> queryAllNotice(Notice notice,Integer pageNum,Integer limit);

    /**
     * Ajouter une annonce
     */
    void addNotice(Notice notice);

    /**
     * Vérifier les détails de l'annonce (les annonces définies ici ne peuvent pas être modifiées,
     * sinon tout le monde la verra différemment. Si on souhaite la modifier, on derait supprimer
     * l'original et la republier)
     */
    Notice queryNoticeById(Integer id);

    /**
     * Suppression
     * @param ids
     */
    void deleteNoticeByIds(List<String> ids);
}

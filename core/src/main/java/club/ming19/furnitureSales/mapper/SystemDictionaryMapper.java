package club.ming19.furnitureSales.mapper;

import club.ming19.furnitureSales.domain.SystemDictionary;
import club.ming19.furnitureSales.domain.SystemDictionaryItem;

import java.util.List;

public interface SystemDictionaryMapper {
    List<SystemDictionary> listSystemDictionary();

    List<SystemDictionaryItem> querySystemDictionaryItemsByPid(Long id);

    SystemDictionaryItem getSystemDictionaryItemById(Long id);

    int saveSystemDictionaryItem(SystemDictionaryItem item);

    int updateSystemDictionaryItemById(SystemDictionaryItem item);

    int deleteSystemDictionaryItemById(Long id);

    List<SystemDictionaryItem> querySystemDictionaryItemsByPsn(String sn);

    List<SystemDictionary> querySystemDictionariesByPsn(String sn);

    SystemDictionary getBysn(String sn);
}

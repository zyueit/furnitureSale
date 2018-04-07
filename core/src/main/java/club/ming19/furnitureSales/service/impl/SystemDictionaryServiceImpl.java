package club.ming19.furnitureSales.service.impl;

import club.ming19.furnitureSales.domain.SystemDictionary;
import club.ming19.furnitureSales.domain.SystemDictionaryItem;
import club.ming19.furnitureSales.mapper.SystemDictionaryMapper;
import club.ming19.furnitureSales.service.ISystemDictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SystemDictionaryServiceImpl implements ISystemDictionaryService {
    @Autowired
    private SystemDictionaryMapper systemDictionaryMapper;

    @Override
    public List<SystemDictionary> listSystemDictionary() {
        return systemDictionaryMapper.listSystemDictionary();
    }

    @Override
    public List<SystemDictionaryItem> querySystemDictionaryItemsByPid(Long id) {
        return systemDictionaryMapper.querySystemDictionaryItemsByPid(id);
    }

    @Override
    public SystemDictionaryItem getSystemDictionaryItemById(Long id) {
        return systemDictionaryMapper.getSystemDictionaryItemById(id);
    }

    @Override
    public int saveSystemDictionaryItem(SystemDictionaryItem item) {
        return systemDictionaryMapper.saveSystemDictionaryItem(item);
    }

    @Override
    public int updateSystemDictionaryItemById(SystemDictionaryItem item) {
        return systemDictionaryMapper.updateSystemDictionaryItemById(item);
    }

    @Override
    public int deleteSystemDictionaryItemById(Long id) {
        return systemDictionaryMapper.deleteSystemDictionaryItemById(id);
    }

    @Override
    public List<SystemDictionaryItem> querySystemDictionaryItemsByPsn(String sn) {
        return systemDictionaryMapper.querySystemDictionaryItemsByPsn(sn);
    }

    @Override
    public List<SystemDictionary> querySystemDictionariesByPsn(String sn) {
        return systemDictionaryMapper.querySystemDictionariesByPsn(sn);
    }

    @Override
    public List<SystemDictionaryItem> queryItemsByPidForGoods(Long id) {
        return systemDictionaryMapper.querySystemDictionaryItemsByPid(id);
    }

    @Override
    public SystemDictionary getBysn(String sn) {
        return systemDictionaryMapper.getBysn(sn);
    }
}

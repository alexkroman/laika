package org.projectlaika.web.util;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.collections.FactoryUtils;
import org.apache.commons.collections.list.LazyList;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;

/**
 * When using the data binding provided by Spring and Spring MVC, dealing with beans that have
 * collections as properties can get funky. Spring will try to perform indexed accesses on the 
 * collection which is an issue if you are creating new objects and the collection is empty.
 *
 * To solve this issue, the LazyList from the Jakarta Commons Collections is used. A LazyList can
 * decorate a list so that when an index that is out of range is accessed, it will create classes
 * to fill the void.
 *
 * An issue that we run into is that LazyList has no default constructor. This causes JPA problems
 * if you try to persist a bean that has a collection that is a LazyList.
 *
 * This class will make it easy to swap properties to and from a LazyList.
 *
 * @author Andy Gregorowicz
 */
public class LazyListHelper
{
    /**
     * Decorates the specified property with a LazyList
     * 
     * @param bean
     * @param property
     * @param listType
     */
    @SuppressWarnings("unchecked")
    public static void decorateList(Object bean, String property, Class listType)
    {
        BeanWrapper wrapper = new BeanWrapperImpl(bean);
        List list = (List) wrapper.getPropertyValue(property);
        if (list == null)
        {
            list = new LinkedList();
        }
        List decorated = LazyList.decorate(list, FactoryUtils.instantiateFactory(listType));
        wrapper.setPropertyValue(property, decorated);
    }
    
    /**
     * Replaces the List in the specified list with a plain old ArrayList. This is intended to
     * remove a LazyList from an object.
     * 
     * @param bean
     * @param property
     */
    @SuppressWarnings("unchecked")
    public static void removeDecoration(Object bean, String property)
    {
        BeanWrapper wrapper = new BeanWrapperImpl(bean);
        List list = (List) wrapper.getPropertyValue(property);
        List undecorated = new ArrayList(list);
        wrapper.setPropertyValue(property, undecorated);
    }
}

package org.projectlaika.web.util;

import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;

import java.util.ArrayList;

import org.apache.commons.collections.list.LazyList;
import org.junit.Test;
import org.projectlaika.models.DocumentLocation;
import org.projectlaika.models.Namespace;

public class LazyListHelperTest
{

    @Test
    public void testDecorateList()
    {
        DocumentLocation dl = new DocumentLocation();
        dl.addNamespace(new Namespace("cda", "http://cda.org"));
        LazyListHelper.decorateList(dl, "namespaces", Namespace.class);
        assertThat(dl.getNamespaces(), is(LazyList.class));
        assertThat(dl.getNamespaces().get(0).getPrefix(), is("cda"));
        assertThat(dl.getNamespaces().get(1).getPrefix(), is(nullValue()));
    }

    @Test
    public void testRemoveDecoration()
    {
        DocumentLocation dl = new DocumentLocation();
        dl.addNamespace(new Namespace("cda", "http://cda.org"));
        LazyListHelper.decorateList(dl, "namespaces", Namespace.class);
        assertThat(dl.getNamespaces(), is(LazyList.class));
        LazyListHelper.removeDecoration(dl, "namespaces");
        assertThat(dl.getNamespaces(), is(ArrayList.class));
        assertThat(dl.getNamespaces().get(0).getPrefix(), is("cda"));
    }

}

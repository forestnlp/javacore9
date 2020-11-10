package org.javacore.collections.view;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class Main {

    public static void main(String[] args) {

        List<Integer> list = new ArrayList<>();
        list.add(1);
        list.add(2);
        list.add(3);
        list.add(4);

        Collection<Integer> umlist = Collections.unmodifiableCollection(list);
        System.out.println(umlist);
        umlist.add(5);
        System.out.println(umlist);

    }
}

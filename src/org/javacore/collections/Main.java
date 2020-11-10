package org.javacore.collections;

import java.util.Comparator;
import java.util.HashSet;
import java.util.Set;
import java.util.TreeSet;

public class Main {

    public static void main(String[] args) {

        Employee e1 = new Employee(1,300.00);
        Employee e2 = new Employee(1,350.00);

        System.out.println(e1.equals(e2));

        System.out.println(e1.compareTo(e2));

        //这个时候出问题了
        Set<Employee> set = new HashSet<>();
        set.add(e1);
        set.add(e2);
        System.out.println(set);

        //这个时候还好
        set = new TreeSet<>(new Comparator<Employee>() {
            @Override
            public int compare(Employee o1, Employee o2) {
                return o1.getId()-o2.getId();
            }
        });
        set.add(e1);
        set.add(e2);
        System.out.println(set);
    }

}

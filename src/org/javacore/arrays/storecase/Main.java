package org.javacore.arrays.storecase;

public class Main {

    public static void main(String[] args) {

        // write your code here
        Employee [] employees = new Employee[3];

        Person [] persons = employees;

        persons[0] = new Manager();

        for(Person p:persons) {
            System.out.println(p);
        }
    }
}

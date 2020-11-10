package org.javacore.enums;

public class Main {
    public static void main(String[] args) {
        Season s1 = Season.Spring;
        Season s2 = Season.Summer;

        System.out.println(s1.compareTo(s2));
    }
}

package org.javacore.bitshift;

public class Main {
    public static void main(String[] args) {
        int a = 16;
        System.out.println(a>>1);
        System.out.println(a>>>1);

        System.out.println(Integer.toBinaryString(15));

        int b = -15;
        System.out.println(Integer.toBinaryString(b));
        System.out.println(b>>1);
        System.out.println(Integer.toBinaryString(b>>1));
        System.out.println(b>>>1);
        System.out.println(Integer.toBinaryString(b>>>1));


        System.out.println(Integer.toBinaryString(-18>>1));
        System.out.println(-18>>>1);
        System.out.println(-101>>1);

        System.out.println(-100<<1);
    }
}

package org.javacore.exception.checked;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

public class Main {
    public static void main(String[] args) {
        //InputStream is = new FileInputStream(new File("Main"));
        try {
            m();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void m() throws MyException,RuntimeException, FileNotFoundException {
        int i = 10;
        System.out.println(1);
        InputStream is = new FileInputStream(new File("a"));
       // if(i==10) throw  new MyException();
    }
}

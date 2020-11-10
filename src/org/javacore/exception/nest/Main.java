package org.javacore.exception.nest;

public class Main {
    public static void main(String[] args) {
        int k  = 0;
        try{
            if(k==0) throw new MyException();
            int i=10/k;
        }
        catch (MyException e) {
            System.out.println("k==0");
            System.out.println("myexception1");
        }
        catch (MyException2 e) {
            System.out.println("myexception2");
        }
        finally {
            System.out.println("done");
        }
    }
}

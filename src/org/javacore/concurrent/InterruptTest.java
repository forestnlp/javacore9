package org.javacore.concurrent;

public class InterruptTest {

    public static void main(String[] args) {
        Object lock = new Object();

        Thread t1 = new Thread(()->{
            synchronized (lock){
                System.out.println(Thread.currentThread().getName()+" get lock now loop");
                while (1==1){
                    try {
                       // Thread.sleep(1000);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        });

        t1.start();
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        t1.interrupt();

    }
}

package org.javacore.passvalue;

public class ReferenceChangedMain {

    static class Cat {

        double weight;

        public Cat(double weight) {
            this.weight = weight;
        }

        public void setWeight(double weight) {
            this.weight = weight;
        }

        public double getWeight() {
            return weight;
        }

        @Override
        public String toString() {
            return "Cat{" +
                    "weight=" + weight +
                    '}';
        }
    }

    public void fead(Cat cat) {
        System.out.println("fead cat "+cat);
        cat.setWeight(cat.getWeight()*1.1);
    }


    public static void main(String[] args) {
        ReferenceChangedMain main = new ReferenceChangedMain();
        Cat mimi = new Cat(3.9);
        main.fead(mimi);
        System.out.println(mimi);
    }

}

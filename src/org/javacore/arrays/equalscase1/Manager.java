package org.javacore.arrays.equalscase1;


import java.util.Objects;

public class Manager extends Person {
    private int managerid;

    public Manager(int managerid) {
        this.managerid = managerid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Manager manager = (Manager) o;
        return managerid == manager.managerid;
    }

    @Override
    public int hashCode() {
        return Objects.hash(managerid);
    }
}

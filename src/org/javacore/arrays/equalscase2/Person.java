package org.javacore.arrays.equalscase2;

import java.util.Objects;

public class Person {
    private int personid;

    public Person(int personid) {
        this.personid = personid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Person person = (Person) o;
        return personid == person.personid;
    }

    @Override
    public int hashCode() {
        return Objects.hash(personid);
    }
}

package model.mappers;

import jakarta.persistence.EntityManager;

public class Mappers {
    EntityManager em;

    public Mappers(EntityManager em) {
        this.em = em;
    }
}

package businessLogic;

import jakarta.persistence.EntityManager;

public class Services {
    EntityManager con;
    public Services(EntityManager con) {
        this.con = con;
    }

    //FUNCIONALIDADES GO HERE
}

package model.mappers;

public interface Mapper<T, TId> {
    TId create(T e) throws Exception;
    T read(TId id) throws Exception;
    void update(T e) throws Exception;
    void delete(T e) throws Exception;
}

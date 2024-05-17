namespace DataAccessLayer.Repositories;

public interface IBaseRepository<T> where T : class
{
    void Create(T entity);
    void Update(T entity);
    void Delete(int id);
    IEnumerable<T> ReadAll(); 

}

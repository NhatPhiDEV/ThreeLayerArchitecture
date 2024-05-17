using System.Data.SqlClient;

namespace DataAccessLayer;

public interface IUnitOfWork : IDisposable
{
    void BeginTransaction();
    void Commit();
    void Rollback();
    SqlTransaction Transaction { get; }
}

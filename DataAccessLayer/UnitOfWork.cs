using System.Data.SqlClient;

namespace DataAccessLayer;

public class UnitOfWork : IUnitOfWork
{
    private readonly string _connectionString = "Server=MAY24\\SQLEXPRESS;Database=SchoolDB;Trusted_Connection=True;TrustServerCertificate=True;MultipleActiveResultSets=true;";
    private SqlTransaction _transaction;

    public SqlTransaction Transaction
    {
        get { return _transaction; }
    }

    public void BeginTransaction()
    {
        var connection = new SqlConnection(_connectionString);
        connection.Open();
        _transaction = connection.BeginTransaction();
    }

    public void Commit()
    {
        _transaction.Commit();
        _transaction.Dispose();
    }

    public void Rollback()
    {
        _transaction.Rollback();
        _transaction.Dispose();
    }

    public void Dispose()
    {
        if (_transaction != null)
        {
            _transaction.Dispose();
        }
    }
}

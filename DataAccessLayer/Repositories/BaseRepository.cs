using System.Data;
using System.Data.SqlClient;
using static DataAccessLayer.Common.Enums;

namespace DataAccessLayer.Repositories;

public abstract class BaseRepository<T> : IBaseRepository<T> where T : class
{
    protected readonly IUnitOfWork _unitOfWork;
    protected abstract string TableName { get; }

    public BaseRepository(IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork;
    }

    #region Executes a SQL command
    /// <summary>
    /// Executes a SQL command that does not return a result set (e.g., INSERT, UPDATE, DELETE).
    /// </summary>
    /// <param name="sql">The SQL command text to execute.</param>
    /// <param name="parameters">An optional array of SQL parameters to pass to the command.</param>
    /// <returns>The number of rows affected by the command execution.</returns>
    /// <exception cref="InvalidOperationException">Thrown if a transaction has not been started in the Unit of Work.</exception>
    protected int ExecuteNonQuery(string sql, SqlParameter[]? parameters = null)
    {
        if (_unitOfWork.Transaction == null)
        {
            throw new InvalidOperationException("Transaction has not been started.");
        }

        int affectedRows;

        using (var command = new SqlCommand(sql, _unitOfWork.Transaction.Connection, _unitOfWork.Transaction))
        {
            if (parameters != null)
            {
                command.Parameters.AddRange(parameters);
            }

            affectedRows = command.ExecuteNonQuery();
        }

        return affectedRows;
    }

    /// <summary>
    /// Executes a SQL command or stored procedure and returns the result set as a DataTable.
    /// </summary>
    /// <param name="commandText">The text of the command or stored procedure to execute.</param>
    /// <param name="commandType">The type of the command (Text, StoredProcedure, etc.).</param>
    /// <param name="parameters">An optional array of SQL parameters for the command.</param>
    /// <returns>A DataTable containing the results of the query.</returns>
    /// <exception cref="InvalidOperationException">Thrown if a transaction has not been started in the Unit of Work.</exception>
    protected DataTable ExecuteDataTable(string commandText, CommandType commandType, SqlParameter[]? parameters = null)
    {
        if (_unitOfWork.Transaction == null)
        {
            throw new InvalidOperationException("Transaction has not been started.");
        }

        var dataTable = new DataTable();

        using (var command = new SqlCommand(commandText, _unitOfWork.Transaction.Connection, _unitOfWork.Transaction))
        {
            command.CommandType = commandType; // Đặt CommandType

            if (parameters != null)
            {
                command.Parameters.AddRange(parameters);
            }

            using var adapter = new SqlDataAdapter(command);
            adapter.Fill(dataTable);
        }

        return dataTable;
    }

    /// <summary>
    /// Executes a SQL query within the context of an active transaction and returns the results as a collection of entities.
    /// </summary>
    /// <param name="sql">The SQL query text to execute.</param>
    /// <param name="parameters">Optional: An array of SqlParameter objects containing values for parameterized queries.</param>
    /// <returns>An IEnumerable collection containing the mapped entities from the query results.</returns>
    /// <exception cref="InvalidOperationException">Thrown if no active transaction is found in the Unit of Work.</exception>
    protected IEnumerable<T> ExecuteQuery(string sql, SqlParameter[]? parameters = null)
    {
        // Kiểm tra transaction
        if (_unitOfWork.Transaction == null)
        {
            throw new InvalidOperationException("Transaction has not been started.");
        }

        var list = new List<T>();

        using (var command = new SqlCommand(sql, _unitOfWork.Transaction.Connection, _unitOfWork.Transaction))
        {
            if (parameters != null)
            {
                command.Parameters.AddRange(parameters);
            }

            using var reader = command.ExecuteReader();
            while (reader.Read())
            {
                var entity = Activator.CreateInstance<T>(); // Tạo một đối tượng mới của kiểu T
                foreach (var prop in typeof(T).GetProperties())
                {
                    if (!reader.IsDBNull(reader.GetOrdinal(prop.Name))) // Kiểm tra null
                    {
                        prop.SetValue(entity, reader[prop.Name]); // Gán giá trị từ reader vào thuộc tính
                    }
                }
                list.Add(entity);
            }
        }

        return list;
    }

    #endregion

    #region CRUD 
    public void Create(T entity)
    {
        var sql = $"INSERT INTO {TableName} ({GetColumnNames()}) VALUES ({GetParameterNames()})";
        ExecuteNonQuery(sql, GetSqlParameters(entity, EQueryType.Create));
    }

    public void Delete(int id)
    {
        var sql = $"DELETE FROM {TableName} WHERE Id = @Id";
        ExecuteNonQuery(sql, [new SqlParameter("@Id", id)]);
    }

    public void Update(T entity)
    {
        var sql = $"UPDATE {TableName} SET {GetUpdateSet()} WHERE Id = @Id";
        var parameters = GetSqlParameters(entity, EQueryType.Update);
        ExecuteNonQuery(sql, parameters);
    }

    public IEnumerable<T> ReadAll()
    {
        var sql = $"SELECT * FROM {TableName}";
        return ExecuteQuery(sql);
    }
    #endregion

    #region Private Helper Methods
    private string GetColumnNames()
    {
        return string.Join(", ", typeof(T).GetProperties()
            .Where(p => p.Name != "Id") // Loại bỏ trường Id
            .Select(p => p.Name));
    }

    private string GetParameterNames()
    {
        return string.Join(", ", typeof(T).GetProperties()
            .Where(p => p.Name != "Id") // Loại bỏ trường Id
            .Select(p => "@" + p.Name));
    }

    private string GetUpdateSet()
    {
        return string.Join(", ", typeof(T).GetProperties().Select(p => $"{p.Name} = @{p.Name}"));
    }

    private SqlParameter[] GetSqlParameters(T entity, EQueryType type)
    {
        return typeof(T).GetProperties()
            .Where(p => (type != EQueryType.Update && p.Name != "Id") || type == EQueryType.Create) // Loại bỏ trường Id
            .Select(p => new SqlParameter("@" + p.Name, GetPropertyValue(entity, p.Name) ?? DBNull.Value))
            .ToArray();
    }

    private object? GetPropertyValue(T entity, string propertyName)
    {
        return typeof(T).GetProperty(propertyName)?.GetValue(entity, null);
    }
    #endregion

}

using Entities;
using System.Data;

namespace DataAccessLayer.Repositories;

public class CourseRepository : BaseRepository<Course>
{
    public CourseRepository(IUnitOfWork unitOfWork) : base(unitOfWork)
    {

    }

    protected override string TableName => "Courses";

}


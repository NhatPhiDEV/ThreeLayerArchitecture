using DataAccessLayer;
using DataAccessLayer.Repositories;
using Entities;

namespace ThreeLayerArchitecture.Tests;

[TestFixture]
public class CourseRepositoryTests
{
    private IUnitOfWork _unitOfWork;

    [SetUp]
    public void Setup()
    {
        _unitOfWork = new UnitOfWork();
    }

    [TearDown]
    public void TearDown()
    {
        _unitOfWork.Dispose();
    }

    [Test]
    public void AddCourse_ShouldAddCourseToDatabase()
    {

        _unitOfWork.BeginTransaction();
        var newCourse = new Course
        {
            Name = "Toán cao cấp 5",
            Description = "Học về các khái niệm toán học nâng cao"
        };
        var _courseRepository = new CourseRepository(_unitOfWork);
        try
        {
            _courseRepository.Create(newCourse);
            var allCourses = _courseRepository.ReadAll();
            _unitOfWork.Commit();
            // Kiem tra xem phan tu vua tao co chua
            Assert.That(allCourses.Any(item => item.Name.Equals(newCourse.Name)), Is.True);
        }
        catch (Exception)
        {
            _unitOfWork.Rollback();
            throw;
        }
    }
}

using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Entities;

public class Class
{
    [Key]
    public int Id { get; set; }

    [Required]
    [StringLength(100)]
    public string Name { get; set; } = string.Empty;

    [ForeignKey("Department")]
    public int DepartmentId { get; set; }

    // Navigation properties
    public virtual Department Department { get; set; } 
    public virtual ICollection<Student> Students { get; set; }
}
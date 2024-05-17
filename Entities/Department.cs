using System.ComponentModel.DataAnnotations;

namespace Entities;

public class Department
{
    [Key]
    public int Id { get; set; }

    [Required]
    [StringLength(100)]
    public string Name { get; set; } = string.Empty;

    public string Description { get; set; } = string.Empty;

    // Navigation property (relationship with Classes)
    public virtual ICollection<Class> Classes { get; set; }
}

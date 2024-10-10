using System;
using System.ComponentModel.DataAnnotations;

namespace CapaEntidad
{
    public class Empleado
    {
        public int EmpleadoID { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Nombre { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Apellido { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Telefono { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Direccion { get; set; }
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime FechaContratacion { get; set; }
        public string NomCargo { get; set; }
        public int CargoID { get; set; }


    }
}

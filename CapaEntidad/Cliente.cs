using System;
using System.ComponentModel.DataAnnotations;

namespace CapaEntidad
{
    public class Cliente
    {
        public int ClienteID { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Nombre { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Apellido { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string DNI { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Telefono { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Direccion { get; set; }
        public DateTime? FechaRegistro { get; set; }
    }
}

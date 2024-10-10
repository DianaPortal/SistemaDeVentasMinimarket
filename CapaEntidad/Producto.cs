using System;
using System.ComponentModel.DataAnnotations;

namespace CapaEntidad
{
    public class Producto
    {
        public int ProductoID { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public decimal Precio { get; set; }
        [Required(ErrorMessage = "Campo requerido")]
        public int Stock { get; set; }

        public int CategoriaID { get; set; }
        public string Categoria { get; set; }

        public DateTime FechaAgregado { get; set; }
    }
}

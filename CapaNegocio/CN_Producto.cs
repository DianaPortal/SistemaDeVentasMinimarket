using System.Collections.Generic;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Producto
    {
        private readonly CD_Producto objCapaDatos = new CD_Producto();

        public List<Producto> Listar()
        {
            return objCapaDatos.Listar();
        }

        public string RegistrarProducto(Producto producto)
        {
            return objCapaDatos.RegistrarProducto(producto);
        }

        public string EditarProducto(Producto producto)
        {
            return objCapaDatos.EditarProducto(producto);
        }

        public string EliminarProducto(int id)
        {
            return objCapaDatos.EliminarProducto(id);
        }
    }
}

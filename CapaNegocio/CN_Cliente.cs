using System.Collections.Generic;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Clientes
    {
        private readonly Clientes _CN_Cliente = new Clientes();

        public List<Cliente> Listar()
        {
            return _CN_Cliente.Listar();
        }

        public string Registrar(Cliente cliente)
        {
            return _CN_Cliente.Registrar(cliente);
        }

        public string Actualizar(Cliente cliente)
        {
            return _CN_Cliente.Actualizar(cliente);
        }

        public string Eliminar(int clienteID)
        {
            return _CN_Cliente.Eliminar(clienteID);
        }
    }
}

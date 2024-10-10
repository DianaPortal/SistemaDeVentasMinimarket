using System.Collections.Generic;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Cargo
    {
        private CD_Cargo objCapaDatos = new CD_Cargo();

        public List<Cargo> Listar()
        {
            return objCapaDatos.Listar();
        }
    }
}

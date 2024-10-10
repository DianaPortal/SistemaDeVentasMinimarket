using System.Collections.Generic;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Reporte
    {
        private CD_Reporte objCapaDato = new CD_Reporte();

        public List<Reporte> Ventas(string fechainicio, string fechafin, string idventa)
        {
            return objCapaDato.Ventas(fechainicio, fechafin, idventa);
        }

        public DashBoard VerDashBoard()
        {
            return objCapaDato.VerDashBoard();
        }

    }
}

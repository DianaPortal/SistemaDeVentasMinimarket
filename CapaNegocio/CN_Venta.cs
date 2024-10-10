using System.Collections.Generic;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Venta
    {
        private readonly CD_Venta _cdVenta = new CD_Venta();

        public List<FormaPago> ListarFormasPago()
        {
            return _cdVenta.ListarFormasPago();
        }

        public bool RegistrarVenta(Venta venta, out string mensaje)
        {
            return _cdVenta.RegistrarVenta(venta, out mensaje);
        }

        public string ObtenerYActualizarNumeroSerie(string tipoComprobante)
        {
            using (var connection = new System.Data.SqlClient.SqlConnection(Conexion.cn))
            {
                connection.Open();
                using (var transaction = connection.BeginTransaction())
                {
                    return _cdVenta.ObtenerYActualizarNumeroSerie(connection, transaction, tipoComprobante);
                }
            }
        }
    }
}

using System;
using System.Data.SqlClient;
using CapaEntidad;

namespace CapaDatos
{
    public class CD_ComprobantePago
    {
        public ComprobantePago ObtenerUltimoNumeroComprobante(string tipoComprobante)
        {
            ComprobantePago comprobante = null;

            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var query = "SELECT TipoComprobante, UltimoNumero FROM NumerosSerie WHERE TipoComprobante = @TipoComprobante";
                    SqlCommand cmd = new SqlCommand(query, cone);
                    cmd.Parameters.AddWithValue("@TipoComprobante", tipoComprobante);

                    cone.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            comprobante = new ComprobantePago
                            {
                                TipoComprobante = dr["TipoComprobante"].ToString(),
                                UltimoNumero = Convert.ToInt32(dr["UltimoNumero"])
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener el último número de comprobante", ex);
            }

            return comprobante;
        }

        public void ActualizarUltimoNumeroComprobante(string tipoComprobante)
        {
            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var query = "UPDATE NumerosSerie SET UltimoNumero = UltimoNumero + 1 WHERE TipoComprobante = @TipoComprobante";
                    SqlCommand cmd = new SqlCommand(query, cone);
                    cmd.Parameters.AddWithValue("@TipoComprobante", tipoComprobante);

                    cone.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar el último número de comprobante", ex);
            }
        }
    }
}

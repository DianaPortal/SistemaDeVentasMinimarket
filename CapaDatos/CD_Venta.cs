using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using CapaEntidad;

namespace CapaDatos
{
    public class CD_Venta
    {
        public List<FormaPago> ListarFormasPago()
        {
            List<FormaPago> lista = new List<FormaPago>();

            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var query = "SELECT FormaPagoID, Descripcion FROM FormaPago";
                    SqlCommand cmd = new SqlCommand(query, cone);

                    cone.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(new FormaPago()
                            {
                                FormaPagoID = Convert.ToInt32(dr["FormaPagoID"]),
                                Descripcion = dr["Descripcion"].ToString()
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar formas de pago", ex);
            }

            return lista;
        }

        public bool RegistrarVenta(Venta venta, out string mensaje)
        {
            bool resultado = false;
            mensaje = string.Empty;

            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    cone.Open();
                    using (SqlTransaction transaction = cone.BeginTransaction())
                    {
                        string numeroSerie = ObtenerYActualizarNumeroSerie(cone, transaction, venta.TipoComprobante);

                        var spVenta = "SP_REGISTRAR_VENTA";
                        SqlCommand cmdVenta = new SqlCommand(spVenta, cone, transaction);
                        cmdVenta.CommandType = CommandType.StoredProcedure;

                        cmdVenta.Parameters.AddWithValue("@FechaVenta", DateTime.Now);
                        cmdVenta.Parameters.AddWithValue("@MontoTotal", venta.MontoTotal);
                        cmdVenta.Parameters.AddWithValue("@FormaPagoID", venta.FormaPagoID);
                        cmdVenta.Parameters.AddWithValue("@NumeroSerie", numeroSerie);
                        cmdVenta.Parameters.AddWithValue("@DNI", venta.DNI);
                        cmdVenta.Parameters.AddWithValue("@NombreCompleto", venta.NombreCompleto);

                        // Parámetro de salida para obtener el ID de la venta
                        SqlParameter ventaIDParam = new SqlParameter("@VentaID", SqlDbType.Int) { Direction = ParameterDirection.Output };
                        cmdVenta.Parameters.Add(ventaIDParam);

                        cmdVenta.ExecuteNonQuery();
                        venta.VentaID = (int)ventaIDParam.Value;

                        for (int i = venta.Detalles.Count - 1; i >= 0; i--)
                        {
                            DetalleVenta detalle = venta.Detalles[i];
                            if (detalle == null)
                            {
                                throw new Exception("Se encontró un detalle de venta nulo.");
                            }

                            var spDetalle = "SP_REGISTRAR_DETALLE_VENTA";
                            SqlCommand cmdDetalle = new SqlCommand(spDetalle, cone, transaction);
                            cmdDetalle.CommandType = CommandType.StoredProcedure;

                            cmdDetalle.Parameters.AddWithValue("@VentaID", venta.VentaID);
                            cmdDetalle.Parameters.AddWithValue("@ProductoID", detalle.ProductoID);
                            cmdDetalle.Parameters.AddWithValue("@Cantidad", detalle.Cantidad);
                            cmdDetalle.Parameters.AddWithValue("@PrecioUnitario", detalle.PrecioUnitario);
                            cmdDetalle.Parameters.AddWithValue("@SubTotal", detalle.SubTotal);

                            cmdDetalle.ExecuteNonQuery();
                        }

                        // Commit the transaction if all commands are successful
                        transaction.Commit();
                        resultado = true;
                        mensaje = $"Venta registrada correctamente con número de serie {numeroSerie}.";
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine($"Error: {ex.Message}");
                mensaje = $"Error al registrar venta: {ex.Message}";
            }

            return resultado;
        }


        public string ObtenerYActualizarNumeroSerie(SqlConnection cone, SqlTransaction transaction, string tipoComprobante)
        {
            string prefix = tipoComprobante == "Boleta" ? "B" : "F";
            int ultimoNumero;

            var selectQuery = "SELECT UltimoNumero FROM NumerosSerie WHERE TipoComprobante = @TipoComprobante";
            var updateQuery = "UPDATE NumerosSerie SET UltimoNumero = UltimoNumero + 1 WHERE TipoComprobante = @TipoComprobante";

            using (SqlCommand cmd = new SqlCommand(selectQuery, cone, transaction))
            {
                cmd.Parameters.AddWithValue("@TipoComprobante", tipoComprobante);
                ultimoNumero = (int)cmd.ExecuteScalar();
            }

            using (SqlCommand cmd = new SqlCommand(updateQuery, cone, transaction))
            {
                cmd.Parameters.AddWithValue("@TipoComprobante", tipoComprobante);
                cmd.ExecuteNonQuery();
            }

            return $"{prefix}{(ultimoNumero + 1).ToString("D4")}";
        }
    }
}

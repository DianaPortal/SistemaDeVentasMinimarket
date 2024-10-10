using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using CapaEntidad;

namespace CapaDatos
{
    public class CD_Producto
    {
        public List<Producto> Listar()
        {
            List<Producto> lista = new List<Producto>();

            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var sp = "SP_LISTAR_PRODUCTO";
                    SqlCommand cmd = new SqlCommand(sp, cone);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cone.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            lista.Add(new Producto()
                            {
                                ProductoID = Convert.ToInt32(dr["ProductoID"]),
                                Nombre = Convert.ToString(dr["Nombre"]),
                                Descripcion = Convert.ToString(dr["Descripcion"]),
                                Precio = Convert.ToDecimal(dr["Precio"]),
                                Stock = Convert.ToInt32(dr["Stock"]),
                                CategoriaID = Convert.ToInt32(dr["CategoriaID"]),
                                FechaAgregado = Convert.ToDateTime(dr["FechaAgregado"])
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar productos: " + ex.Message, ex);
            }

            return lista;
        }

        public string RegistrarProducto(Producto producto)
        {
            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var sp = "SP_REGISTRAR_PRODUCTO";
                    SqlCommand cmd = new SqlCommand(sp, cone);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Nombre", producto.Nombre);
                    cmd.Parameters.AddWithValue("@Descripcion", producto.Descripcion);
                    cmd.Parameters.AddWithValue("@Precio", producto.Precio);
                    cmd.Parameters.AddWithValue("@Stock", producto.Stock);
                    cmd.Parameters.AddWithValue("@CategoriaID", producto.CategoriaID);
                    cmd.Parameters.AddWithValue("@FechaAgregado", DateTime.Now);

                    cone.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0 ? "Producto registrado con éxito" : "No se pudo registrar el producto";
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al registrar producto: " + ex.Message, ex);
            }
        }

        public string EditarProducto(Producto producto)
        {
            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var sp = "SP_ACTUALIZAR_PRODUCTO";
                    SqlCommand cmd = new SqlCommand(sp, cone);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ProductoID", producto.ProductoID);
                    cmd.Parameters.AddWithValue("@Nombre", producto.Nombre);
                    cmd.Parameters.AddWithValue("@Descripcion", producto.Descripcion);
                    cmd.Parameters.AddWithValue("@Precio", producto.Precio);
                    cmd.Parameters.AddWithValue("@Stock", producto.Stock);
                    cmd.Parameters.AddWithValue("@CategoriaID", producto.CategoriaID);
                    cmd.Parameters.AddWithValue("@FechaAgregado", DateTime.Now);

                    cone.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0 ? "Producto actualizado con éxito" : "No se pudo actualizar el producto";
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar producto: " + ex.Message, ex);
            }
        }

        public string EliminarProducto(int id)
        {
            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var sp = "SP_ELIMINAR_PRODUCTO";
                    SqlCommand cmd = new SqlCommand(sp, cone);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ProductoID", id);

                    cone.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0 ? "Producto eliminado con éxito" : "No se pudo eliminar el producto";
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar producto: " + ex.Message, ex);
            }
        }
    }
}

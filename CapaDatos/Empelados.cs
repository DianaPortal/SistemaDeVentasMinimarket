using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using CapaEntidad;

namespace CapaDatos
{
    public class Empleados
    {
        public List<Empleado> Listar()
        {
            List<Empleado> lista = new List<Empleado>();

            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var sp = "usp_get_Empleados";
                    SqlCommand cmd = new SqlCommand(sp, cone);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cone.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {


                            lista.Add(new Empleado()
                            {
                                EmpleadoID = Convert.ToInt32(dr["EmpleadoID"]),
                                Nombre = dr["Nombre"].ToString(),
                                Apellido = dr["Apellido"].ToString(),
                                Email = dr["Email"].ToString(),
                                Telefono = dr["Telefono"].ToString(),
                                Direccion = dr["Direccion"].ToString(),
                                FechaContratacion = Convert.ToDateTime(dr["FechaContratacion"]),
                                CargoID = Convert.ToInt32(dr["CargoID"]),
                                NomCargo = dr["NomCargo"].ToString()
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar empleados: " + ex.Message, ex);
            }

            return lista;
        }

        public string Registrar(Empleado empleado)
        {
            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var sp = "usp_insert_Empleado";
                    SqlCommand cmd = new SqlCommand(sp, cone);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Nombre", empleado.Nombre);
                    cmd.Parameters.AddWithValue("@Apellido", empleado.Apellido);
                    cmd.Parameters.AddWithValue("@Email", empleado.Email);
                    cmd.Parameters.AddWithValue("@Telefono", empleado.Telefono);
                    cmd.Parameters.AddWithValue("@Direccion", empleado.Direccion);
                    cmd.Parameters.AddWithValue("@FechaContratacion", empleado.FechaContratacion);
                    cmd.Parameters.AddWithValue("@CargoID", empleado.CargoID);

                    cone.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0 ? "Empleado registrado con éxito" : "No se pudo registrar el empleado";
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al registrar Empleado: " + ex.Message, ex);
            }
        }

        public string Actualizar(Empleado empleado)
        {
            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var sp = "usp_update_Empleado";
                    SqlCommand cmd = new SqlCommand(sp, cone);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@EmpleadoID", empleado.EmpleadoID);
                    cmd.Parameters.AddWithValue("@Nombre", empleado.Nombre);
                    cmd.Parameters.AddWithValue("@Apellido", empleado.Apellido);
                    cmd.Parameters.AddWithValue("@Email", empleado.Email);
                    cmd.Parameters.AddWithValue("@Telefono", empleado.Telefono);
                    cmd.Parameters.AddWithValue("@Direccion", empleado.Direccion);
                    cmd.Parameters.AddWithValue("@FechaContratacion", empleado.FechaContratacion);
                    cmd.Parameters.AddWithValue("@CargoID", empleado.CargoID);

                    cone.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();
                    return rowsAffected > 0 ? "Empleado actualizado con éxito" : "No se pudo actualizar el empleado";
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al actualizar empleado: " + ex.Message, ex);
            }
        }

        public string Eliminar(int empleadoID)
        {
            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var sp = "usp_eliminar_logico_Empleado";
                    SqlCommand cmd = new SqlCommand(sp, cone);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@EmpleadoID", empleadoID);

                    cone.Open();
                    cmd.ExecuteNonQuery();
                }
                return "Empleado eliminado con éxito";
            }
            catch (Exception ex)
            {
                throw new Exception("Error al eliminar empleado: " + ex.Message, ex);
            }
        }
    }
}

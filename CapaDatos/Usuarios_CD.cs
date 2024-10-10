using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using CapaEntidad;

namespace CapaDatos
{
    public class Usuarios_CD
    {
        public Usuario Validar(string Username, string Contrasena)
        {
            Usuario usu = null;

            try
            {
                using (SqlConnection con = new SqlConnection(Conexion.cn))
                {
                    var sp = "LISTAR_LOGIN";
                    using (SqlCommand cmd = new SqlCommand(sp, con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@Usuario", Username);
                        cmd.Parameters.AddWithValue("@Contrasena", Contrasena);

                        Debug.WriteLine($"Parámetros: Usuario={Username}, Contrasena={Contrasena}");

                        con.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                Debug.WriteLine("Usuario encontrado");
                                usu = new Usuario()
                                {
                                    UserId = Convert.ToInt32(dr["UserId"]),
                                    Username = Convert.ToString(dr["Username"]),
                                    Email = Convert.ToString(dr["Email"]),
                                    RoleId = Convert.ToInt32(dr["RoleId"]),
                                    RoleName = Convert.ToString(dr["RoleName"])
                                };
                            }
                            else
                            {
                                Debug.WriteLine("Usuario no encontrado o contraseña incorrecta");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine("Error: " + ex.Message);
                throw new Exception("Error al validar usuario", ex);
            }

            return usu;
        }


        public string Registrar(Usuario usuario)
        {
            try
            {
                using (SqlConnection cone = new SqlConnection(Conexion.cn))
                {
                    var sp = "RegistrarUsuario";
                    SqlCommand cmd = new SqlCommand(sp, cone);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Username", usuario.Username);
                    cmd.Parameters.AddWithValue("@Contrasena", usuario.Contrasena);
                    cmd.Parameters.AddWithValue("@Email", usuario.Email);

                    cone.Open();
                    cmd.ExecuteNonQuery();

                    return "Usuario registrado con éxito";
                }
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627 || ex.Number == 2601)
                {
                    return "El nombre de usuario o email ya están registrados.";
                }
                else
                {
                    throw new Exception("Error al registrar Usuario", ex);
                }
            }
        }
    }
}
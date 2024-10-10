using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using CapaEntidad;

namespace CapaDatos
{
    public class CD_Cargo
    {
        public List<Cargo> Listar()
        {
            List<Cargo> lista = new List<Cargo>();

            try
            {
                using (SqlConnection con = new SqlConnection(Conexion.cn))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand("SP_LISTAR_CARGO", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                lista.Add(new Cargo
                                {
                                    CargoID = Convert.ToInt32(dr["CargoID"]),
                                    NomCargo = dr["NomCargo"].ToString()
                                });
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al listar cargos", ex);
            }

            return lista;
        }
    }
}

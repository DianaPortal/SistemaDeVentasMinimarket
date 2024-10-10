using System;
using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_Usuarios
    {
        private Usuarios_CD objCapaDatos = new Usuarios_CD();

        public Usuario Validar(string NomUsuario, string Contrasena)
        {
            return objCapaDatos.Validar(NomUsuario, Contrasena);
        }
        public string Registrar(Usuario usuario)
        {
            try
            {
                return objCapaDatos.Registrar(usuario);
            }
            catch (Exception ex)
            {
                throw new Exception("Error al registrar Usuario", ex);
            }
        }
    }
}

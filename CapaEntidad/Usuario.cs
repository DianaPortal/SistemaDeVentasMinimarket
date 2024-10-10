using System;

namespace CapaEntidad
{
    public class Usuario
    {
        public int UserId { get; set; }

        public string Username { get; set; }

        public string Contrasena { get; set; }

        public string Email { get; set; }

        public int RoleId { get; set; }

        public string RoleName { get; set; }

        public Usuario() { }

        public Usuario(int userId, string username, string email, int roleId, string roleName)
        {
            UserId = userId;
            Username = username ?? throw new ArgumentNullException(nameof(username));
            Email = email ?? throw new ArgumentNullException(nameof(email));
            RoleId = roleId;
            RoleName = roleName ?? throw new ArgumentNullException(nameof(roleName));
        }

    }
}

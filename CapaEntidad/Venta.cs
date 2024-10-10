using System;
using System.Collections.Generic;

namespace CapaEntidad
{
    public class Venta
    {
        public int VentaID { get; set; }
        public DateTime FechaVenta { get; set; }
        public decimal MontoTotal { get; set; }
        public int FormaPagoID { get; set; }
        public string NumeroSerie { get; set; }
        public int ClienteID { get; set; }
        public string TipoComprobante { get; set; }
        public string DNI { get; set; }
        public string NombreCompleto { get; set; }
        public List<DetalleVenta> Detalles { get; set; } = new List<DetalleVenta>();
    }
}

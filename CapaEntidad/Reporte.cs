namespace CapaEntidad
{
    public class Reporte
    {
        public string FechaVentas { get; set; }
        public string Cliente { get; set; }
        public string Producto { get; set; }
        public decimal Precio { get; set; }
        public int Cantidad { get; set; }
        public decimal SubTotal { get; set; }
        public string VentaID { get; set; }
    }
}

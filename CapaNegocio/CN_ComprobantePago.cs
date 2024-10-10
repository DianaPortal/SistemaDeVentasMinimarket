using CapaDatos;
using CapaEntidad;

namespace CapaNegocio
{
    public class CN_ComprobantePago
    {
        private readonly CD_ComprobantePago _cdComprobantePago = new CD_ComprobantePago();

        public ComprobantePago ObtenerUltimoNumeroComprobante(string tipoComprobante)
        {
            return _cdComprobantePago.ObtenerUltimoNumeroComprobante(tipoComprobante);
        }

        public void ActualizarUltimoNumeroComprobante(string tipoComprobante)
        {
            _cdComprobantePago.ActualizarUltimoNumeroComprobante(tipoComprobante);
        }

        public string GenerarNumeroComprobante(string tipoComprobante)
        {
            var comprobante = ObtenerUltimoNumeroComprobante(tipoComprobante);
            string prefix = tipoComprobante == "Boleta" ? "B" : "F";
            string numeroComprobante = $"{prefix}{(comprobante.UltimoNumero + 1).ToString("D4")}";
            return numeroComprobante;
        }
    }
}

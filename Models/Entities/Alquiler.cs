using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace Ronvelt.Models.Entities
{
    public class Alquiler
    {

        [Key]
        [Display(Name = "CODIGO")]
        public int Codigo { get; set; }

        [Display(Name = "CODIGO OBRA")]
        public int CodigoObra { get; set; }

        [Display(Name = "CODIGO DE CLIENTE")]
        public int CodigoCliente { get; set; }

        [Display(Name = "TIPO DE PAGO")]
        public string TipoPago { get; set; }

        [Display(Name = "FECHA DE ENTREGA")]
        public DateTime FechaEntrega { get; set; }

        [Display(Name = "FECHA DE DEVOLUCION")]
        public DateTime FechaDevolucion { get; set; }

        [Display(Name = "TIPO DE COMPROBANTE")]
        public string TipoComprobante { get; set; }
        
        [Display(Name = "MONTO")]
        public decimal Monto { get; set; }

    }
}

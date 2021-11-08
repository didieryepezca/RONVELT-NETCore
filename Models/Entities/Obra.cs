using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace Ronvelt.Models.Entities
{
    public class Obra
    {
        [Key]
        [Display(Name = "CODIGO")]
        public int Codigo { get; set; }

        [Display(Name = "NOMBRE")]
        public string Nombre { get; set; }

        [Display(Name = "UBICACION")]
        public string Ubicacion { get; set; }

        [Display(Name = "EMPRESA")]
        public string Empresa { get; set; }

        [Display(Name = "TELEFONO")]
        public string Telefono { get; set; }

        [Display(Name = "FAX")]
        public string Fax { get; set; }

    }
}

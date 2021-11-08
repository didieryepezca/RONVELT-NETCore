using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace Ronvelt.Models.Entities
{
    public class Cliente
    {
        [Key]
        [Display(Name = "CODIGO")] 
        public int Codigo { get; set; }

        [Display(Name = "RUC/DNI")]
        public string rUCDNI { get; set; }

        [Display(Name = "RAZON SOCIAL")]
        public string NombreRazonSocial { get; set; }

        [Display(Name = "DIRECCION")]
        public string Direccion { get; set; }

        [Display(Name = "TELEFONO")]
        public string Telefono { get; set; }

        [Display(Name = "FAX")]
        public string Fax { get; set; }

        [Display(Name = "CONTACTO")]
        public string Contacto { get; set; }

        [Display(Name = "CELULAR CONTACTO")]
        public string CelularContacto { get; set; }

        [Display(Name = "EMAIL")]
        public string Email { get; set; }

        [Display(Name = "RECOMENDABLE")]
        public bool Recomendable { get; set; }

        [Display(Name = "COMENTARIO")]
        public string Comentario { get; set; }

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace Ronvelt.Models.Entities
{
    public class Equipo
    {
        [Key]
        [Display(Name = "CODIGO")]
        public int Codigo { get; set; }

        [Display(Name = "TIPO")]
        public string Tipo { get; set; }

        [Display(Name = "SERIE")]
        public string Serie { get; set; }

        [Display(Name = "NOMBRE")]
        public string Nombre { get; set; }

        [Display(Name = "MARCA")]
        public string Marca { get; set; }

        [Display(Name = "MODELO")]
        public string Modelo { get; set; }

        [Display(Name = "COLOR")]
        public string Color { get; set; }

        [Display(Name = "MODELO MOTOR")]
        public string ModeloMotor { get; set; }

        [Display(Name = "SERIE MOTOR")]
        public string SerieMotor { get; set; }

        [Display(Name = "FECHA DE COMPRA")]
        public DateTime FechaCompra { get; set; }

        [Display(Name = "AÑO DE FABRICACION")]
        public string AnioFabricacion { get; set; }

        [Display(Name = "PRECIO POR HORA")]
        public decimal PrecioPorHora { get; set; }

        [Display(Name = "DISPONIBLE")]
        public bool Disponible { get; set; }

        [Display(Name = "TOTAL HORAS TRABAJADAS")]
        public int TotalHorasTrabajadas { get; set; }

        [Display(Name = "HORAS DISPONIBLES")]
        public int HorasDisponibles { get; set; }

        [Display(Name = "HORAS FALTANTES")]
        public int HorasFaltantes { get; set; }

    }
}

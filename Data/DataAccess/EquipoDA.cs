using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


using System.Data;
using System.Data.SqlClient;

using Ronvelt.Models.Entities;

namespace Ronvelt.Data.DataAccess
{
    public class EquipoDA
    {
        public IEnumerable<Equipo> GetAll(string serie = "", string nombre = "", string marca = "", string accion = "", bool disponible = false)
        {

            var result = new List<Equipo>();

            using (var db = new ApplicationDbContext())
            {

                IQueryable<Equipo> query = db.Equipo;

                result = db.Equipo.ToList();

                if (!String.IsNullOrWhiteSpace(accion))
                {
                    result = db.Equipo.ToList();

                }

                if (!string.IsNullOrWhiteSpace(serie))
                {
                    query = query.Where(item => item.Serie.Contains(serie));

                }

                if (!string.IsNullOrWhiteSpace(nombre))
                {

                    query = query.Where(item => item.Nombre.Contains(nombre));

                }

                if (!string.IsNullOrWhiteSpace(marca))
                {

                    query = query.Where(item => item.Marca.Contains(marca));

                }

                if (disponible != false)
                {

                    query = query.Where(item => item.Disponible == disponible);

                }

                query = query.OrderBy(c => c.Codigo);

                return query.ToList();

            }
        }


        public int insertEquipo(Equipo equipo)
        {
            var result = 0;

            using (var db = new ApplicationDbContext())
            {
                db.Add(equipo);
                result = db.SaveChanges();
            }
            return result;
        }



        public Equipo GetEquipo(int codigo)
        {
            var result = new Equipo();
            {
                using (var db = new ApplicationDbContext())
                {
                    result = db.Equipo.Where(item => item.Codigo == codigo).FirstOrDefault();
                }
            }
            return result;
        }


        public int UpdateEquipo(Equipo equipo)
        {
            var result = 0;
            using (var db = new ApplicationDbContext())
            {
                var eq = db.Equipo.Where(item => item.Codigo == equipo.Codigo).FirstOrDefault();

                eq.Tipo = equipo.Tipo;
                eq.Serie = equipo.Serie;
                eq.Nombre = equipo.Nombre;
                eq.Marca = equipo.Marca;
                eq.Modelo = equipo.Modelo;
                eq.Color = equipo.Color;
                eq.ModeloMotor = equipo.ModeloMotor;
                eq.SerieMotor = equipo.SerieMotor;
                eq.FechaCompra = equipo.FechaCompra;
                eq.AnioFabricacion = equipo.AnioFabricacion;
                eq.PrecioPorHora = equipo.PrecioPorHora;
                eq.Disponible = equipo.Disponible;
                eq.TotalHorasTrabajadas = equipo.TotalHorasTrabajadas;
                eq.HorasDisponibles = equipo.HorasDisponibles;
                eq.HorasFaltantes = equipo.HorasFaltantes;

                result = db.SaveChanges();
            }

            return result;
        }




    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;


using System.Data;
using System.Data.SqlClient;

using Ronvelt.Models.Entities;


namespace Ronvelt.Data.DataAccess
{
    public class AlquilerDA
    {
        public IEnumerable<Alquiler> GetAllAlquileres(DateTime fecha_entrega, int codigo_cliente, int codigo_obra, string accion = "")
        {
            var ana = new List<Alquiler>();

            using (var db = new ApplicationDbContext())
            {
                IQueryable<Alquiler> query = db.Alquiler;

                ana = db.Alquiler.ToList();

                if (!String.IsNullOrWhiteSpace(accion))
                {
                    query = query.Where(item => item.FechaEntrega.Date == fecha_entrega.Date);
                }

                if (codigo_cliente != 0)
                {
                    query = query.Where(item => item.CodigoCliente == codigo_cliente);
                }

                if (codigo_obra != 0)
                {
                    query = query.Where(item => item.CodigoObra == codigo_obra);
                }

                ana = query.ToList();
            }
            return ana;
        }


        public int insertAlquiler(Alquiler alquiler)
        {
            var result = 0;

            using (var db = new ApplicationDbContext())
            {
                db.Add(alquiler);
                result = db.SaveChanges();
            }
            return result;
        }


        public Alquiler GetAlquiler(int codigo)
        {
            var result = new Alquiler();
            {
                using (var db = new ApplicationDbContext())
                {
                    result = db.Alquiler.Where(item => item.Codigo == codigo).FirstOrDefault();
                }
            }
            return result;
        }

        public int UpdateAlquiler(Alquiler alquiler)
        {
            var result = 0;
            using (var db = new ApplicationDbContext())
            {
                var alq = db.Alquiler.Where(item => item.Codigo == alquiler.Codigo).FirstOrDefault();

                alq.TipoPago = alquiler.TipoPago;
                alq.FechaEntrega = alquiler.FechaEntrega;
                alq.FechaDevolucion = alquiler.FechaDevolucion;
                alq.TipoComprobante = alquiler.TipoComprobante;
                alq.CodigoCliente = alquiler.CodigoCliente;
                alq.CodigoObra = alquiler.CodigoObra;
                alq.Monto = alquiler.Monto;                             

                result = db.SaveChanges();
            }

            return result;
        }




    }
}

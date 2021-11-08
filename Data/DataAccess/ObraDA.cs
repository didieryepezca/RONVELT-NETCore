using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

using Ronvelt.Models.Entities;



namespace Ronvelt.Data.DataAccess
{
    public class ObraDA
    {
        public IEnumerable<Obra> GetAll(string nombre = "", string empresa = "", string accion = "")
        {

            var result = new List<Obra>();

            using (var db = new ApplicationDbContext())
            {

                IQueryable<Obra> query = db.Obra;

                result = db.Obra.ToList();

                if (!String.IsNullOrWhiteSpace(accion))
                {
                    result = db.Obra.ToList();

                }

                if (!string.IsNullOrWhiteSpace(nombre))
                {
                    query = query.Where(item => item.Nombre.Contains(nombre));

                }

                if (!string.IsNullOrWhiteSpace(empresa))
                {

                    query = query.Where(item => item.Empresa == empresa);

                }

                query = query.OrderBy(c => c.Codigo);

                return query.ToList();

            }
        }


        public int insertObra(Obra obra)
        {
            var result = 0;

            using (var db = new ApplicationDbContext())
            {
                db.Add(obra);
                result = db.SaveChanges();
            }
            return result;
        }


        public Obra GetObra(int codigo)
        {
            var result = new Obra();
            {
                using (var db = new ApplicationDbContext())
                {
                    result = db.Obra.Where(item => item.Codigo == codigo).FirstOrDefault();
                }
            }
            return result;
        }

        public int UpdateObra(Obra obra)
        {
            var result = 0;
            using (var db = new ApplicationDbContext())
            {
                var ob = db.Obra.Where(item => item.Codigo == obra.Codigo).FirstOrDefault();

                ob.Nombre = obra.Nombre;
                ob.Ubicacion = obra.Ubicacion;
                ob.Empresa = obra.Empresa;
                ob.Telefono = obra.Telefono;
                ob.Fax = obra.Fax;
                

                result = db.SaveChanges();
            }

            return result;
        }

        public IEnumerable<Obra> getObras()
        {
            var result = new List<Obra>();

            using (var db = new ApplicationDbContext())
            {
                result = db.Obra.ToList();

                return result;
            }
        }



    }
}

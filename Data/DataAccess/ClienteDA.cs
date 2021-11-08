using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using System.Data;
using System.Data.SqlClient;

using Ronvelt.Models.Entities;

namespace Ronvelt.Data.DataAccess
{
    public class ClienteDA
    {
        public IEnumerable<Cliente> GetAll(string nombre = "", string rucdni = "", string accion = "")
        {

            var result = new List<Cliente>();

            using (var db = new ApplicationDbContext())
            {

                IQueryable<Cliente> query = db.Cliente;

                result = db.Cliente.ToList();

                if (!String.IsNullOrWhiteSpace(accion))
                {
                    result = db.Cliente.ToList();

                }

                if (!string.IsNullOrWhiteSpace(nombre))
                {
                    query = query.Where(item => item.NombreRazonSocial.Contains(nombre));
                    
                }

                if (!string.IsNullOrWhiteSpace(rucdni))
                {

                    query = query.Where(item => item.rUCDNI == rucdni);

                }                

                query = query.OrderBy(c => c.Codigo);

                return query.ToList();

            }
        }


        public int insertCliente(Cliente cliente)
        {
            var result = 0;

            using (var db = new ApplicationDbContext())
            {
                db.Add(cliente);
                result = db.SaveChanges();
            }
            return result;
        }


        public Cliente GetCliente(int codigo)
        {
            var result = new Cliente();
            {
                using (var db = new ApplicationDbContext())
                {
                    result = db.Cliente.Where(item => item.Codigo == codigo).FirstOrDefault();
                }
            }
            return result;
        }

        public int UpdateCliente(Cliente cliente)
        {
            var result = 0;
            using (var db = new ApplicationDbContext())
            {
                var cli = db.Cliente.Where(item => item.Codigo == cliente.Codigo).FirstOrDefault();

                cli.rUCDNI = cliente.rUCDNI;
                cli.NombreRazonSocial = cliente.NombreRazonSocial;
                cli.Direccion = cliente.Direccion;
                cli.Telefono = cliente.Telefono;
                cli.Fax = cliente.Fax;
                cli.Contacto = cliente.Contacto;
                cli.CelularContacto = cliente.CelularContacto;
                cli.Email = cliente.Email;
                cli.Recomendable = cliente.Recomendable;
                cli.Comentario = cliente.Comentario;                               

                result = db.SaveChanges();
            }

            return result;
        }




        public IEnumerable<Cliente> getClientes()
        {
            var result = new List<Cliente>();

            using (var db = new ApplicationDbContext())
            {
                result = db.Cliente.ToList();

                return result;
            }
        }




    }
}

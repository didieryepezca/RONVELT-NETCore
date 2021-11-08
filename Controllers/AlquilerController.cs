using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

using Ronvelt.Models;
using Ronvelt.Models.Entities;
using Ronvelt.Data;
using Ronvelt.Data.DataAccess;

namespace Ronvelt.Controllers
{
    public class AlquilerController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult alquiler_Lista(DateTime fecha_entrega, int codigo_cliente, int codigo_obra, string accion = "")
        {

            AlquilerDA ada = new AlquilerDA();
                       
            ClienteDA clida = new ClienteDA();
            ObraDA oda = new ObraDA();

            var clis = clida.getClientes();
            var obras = oda.getObras();

            ViewBag.clientesList = clis;
            ViewBag.obrasList = obras;


            string vAccion = "";


            if (fecha_entrega.Date == Convert.ToDateTime("01/01/0001").Date)
            {

                fecha_entrega = DateTime.Now;
            }

            ViewBag.fecha_entrega = fecha_entrega.ToString("yyyy-MM-dd");

            if (!String.IsNullOrWhiteSpace(accion))
            {
                vAccion = accion;
            }
                                   

            var model = ada.GetAllAlquileres(fecha_entrega, codigo_cliente, codigo_obra, vAccion);


            //string nombreCliente = "";

            //foreach(var cliente in model)
            //{
            //    var cl = clis.Select(x => x.Codigo = cliente.CodigoCliente);

            //    var names = model.Where(y => y.CodigoCliente = cliente.Codigo);
                                
            //    //cliente. = 
            
            //        //ViewBag.NombresClientes =;
            //}




            return View(model);
        }

        public IActionResult alquiler_Nuevo(DateTime fec_entrega, DateTime fec_devolucion)
        {

            ClienteDA clida = new ClienteDA();
            ObraDA oda = new ObraDA();

            var clis = clida.getClientes();
            var obras = oda.getObras();

            if (fec_entrega.Date == Convert.ToDateTime("01/01/0001").Date)
            {

                fec_entrega = DateTime.Now;
            }
            if (fec_devolucion.Date == Convert.ToDateTime("01/01/0001").Date)
            {

                fec_devolucion = DateTime.Now;
            }


            ViewBag.fechaEntrega = fec_entrega.ToString("yyyy-MM-dd");
            ViewBag.fechaDevolucion = fec_devolucion.ToString("yyyy-MM-dd");


            ViewBag.clientesList = clis;
            ViewBag.obrasList = obras;

            return View();
        }


        [HttpPost]
        public IActionResult alquiler_Nuevo(Alquiler alquiler, DateTime fec_entrega, DateTime fec_devolucion)
        {

            ClienteDA clida = new ClienteDA();
            ObraDA oda = new ObraDA();

            var clis = clida.getClientes();
            var obras = oda.getObras();

            ViewBag.clientesList = clis;
            ViewBag.obrasList = obras;

            AlquilerDA alquiDA = new AlquilerDA();

            alquiler.FechaEntrega = fec_entrega;
            alquiler.FechaDevolucion = fec_devolucion;

            var result = alquiDA.insertAlquiler(alquiler);

            if (result > 0)
            {
                return RedirectToAction("alquiler_Lista", "Alquiler");
            }
            else
            {
                ViewBag.msgError = "Error no se grabo";

                return View(alquiler);
            }

            //return View();
        }

        public IActionResult alquiler_Editar(int codigo, DateTime fec_entrega, DateTime fec_devolucion)
        {
            AlquilerDA alquiDA = new AlquilerDA();

            ClienteDA clida = new ClienteDA();
            ObraDA oda = new ObraDA();

            var clis = clida.getClientes();
            var obras = oda.getObras();

            ViewBag.clientesList = clis;
            ViewBag.obrasList = obras;

            if (fec_entrega.Date == Convert.ToDateTime("01/01/0001").Date)
            {
                fec_entrega = DateTime.Now;
            }
            if (fec_devolucion.Date == Convert.ToDateTime("01/01/0001").Date)
            {

                fec_devolucion = DateTime.Now;
            }
                                          
            var model = alquiDA.GetAlquiler(codigo);

            return View(model);
        }

        [HttpPost]
        public IActionResult alquiler_Editar(Alquiler alquiler, DateTime fec_entrega, DateTime fec_devolucion)
        {
            AlquilerDA alquiDA = new AlquilerDA();

            alquiler.FechaEntrega = fec_entrega;
            alquiler.FechaDevolucion = fec_devolucion;

            var result = alquiDA.UpdateAlquiler(alquiler);


            if (result > 0)
            {
                return RedirectToAction("alquiler_Lista", "Alquiler");
            }
            else
            {

                ViewBag.msgError = "Error no se grabo";
                return View(alquiler);
            }

        }






    }
}
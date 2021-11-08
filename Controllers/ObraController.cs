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
    public class ObraController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult obra_Lista(string nombre = "", string empresa = "", string accion = "")
        {

            ObraDA oda = new ObraDA();

            string vAccion = "";

            if (!String.IsNullOrWhiteSpace(accion))
            {
                vAccion = accion;
            }

            var model = oda.GetAll(nombre, empresa, vAccion);


            return View(model);
        }


        public IActionResult obra_Nuevo()
        {
            return View();
        }


        [HttpPost]
        public IActionResult obra_Nuevo(Obra obra)
        {
            ObraDA oda = new ObraDA();

            var result = oda.insertObra(obra);

            if (result > 0)
            {
                return RedirectToAction("obra_Lista", "Obra");

            }
            else
            {
                ViewBag.msgError = "Error no se grabo";

                return View(obra);
            }
            //return View();
        }


        public IActionResult obra_Editar(int codigo)
        {
            ObraDA oda = new ObraDA();

            var model = oda.GetObra(codigo);

            return View(model);
        }


        [HttpPost]
        public IActionResult obra_Editar(Obra obra)
        {
            ObraDA oda = new ObraDA();

            var result = oda.UpdateObra(obra);

            if (result > 0)
            {
                return RedirectToAction("obra_Lista", "Obra");
            }
            else
            {
                ViewBag.msgError = "Error no se grabo";

                return View(obra);
            }
        }



    }
}
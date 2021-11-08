using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

using Microsoft.AspNetCore.Http;
using System.Data.SqlClient;
using System.Data;
using Microsoft.EntityFrameworkCore;

using Ronvelt.Models;
using Ronvelt.Models.Entities;
using Ronvelt.Data;
using Ronvelt.Data.DataAccess;



namespace Ronvelt.Controllers
{
    public class EquipoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult equipo_Lista(string serie = "", string nombre = "", string marca = "", string accion = "", bool disponible = false)
        {

            EquipoDA eqda = new EquipoDA();

            string vAccion = "";

            if (!String.IsNullOrWhiteSpace(accion))
            {
                vAccion = accion;
            }

            var model = eqda.GetAll(serie, nombre, marca, vAccion, disponible);


            return View(model);
        }


        public IActionResult equipo_Nuevo()
        {
            return View();
        }


        [HttpPost]
        public IActionResult equipo_Nuevo(Equipo eq)
        {
            EquipoDA da = new EquipoDA();

            var result = da.insertEquipo(eq);

            if (result > 0)
            {
                return RedirectToAction("equipo_Lista", "Equipo");
                
            }
            else
            {
                ViewBag.msgError = "Error no se grabo";

                return View(eq);
            }
            //return View();
        }


        public IActionResult equipo_Editar(int codigo)
        {
            EquipoDA da = new EquipoDA();

            var model = da.GetEquipo(codigo);

            return View(model);
        }


        [HttpPost]
        public IActionResult equipo_Editar(Equipo equipo)
        {
            EquipoDA da = new EquipoDA();

            var result = da.UpdateEquipo(equipo);

            if (result > 0)
            {
                return RedirectToAction("equipo_Lista", "Equipo");
            }
            else
            {
                ViewBag.msgError = "Error no se grabo";

                return View(equipo);
            }
        }
    }
}
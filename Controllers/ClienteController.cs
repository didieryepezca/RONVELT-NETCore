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
    public class ClienteController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

       
        public IActionResult cliente_Nuevo()
        {
            return View();
        }

        [HttpPost]
        public IActionResult cliente_Nuevo(Cliente cli)
        {
            ClienteDA da = new ClienteDA();

            var result = da.insertCliente(cli);

            if (result > 0)
            {
                return RedirectToAction("Index","Home");
            }
            else
            {
                ViewBag.msgError = "Error no se grabo";

                return View(cli);
            }
            //return View();
        }

        public IActionResult cliente_Editar(int codigo)
        {
            ClienteDA da = new ClienteDA();

            var model = da.GetCliente(codigo);

            return View(model);
        }

        [HttpPost]
        public IActionResult cliente_Editar(Cliente cliente)
        {
            ClienteDA da = new ClienteDA();

            var result = da.UpdateCliente(cliente);

            if (result > 0)
            {
                return RedirectToAction("Index", "Home");
            }
            else {

                ViewBag.msgError = "Error no se grabo";
                return View(cliente);
            }
               
        }



    }
}
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Ronvelt.Models;

using Ronvelt.Data.DataAccess;
using Microsoft.AspNetCore.Authorization;

namespace Ronvelt.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        [Authorize]
        [HttpGet]
        public IActionResult Index(string nombre = "", string rucdni = "", string accion = "")
        {
            ClienteDA clida = new ClienteDA();

            string vAccion = "";

            if (!String.IsNullOrWhiteSpace(accion))
            {
                vAccion = accion;
            }


            var model = clida.GetAll(nombre,rucdni, vAccion);

            return View(model);
        }



        public IActionResult Privacy()
        {

            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}

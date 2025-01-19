using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace usermanagementMVC.Controllers
{
    public class DashboardController : BaseController
    {
        // GET: Dashbaord
        public ActionResult Index()
        {
            if (Session["UserId"] == null)
            {
                return RedirectToAction("Index", "Login");
            }

            // Console.WriteLine($"User {Session["Username"]} is accessing the Dashboard.");

            return View();
        }
    }
}
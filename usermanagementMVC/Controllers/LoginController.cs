using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using usermanagementMVC.Models;
using System.Security.Cryptography;
using System.Text;

namespace usermanagementMVC.Controllers
{
    public class LoginController : Controller
    {
        private DBEntities db = new DBEntities();
        // GET: Login
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(LoginModel model)
        {
            if (ModelState.IsValid)
            {
                // Hash the entered password
                string hashedPassword = HashPassword(model.Password);

                var user = db.users.FirstOrDefault(u => u.email == model.Email && u.password == hashedPassword);
                if (user != null)
                {
                    Session["UserId"] = user.id;
                    Session["Username"] = user.email;
                    Session["RoleId"] = 1;
                    return RedirectToAction("Index", "Dashboard");
                }
                ViewBag.ErrorMessage = "Invalid username or password.";
            }
            return View(model);
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(password);
                byte[] hash = sha256.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }

        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Index", "Login");
        }

    }
}
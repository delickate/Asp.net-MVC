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
    public class BaseController : Controller
    {
        private DBEntities db = new DBEntities();
        // GET: Base
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (Session["RoleId"] != null)
            {
                using (var db = new DBEntities())
                {
                    // Fetch the user's role ID from the session
                    var roleId = (int)Session["RoleId"];

                    // Fetch modules based on the role's permissions
                    var modules = db.roles_modules_permissions
                            .Where(rmp => rmp.role_id == roleId)
                            .Join(db.modules,
                                  rmp => rmp.module_id,
                                  m => m.id,
                                  (rmp, m) => new ModuleViewModel
                                  {
                                      Name = m.name,
                                      Url = m.url
                                  })
                            .ToList();


                    // Pass the modules to the ViewBag
                    ViewBag.Modules = modules;
                }
            }
            else
            {
                ViewBag.Modules = null; // No navigation data for users without a role
            }

            base.OnActionExecuting(filterContext);
        }
    }
}
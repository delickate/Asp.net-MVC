using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace usermanagementMVC.Controllers
{
    public class LoginRequiredAttribute : ActionFilterAttribute
    {
        // GET: LoginRequiredAttribute
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Session["UserId"] == null)
            {
                // If user is not logged in, redirect to the Login page
                filterContext.Result = new RedirectToRouteResult(
                    new System.Web.Routing.RouteValueDictionary
                    {
                    { "controller", "Login" },
                    { "action", "Index" }
                    });
            }

            base.OnActionExecuting(filterContext);
        }
    }


}
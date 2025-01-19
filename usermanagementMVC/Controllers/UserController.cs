using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using usermanagementMVC.Models;
using System.Security.Cryptography;
using System.Text;


namespace usermanagementMVC.Controllers
{
    public class UserController : Controller
    {
        private DBEntities db = new DBEntities();

        // GET: User
        public ActionResult Index()
        {
            var users = db.users.ToList();
            return View(users);
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

        // GET: User/Details/5
        // GET: Details User
        [HttpGet]
        public ActionResult Details(int id)
        {
            var user = db.users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }

            // Fetch the role name associated with the user
            // Fetch the role name associated with the user
            var roles = (from rmp in db.roles_modules_permissions
                        join role in db.roles on rmp.role_id equals role.id
                        where rmp.module_id == user.id
                        select role.name).FirstOrDefault();


            ViewBag.RoleName = roles ?? "No Role Assigned";

            return View(user);
        }

        // GET: User/Create
        public ActionResult Create()
        {
            var model = new UserViewModel
            {
                Roles = db.roles.Select(r => new SelectListItem
                {
                    Value = r.id.ToString(),
                    Text = r.name
                }).ToList()
            };

            return View(model);
        }

        // POST: User/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(UserViewModel model, HttpPostedFileBase Picture)
        {
            try
            {

                if (ModelState.IsValid)
            {
                var emailExists = db.users.Any(u => u.email == model.Email);
                if (emailExists)
                {
                    throw new Exception("Email already exists.");
                }

                    string hashedPassword = HashPassword(model.Password);

                    var user = new user
                {
                    email = model.Email,
                    name = model.Name,
                    password = hashedPassword,
                    phone = model.Phone,
                    is_default = model.IsDefault
                };

                // Handle file upload
                if (Picture != null && Picture.ContentLength > 0)
                {
                    var fileName = Path.GetFileName(Picture.FileName);
                    var path = Path.Combine(Server.MapPath("~/Uploads"), fileName);
                    Picture.SaveAs(path);
                    user.picture = fileName;
                }
                else
                {
                    user.picture = null; // Handle the default case.
                }


                db.users.Add(user);
                try
                {
                    db.SaveChanges();
                }
                catch (System.Data.Entity.Validation.DbEntityValidationException ex)
                {
                    foreach (var validationErrors in ex.EntityValidationErrors)
                    {
                        foreach (var validationError in validationErrors.ValidationErrors)
                        {
                            Console.WriteLine($"Property: {validationError.PropertyName}, Error: {validationError.ErrorMessage}");
                        }
                    }
                    throw; // Rethrow after logging.
                }
                catch (System.Data.Entity.Infrastructure.DbUpdateException ex)
                {
                    Console.WriteLine(ex.InnerException?.Message);
                    throw; // Rethrow after logging.
                }

                //check if role exists
                var roleExists = db.roles.Any(r => r.id == model.RoleId);
                if (!roleExists)
                {
                    throw new Exception("Invalid role ID.");
                }


                // Assign role
                var roleAssignment = new roles_modules_permissions
                {
                    role_id = model.RoleId,
                    module_id = user.id // Assuming module_id maps to user id
                };
                db.roles_modules_permissions.Add(roleAssignment);
                db.SaveChanges();

                return RedirectToAction("Index");
            }

                // Reload roles if model state is invalid
            }
            catch (Exception ex)
            {
                ViewBag.ErrorMessage = $"Error: {ex.Message}";
            }

            // Reload roles for dropdown
            model.Roles = db.roles.Select(r => new SelectListItem
            {
                Value = r.id.ToString(),
                Text = r.name
            }).ToList();

            return View(model);
        }


        // GET: User/Edit/5
        [HttpGet]
        public ActionResult Edit(int id)
        {
            var user = db.users.Find(id);
            if (user == null || user.is_default)
            {
                return HttpNotFound();
            }

            var roleId = db.roles_modules_permissions
                .Where(rmp => rmp.module_id == user.id)
                .Select(rmp => rmp.role_id)
                .FirstOrDefault();

            // Create a SelectList for roles, and set the selected role based on the user's role_id
            ViewBag.Roles = new SelectList(db.roles.ToList(), "id", "name", roleId);

            return View(user);
        }

        [HttpPost]
        public ActionResult Edit(user model, HttpPostedFileBase picture, int RoleId)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var user = db.users.Find(model.id);
                    if (user == null || user.is_default)
                    {
                        return HttpNotFound();
                    }

                    user.name = model.name;
                    user.phone = model.phone;

                    if (picture != null && picture.ContentLength > 0)
                    {
                        var fileName = Guid.NewGuid() + System.IO.Path.GetExtension(picture.FileName);
                        var path = System.IO.Path.Combine(Server.MapPath("~/Uploads"), fileName);
                        picture.SaveAs(path);
                        user.picture = fileName;
                    }

                    // Validate RoleId
                    if (!db.roles.Any(r => r.id == RoleId))
                    {
                        throw new Exception("Invalid RoleId: Role does not exist.");
                    }

                    // Validate user.id
                    if (!db.modules.Any(m => m.id == user.id))
                    {
                        throw new Exception("Invalid ModuleId: Module does not exist.");
                    }


                    // Update role information
                    var rolePermission = db.roles_modules_permissions.FirstOrDefault(r => r.role_id == RoleId && r.module_id == user.id);
                    if (rolePermission == null)
                    {
                        db.roles_modules_permissions.Add(new roles_modules_permissions
                        {
                            role_id = RoleId,
                            module_id = user.id
                        });
                    }
                    else
                    {
                        rolePermission.role_id = RoleId;
                    }

                    try
                    {
                        db.SaveChanges();
                    }
                    catch (System.Data.Entity.Infrastructure.DbUpdateException ex)
                    {
                        Console.WriteLine(ex.InnerException?.InnerException?.Message);
                        throw;
                    }


                    return RedirectToAction("Index");
                }

                ViewBag.Roles = new SelectList(db.roles.ToList(), "id", "name", RoleId);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                throw; // Optionally rethrow or handle the exception
            }

            return View(model);
        }


        // GET: User/Delete/5
        [HttpGet]
        public ActionResult Delete(int id)
        {
            var user = db.users.Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }

            if (user.is_default)
            {
                TempData["ErrorMessage"] = "Default users cannot be deleted.";
                return RedirectToAction("Index");
            }

            // Fetch the role name associated with the user
            var roles = (from rmp in db.roles_modules_permissions
                        join role in db.roles on rmp.role_id equals role.id
                        where rmp.module_id == user.id
                        select role.name).FirstOrDefault();



            ViewBag.RoleName = roles ?? "No Role Assigned";

            return View(user);
        }

        [HttpPost]
        public ActionResult Delete(user model)
        {
            var user = db.users.Find(model.id);
            if (user == null)
            {
                return HttpNotFound();
            }

            if (user.is_default)
            {
                TempData["ErrorMessage"] = "Default users cannot be deleted.";
                return RedirectToAction("Index");
            }

            // Remove user from database
            db.users.Remove(user);

            // Remove related role permissions
            var rolesPermissions = db.roles_modules_permissions.Where(r => r.module_id == user.id).ToList();
            db.roles_modules_permissions.RemoveRange(rolesPermissions);

            db.SaveChanges();

            TempData["SuccessMessage"] = "User deleted successfully.";
            return RedirectToAction("Index");
        }
    }
}

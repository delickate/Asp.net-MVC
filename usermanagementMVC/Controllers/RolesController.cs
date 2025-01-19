using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using usermanagementMVC.Models;

namespace usermanagementMVC.Controllers
{
    [LoginRequired]
    public class RolesController : Controller
    {
        private DBEntities db = new DBEntities();

       

        // GET: Roles
        public ActionResult Index()
        {
            

            var roles = db.roles.ToList();
            return View(roles);
            // View();
        }

        // GET: Roles/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Roles/Create
        public ActionResult Create()
        {
            var model = new RoleViewModel
            {
                Modules = db.modules.Select(m => new ModuleViewModel
                {
                    Id = m.id,
                    Name = m.name,
                    IsSelected = false,
                    Rights = db.rights.Select(r => new RightViewModel
                    {
                        Id = r.id,
                        RightName = r.name,
                        IsSelected = false // Default to unselected
                    }).ToList()
                }).ToList()
            };

            return View(model);
        }



        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(RoleViewModel model)
        {
            if (ModelState.IsValid)
            {
                var role = new role
                {
                    name = model.Name
                };

                db.roles.Add(role);
                db.SaveChanges();

                foreach (var module in model.Modules)
                {
                    if (module.IsSelected)
                    {
                        var roleModulePermission = new roles_modules_permissions
                        {
                            role_id = role.id,
                            module_id = module.Id
                        };

                        db.roles_modules_permissions.Add(roleModulePermission);
                        db.SaveChanges();

                        foreach (var right in module.Rights)
                        {
                            if (right.IsSelected)
                            {
                                db.roles_modules_permissions_rights.Add(new roles_modules_permissions_rights
                                {
                                    rights_id = right.Id,
                                    roles_modules_permissions_id = roleModulePermission.id
                                });
                            }
                        }
                    }
                }

                db.SaveChanges();
                return RedirectToAction("Index");
            }

            // If validation fails, reload Modules and Rights for redisplay
            model.Modules = db.modules.Select(m => new ModuleViewModel
            {
                Id = m.id,
                Name = m.name,
                IsSelected = false,
                Rights = db.rights.Select(r => new RightViewModel
                {
                    Id = r.id,
                    RightName = r.name,
                    IsSelected = false
                }).ToList()
            }).ToList();

            return View(model);
        }




        // GET: Roles/Edit/5
        public ActionResult Edit(int id)
        {
            // Fetch the role and associated data
            var role = db.roles.Find(id);
            if (role == null) return HttpNotFound();

            var model = new RoleViewModel
            {
                Name = role.name,
                Modules = db.modules.Select(m => new ModuleViewModel
                {
                    Id = m.id,
                    Name = m.name,
                    IsSelected = db.roles_modules_permissions
                                   .Any(rmp => rmp.role_id == id && rmp.module_id == m.id),
                    Rights = db.rights.Select(r => new RightViewModel
                    {
                        Id = r.id,
                        RightName = r.name,
                        IsSelected = db.roles_modules_permissions_rights
                                       .Any(rmpr => rmpr.roles_modules_permissions.role_id == id
                                                    && rmpr.roles_modules_permissions.module_id == m.id
                                                    && rmpr.rights_id == r.id)
                    }).ToList()
                }).ToList()
            };

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(RoleViewModel model)
        {
            if (ModelState.IsValid)
            {
                // Fetch the role from the database
                var role = db.roles.FirstOrDefault(r => r.name == model.Name);
                if (role == null) return HttpNotFound();

                // Remove existing permissions for this role
                var existingPermissions = db.roles_modules_permissions.Where(rmp => rmp.role_id == role.id).ToList();
                foreach (var permission in existingPermissions)
                {
                    // Remove rights associated with this permission
                    var existingRights = db.roles_modules_permissions_rights
                                           .Where(rmpr => rmpr.roles_modules_permissions_id == permission.id)
                                           .ToList();
                    db.roles_modules_permissions_rights.RemoveRange(existingRights);

                    // Remove the permission itself
                    db.roles_modules_permissions.Remove(permission);
                }

                db.SaveChanges();

                // Add updated modules and rights
                foreach (var module in model.Modules)
                {
                    if (module.IsSelected)
                    {
                        // Add the selected module permission
                        var roleModulePermission = new roles_modules_permissions
                        {
                            role_id = role.id,
                            module_id = module.Id
                        };
                        db.roles_modules_permissions.Add(roleModulePermission);
                        db.SaveChanges();

                        // Add associated rights
                        foreach (var right in module.Rights)
                        {
                            if (right.IsSelected)
                            {
                                db.roles_modules_permissions_rights.Add(new roles_modules_permissions_rights
                                {
                                    roles_modules_permissions_id = roleModulePermission.id,
                                    rights_id = right.Id
                                });
                            }
                        }
                    }
                }

                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(model);
        }



        public ActionResult Delete(int id)
        {
            var role = db.roles.FirstOrDefault(r => r.id == id);
            if (role == null)
            {
                return HttpNotFound();
            }

            // Pass the role data to the view for confirmation
            return View(role);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            var role = db.roles.FirstOrDefault(r => r.id == id);
            if (role != null)
            {
                // Remove associated permissions and rights first
                var permissions = db.roles_modules_permissions.Where(rmp => rmp.role_id == role.id).ToList();
                foreach (var permission in permissions)
                {
                    // Remove associated rights
                    var rights = db.roles_modules_permissions_rights
                                   .Where(rmrp => rmrp.roles_modules_permissions_id == permission.id)
                                   .ToList();
                    db.roles_modules_permissions_rights.RemoveRange(rights);

                    // Remove the module permission
                    db.roles_modules_permissions.Remove(permission);
                }

                // Remove the role
                db.roles.Remove(role);
                db.SaveChanges();
            }

            return RedirectToAction("Index");
        }

    }
}

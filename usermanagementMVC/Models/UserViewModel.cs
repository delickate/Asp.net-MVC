using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace usermanagementMVC.Models
{
    public class UserViewModel
    {
        public int Id { get; set; }
        public string Email { get; set; }
        public string Name { get; set; }
        public string Password { get; set; }
        public string Phone { get; set; }
        public string Picture { get; set; } // File upload for picture
        public bool IsDefault { get; set; }

        public int RoleId { get; set; } // For dropdown to select role
        public IEnumerable<SelectListItem> Roles { get; set; }
    }
}
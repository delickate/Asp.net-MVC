using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace usermanagementMVC.Models
{
  

    public class RoleViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<ModuleViewModel> Modules { get; set; } = new List<ModuleViewModel>();
    }

    public class ModuleWithRights
    {
        public int ModuleId { get; set; }
        public string ModuleName { get; set; }
        public bool IsSelected { get; set; }
        public List<RightWithSelection> Rights { get; set; }
    }

    public class RightWithSelection
    {
        public int RightId { get; set; }
        public string RightName { get; set; }
        public bool IsSelected { get; set; }
    }
}
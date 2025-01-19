using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace usermanagementMVC.Models
{
    public class ModuleViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Url { get; set; }

        public bool IsSelected { get; set; }

        public List<RightViewModel> Rights { get; set; } = new List<RightViewModel>(); //
    }

    public class RightViewModel
    {
        public int Id { get; set; }
        public string RightName { get; set; }
        public bool IsSelected { get; set; }
    }
}
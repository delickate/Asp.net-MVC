//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace usermanagementMVC.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class users_roles
    {
        public int id { get; set; }
        public int user_id { get; set; }
        public int role_id { get; set; }
    
        public virtual role role { get; set; }
        public virtual user user { get; set; }
    }
}

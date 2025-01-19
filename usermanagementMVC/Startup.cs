using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(usermanagementMVC.Startup))]
namespace usermanagementMVC
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

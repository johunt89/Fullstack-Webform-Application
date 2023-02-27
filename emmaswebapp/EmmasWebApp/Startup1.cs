using Microsoft.Owin;
using Owin;
using System;
using System.Threading.Tasks;
using Microsoft.Owin.Security.Cookies;
using Microsoft.AspNet.Identity;


[assembly: OwinStartup(typeof(EmmasWebApp.Startup1))]

namespace EmmasWebApp
{
    public class Startup1
    {
        public void Configuration(IAppBuilder app)
        {
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                CookieName = "EmmasCookie",
                LoginPath = new PathString("/Login"),
                LogoutPath = new PathString("/Login"),
                ExpireTimeSpan = System.TimeSpan.FromMinutes(10)
            });
           
        }
    }
}

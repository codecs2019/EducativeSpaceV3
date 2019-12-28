using EducativeSpace.Models;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.Security;

namespace JfrSystems.Models
{
    public class ApplicationUser
    {
        public string UserName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string AvatarUrl { get; set; }
        public string Rolename { get; set; }
        public string SiteID { get; set; }
        public string Exercice { get; set; }
    }

    public static class AuthHelper
    {
        public static int SignIn(string userName, string password)
        {
            bool check = Membership.ValidateUser(userName, password);
            if (check)
            {
                try
                {
                    HttpContext.Current.Session["User"] = CreateDefaultUser(userName);// Mock user data
                    return 0;

                }
                catch (System.Exception)
                {
                    return 2;
                }
            }
            else
            {
                return 1;
            }
        }
        public static void SignOut()
        {
            HttpContext.Current.Session["User"] = null;
        }
        public static bool IsAuthenticated()
        {
            return GetLoggedInUserInfo() != null;
        }

        public static ApplicationUser GetLoggedInUserInfo()
        {
            return HttpContext.Current.Session["User"] as ApplicationUser;
        }
        private static ApplicationUser CreateDefaultUser(string userName)
        {
            DataTable dt = new DataTable(); ArrayList cle = new ArrayList(); ArrayList val = new ArrayList();
            cle.Add("@userName"); val.Add(userName);
            cle.Add("@sender"); val.Add(0);
            Cl_Fonction.Extraction_ds("PS_USERCONFIRM", cle, val, ref dt);

            return new ApplicationUser
            {
                UserName = userName,
                FirstName = dt.Rows[0]["PRENOMS_PERSONNE"].ToString(),
                LastName = dt.Rows[0]["NOM_PERSONNE"].ToString(),
                Email = dt.Rows[0]["EMAIL"].ToString(),
                AvatarUrl = dt.Rows[0]["AVATAR"].ToString(),
                Rolename = dt.Rows[0]["ROLENAME"].ToString(),
                SiteID = dt.Rows[0]["SITE_ID"].ToString(),
                Exercice = "2019",
            };
            }
    }
    }
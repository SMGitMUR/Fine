using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Configuration;


namespace Fine.forms
{
    /// <summary>
    /// Summary description for viewdriverws
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class viewdriverws : System.Web.Services.WebService
    {

        [WebMethod]
        public void GetUsers()
        {
            var cs = ConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
            var drivers = new List<drivers>();


            using (var con = new SqlConnection(cs))
            {
                var cmd = new SqlCommand("getdriver", con)

                {
                    CommandType = CommandType.StoredProcedure
                };

                con.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var driver = new drivers
                    {
                        dr_fname = dr[0].ToString(),
                        dr_lname = dr[1].ToString(),
                        dr_email = dr[2].ToString(),
                        dr_phone = dr[3].ToString(),
                        dr_lic = dr[4].ToString(),
                        dr_nic = dr[5].ToString(),
                        dr_address = dr[6].ToString(),
                        dr_date = dr[7].ToString(),
                        dr_id = dr[8].ToString()
                    };
                    drivers.Add(driver);
                }
            }
            var js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(drivers));
        }
    }
}

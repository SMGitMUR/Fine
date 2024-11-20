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
    /// Summary description for viewpolicews
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class viewpolicews : System.Web.Services.WebService
    {

        [WebMethod]
        public void GetUsers()
        {
            var cs = ConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
            var users = new List<police>();


            using (var con = new SqlConnection(cs))
            {
                var cmd = new SqlCommand("getpolice", con)

                {
                    CommandType = CommandType.StoredProcedure
                };

                con.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var user = new police
                    {

                        po_fname = dr[0].ToString(),
                        po_lname = dr[1].ToString(),
                        po_email = dr[2].ToString(),
                        po_phone = dr[3].ToString(),
                        po_num = dr[4].ToString(),
                        po_nic = dr[5].ToString(),
                        po_id = dr[6].ToString()
                    };
                    users.Add(user);
                }
            }
            var js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(users));
        }
    }
}

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
    /// Summary description for viewdroffasmx
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class viewdroffasmx : System.Web.Services.WebService
    {

        [WebMethod]
        public void GetUsers(string drId)
        {
            var cs = ConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
            var users = new List<user>();


            using (var con = new SqlConnection(cs))
            {
                var cmd = new SqlCommand("getdroff", con)

                {
                    CommandType = CommandType.StoredProcedure
                };
                cmd.Parameters.AddWithValue("@drId", Convert.ToInt32(drId));
                con.Open();
                var dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    var driver = new user
                    {
                        vio_name = dr[0].ToString(),
                        vio_comment = dr[1].ToString(),
                        vio_date = dr[3].ToString(),
                        vio_id = dr[4].ToString(),
                        vio_point = dr[2].ToString()
                    };
                    users.Add(driver);
                }
            }
            var js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(users));
        }
    }
}

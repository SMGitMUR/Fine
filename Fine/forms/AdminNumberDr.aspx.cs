using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using System.Security.Cryptography;


namespace Fine.forms
{
    public partial class AdminNumberDr : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        public static object labels;
        public static object values;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["uname"] == null)
                {
                    Response.Redirect("LoginAdmin.aspx");
                }
                GetInfo();
            }
        }
        private void GetInfo()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select  count(act_date) mCount, CONCAT(driver.dr_fname,' ',driver.dr_lname,' ,NIC: ',driver.dr_nic,' ,LIC: ',driver.dr_lic)driver from violation, driver, action where violation.dr_id = driver.dr_id and violation.vio_id = action.vio_id group by driver.dr_lname, driver.dr_fname, driver.dr_nic, driver.dr_lic";

            SqlDataReader reader;
            con.Open();
            reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    labels += "'" + reader["driver"].ToString() + "',";
                    values += reader["mCount"].ToString() + ",";
                }
            }
            else
            {
                Response.Clear();
                Response.StatusCode = 404;
                Response.End();
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }

        }
    }
}
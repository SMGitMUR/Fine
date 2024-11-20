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
    public partial class calendar : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        public static object outside;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                if (Session["dr_id"] == null)
                {
                    Response.Redirect("LoginDriver.aspx");
                }
                GetInfo(Session["dr_id"].ToString());
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("droff.aspx");
        }

        private void GetInfo(string id)
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select FORMAT(court_date, 'MM/dd/yyyy') as court from violation,action,driver where violation.vio_id = action.vio_id and  violation.dr_id = driver.dr_id and driver.dr_id = @driverId";
            cmd.Parameters.AddWithValue("@driverId", id);
            SqlDataReader reader;
            con.Open();
            reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    if(!reader["court"].ToString().Contains("1900-01-01"))
                        outside += "{ startDate: new Date('"+ reader["court"].ToString() + "'), endDate: new Date('"+ reader["court"].ToString() + "'), summary: 'Court Date' }, ";
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
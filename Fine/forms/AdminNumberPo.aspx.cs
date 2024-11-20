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
    public partial class AdminNumberPo : System.Web.UI.Page
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
            cmd.CommandText = "select  count(act_date) mCount, police.po_num from violation, police, action where violation.po_id = police.po_id and violation.vio_id = action.vio_id group by police.po_num ";

            SqlDataReader reader;
            con.Open();
            reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    labels += "'" + reader["po_num"].ToString() + "',";
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
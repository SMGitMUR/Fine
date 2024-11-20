using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fine.forms
{
    public partial class viewmsg : System.Web.UI.Page
    {
         private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uname"] == null)
            {
                Response.Redirect("LoginAdmin.aspx");
            }
            bind();
        }

       private void bind()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM tblcontactadmin order by ca_dateentry desc";
            SqlDataReader reader;
            con.Open();
            reader = cmd.ExecuteReader();
            repTraOff.DataSource = reader;
            repTraOff.DataBind();
            con.Close();
        }
    }
}
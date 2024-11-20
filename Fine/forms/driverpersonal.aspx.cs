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
    public partial class driverpersonal : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //int id = Convert.ToInt32(Request.QueryString["id"]);
                if (Session["dr_id"] == null)
                {
                    Response.Redirect("LoginDriver.aspx");
                }
                GetInfo(Session["dr_id"].ToString());
                
            }
        }

        private void GetInfo(string email)
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM driver WHERE dr_id = @dr_id";
            con.Open();
            cmd.Parameters.AddWithValue("@dr_id", email);
         

            SqlDataReader reader;
            reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    imgPP.ImageUrl = reader["dr_photo"].ToString();
                    txtfname.Text = reader["dr_fname"].ToString();
                    txtlname.Text = reader["dr_lname"].ToString();
                    txtemail.Text = reader["dr_email"].ToString();
                    GetLicense(reader["dr_email"].ToString());
                    txtphone.Text = reader["dr_phone"].ToString();
                    txtlic.Text = reader["dr_lic"].ToString();
                    txtNIC.Text = reader["dr_nic"].ToString();
                    txtadd.Text = reader["dr_address"].ToString();

                }
              
            }
            else
            {
                Response.Clear();
                Response.StatusCode = 404;
                Response.End();
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            con.Close();
        }
        private void GetLicense(string email)
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "SELECT * FROM driver_license WHERE driver_email = @email";
            con.Open();
            cmd.Parameters.AddWithValue("@email", email);
            SqlDataAdapter dad = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            //Fill the Dataset and ensure the DB Connection is closed  
            using (dad)//connection pooling, ensure connection is closed 
            {
                dad.Fill(ds);
            }
            repTraOff.DataSource = ds;
            repTraOff.DataBind();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Response.Redirect("UpdateDriver.aspx");
        }
    }
}
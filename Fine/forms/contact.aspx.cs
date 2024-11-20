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
    public partial class contact : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) 
            {
                SqlConnection con = new SqlConnection(_conString);
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                bool success = false;

                //search for username from tbluser
                // SqlCommand cmd12 =new SqlCommand("User_Name)values(@uname)", con);
                cmd.CommandText = "insert into tblcontactadmin values(@ca_name,@ca_email,@ca_subject,@ca_message,@ca_dateentry)";
                //create a parameterized query to prevent sql injection
                cmd.Parameters.AddWithValue("@ca_name", txtfirst.Text);
                cmd.Parameters.AddWithValue("@ca_email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@ca_subject", txtsubject.Text);
                cmd.Parameters.AddWithValue("@ca_message", txtCom.Text);
                cmd.Parameters.AddWithValue("@ca_dateentry", DateTime.Now);

                cmd.CommandType = CommandType.Text;
                con.Open();
                success = cmd.ExecuteNonQuery() > 0;

                if (success)
                {
                    lblactstatus.ForeColor = System.Drawing.Color.Green;
                    lblactstatus.Text = "Message Sent Successfully";

                }
                else
                {

                    lblactstatus.ForeColor = System.Drawing.Color.Red;
                    lblactstatus.Text = "Error Sending Message";

                }
            }
        }


        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtfirst.Text = "";
            txtEmail.Text = "";
            txtsubject.Text = "";
            txtCom.Text = "";
        }
    }
}
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
    public partial class policepersonal : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                if (Session["po_id"] != null)
                {
                    SqlConnection con = new SqlConnection(_conString);
                    // Create Command                 
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    //To replace the txtusername.Text by the session variable                 
                    cmd.CommandText = "SELECT * FROM police WHERE po_id = @po_id";
                    con.Open();
                    cmd.Parameters.AddWithValue("@po_id", Session["po_id"].ToString());
                    //Create DataReader                 
                    SqlDataReader reader;
                    reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        //retrieve the values using the reader[“fieldname”] and                     
                        //store in corresponding Session variable 

                        Session["pophoto"] = reader["po_photo"];
                        Session["pophone"] = reader["po_phone"];
                        Session["po_num"] = reader["po_num"];

                        Session["ponic"] = reader["po_nic"];
                        Session["poemail"] = reader["po_email"];
                        Session["polname"] = reader["po_lname"];
                        Session["pofname"] = reader["po_fname"];

                    }

                    //populating the textboxes with data from the Session variables                                      
                    imgPP.ImageUrl = Session["pophoto"].ToString();
                    txtphone.Text = Session["pophone"].ToString();
                    txtbadge.Text = Session["po_num"].ToString();
                    txtemail.Text = Session["poemail"].ToString();
                    txtlname.Text = Session["polname"].ToString();
                    txtfname.Text = Session["pofname"].ToString();
                    txtNIC.Text = Session["ponic"].ToString();

                    con.Close();
                }
                else
                    Response.Redirect("PoliceLogin.aspx");
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Response.Redirect("UpdatePolice.aspx");
        }
    }
}
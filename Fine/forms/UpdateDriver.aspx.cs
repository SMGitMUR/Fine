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
    public partial class UpdateDriver : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                if (Session["dr_id"] != null)
                {
                    SqlConnection con = new SqlConnection(_conString);
                    // Create Command                 
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    //To replace the txtusername.Text by the session variable                 
                    cmd.CommandText = "SELECT * FROM driver WHERE dr_id = @dr_id";
                    con.Open();
                    cmd.Parameters.AddWithValue("@dr_id", Session["dr_id"].ToString());
                    //Create DataReader                 
                    SqlDataReader reader;
                    reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        //retrieve the values using the reader[“fieldname”] and                     
                        //store in corresponding Session variable 

                        Session["drphoto"] = reader["dr_photo"];
                        Session["drphone"] = reader["dr_phone"];
                        Session["draddress"] = reader["dr_address"];
                        Session["dr_uname"] = reader["dr_uname"];

                    }

                    //populating the textboxes with data from the Session variables                                      
                    imgPP.ImageUrl = Session["drphoto"].ToString();
                    txtPnum.Text = Session["drphone"].ToString();
                    txtadd.Text = Session["draddress"].ToString();
                    con.Close();
                }
                else
                    Response.Redirect("LoginDriver.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string updateSQL;
                //To replace the txtusername.text by the session variable
                updateSQL = "UPDATE driver SET " +
                "dr_phone = @phone," +
                "dr_address = @address";
                //pn visible == trif
                if (pnlpass.Visible == true)
                {
                    updateSQL += " ,dr_pass= @password";
                }

                updateSQL += " WHERE dr_uname = @uname";//Add Session Variable Here

                Encryption encrypt = new Encryption();
                SqlConnection con = new SqlConnection(_conString);
                SqlCommand cmd = new SqlCommand(updateSQL, con);
                cmd.Parameters.AddWithValue("@uname", Session["dr_uname"].ToString());//Add Session Variable Here

                con.Open();

                // Add the parameters

                cmd.Parameters.AddWithValue("@phone", txtPnum.Text);


                cmd.Parameters.AddWithValue("@address", txtadd.Text);

                //pn visible == true
                if (pnlpass.Visible == true)
                {
                    cmd.Parameters.AddWithValue("@password", encrypt.Encrypt(R_compass.Text));
                }




                int updated = 0;
                //con.Open();
                updated = cmd.ExecuteNonQuery();
                if (updated == 1)
                {
                    lblactstatus.ForeColor = System.Drawing.Color.Green;
                    lblactstatus.Text = "Profile Details updated";

                }
                else
                {
                    lblactstatus.ForeColor = System.Drawing.Color.Red;
                    lblactstatus.Text = "Error updating";

                }

                con.Close();


            }

        }


        internal class Encryption
        {
            public Encryption()
            {

            }

            public string Encrypt(string clearText)
            {
                // defining encrytion key
                string EncryptionKey = "MAKV2SPBNI99212";
                byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        // encoding using key
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                        {
                            cs.Write(clearBytes, 0, clearBytes.Length);
                            cs.Close();
                        }
                        clearText = Convert.ToBase64String(ms.ToArray());
                    }
                }
                return clearText;
            }

            public string Decrypt(string cipherText)
            {
                // defining encrytion key
                string EncryptionKey = "MAKV2SPBNI99212";
                byte[] cipherBytes = Convert.FromBase64String(cipherText);
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        // decoding using key
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                        {
                            cs.Write(cipherBytes, 0, cipherBytes.Length);
                            cs.Close();
                        }
                        cipherText = Encoding.Unicode.GetString(ms.ToArray());
                    }
                }
                return cipherText;
            }
        }

        protected void btnreset_Click(object sender, EventArgs e)
        {
            pnlpass.Visible = true;
        }
    }
}
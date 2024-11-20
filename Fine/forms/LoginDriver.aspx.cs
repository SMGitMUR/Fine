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
    public partial class LoginDriver : System.Web.UI.Page
    {

        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        private static int count;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txtPassword.Attributes["type"] = "password";

                if (Request.Cookies["un"] != null && Request.Cookies["up"] != null)
                {
                    txtUsername.Text = Request.Cookies["un"].Value;
                    txtPassword.Attributes["value"] = Request.Cookies["up"].Value;
                }
            }
        }
        protected void btnlogin_Click(object sender, EventArgs e)
        {
            if (count >= 3)
            {
                SqlConnection con2 = new SqlConnection(_conString);
                SqlCommand cmd2 = new SqlCommand();
                cmd2.Connection = con2;
                cmd2.CommandText = "UPDATE driver set dr_status = 0 WHERE dr_uname=@uname";
                cmd2.Parameters.AddWithValue("@uname", txtUsername.Text);
                con2.Open();
                try
                {
                    cmd2.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    lblactstatus.ForeColor = System.Drawing.Color.Red;
                    lblactstatus.Text = "Email not valid";
                    count = 0;
                    return;
                }
                
                con2.Close();

                lblactstatus.ForeColor = System.Drawing.Color.Red;
                lblactstatus.Text = "Account block";

            }
            else
            {
                encryption decrypt = new encryption();

                SqlConnection con = new SqlConnection(_conString);
                // Create Command        

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                //searching for a record containing matching username, password and  status         
                cmd.CommandText = "select * from driver where dr_uname=@uname and dr_pass=@pass and dr_status=@status";
                //create three parameterized query for the above select statement 
                cmd.Parameters.AddWithValue("@uname", txtUsername.Text);
                cmd.Parameters.AddWithValue("@pass", decrypt.Encrypt(txtPassword.Text));
                cmd.Parameters.AddWithValue("@status", 1);
                //Create DataReader         
                SqlDataReader reader;
                con.Open();
                reader = cmd.ExecuteReader();
                Response.Write(decrypt.Encrypt(txtPassword.Text));
                // check if username, password and status in reader exists in DB         
                if (reader.HasRows)
                {
                    if (reader.Read())
                    {
                        //create and save username in a session variable 
                        Session["uname"] = txtUsername.Text;
                        Session["dr_id"] = reader["dr_id"]; // use job line 67
                        Session["dr_email"] = reader["dr_email"];

                        Response.Cookies["up"].Value = txtPassword.Text;
                        Response.Cookies["un"].Value = txtUsername.Text;
                        if (CheckBox1.Checked)
                        {

                            Response.Cookies["un"].Expires = DateTime.Now.AddDays(100);

                            Response.Cookies["up"].Expires = DateTime.Now.AddDays(100);
                        }
                        else
                        {
                            Response.Cookies["un"].Expires = DateTime.Now.AddDays(-100);
                            Response.Cookies["up"].Expires = DateTime.Now.AddDays(-100);
                        }

                    }
                    count = 0;
                    con.Close();
                    Response.Redirect("driverpersonal.aspx");
                }
                else
                {
                    count = count + 1;
                    lblactstatus.ForeColor = System.Drawing.Color.Red;
                    lblactstatus.Text = "Wrong Credentials, Try again - " + count.ToString();
                }
            }
           
        }



        internal class encryption
        {
            public encryption()
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

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtUsername.Text = "";
            txtPassword.Text = "";
            CheckBox1.Checked = false;
        }
    }
}
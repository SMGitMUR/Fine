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
    public partial class LoginAdmin : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
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
            encryption decrypt = new encryption();

            SqlConnection con = new SqlConnection(_conString);
            // Create Command        

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            //searching for a record containing matching username, password and  status         
            cmd.CommandText = "select * from admin where ad_uname=@uname and ad_pass=@pass";
            //create three parameterized query for the above select statement 
            cmd.Parameters.AddWithValue("@uname", txtUsername.Text);
            cmd.Parameters.AddWithValue("@pass", decrypt.Encrypt(txtPassword.Text));
            //cmd.Parameters.AddWithValue("@status", "Active");
            //Create DataReader         
            SqlDataReader reader;
            con.Open();
            reader = cmd.ExecuteReader();

            // check if username, password and status in reader exists in DB         
            if (reader.HasRows)
            {
                if (reader.Read())
                {
                    //create and save username in a session variable 
                    Session["uname"] = txtUsername.Text;


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
                Response.Redirect("viewdriver.aspx");

                con.Close();
            }
            else
            {

                lblactstatus.ForeColor = System.Drawing.Color.Red;
                lblactstatus.Text = "Wrong Credentials, You are not authorise to access this system!";
                
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
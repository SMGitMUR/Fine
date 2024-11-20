using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fine.forms
{
    public partial class ResetDriver : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnreset_Click(object sender, EventArgs e)
        {
            

                SqlConnection con = new SqlConnection(_conString);
                // Create Command        

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                //searching for a record containing matching username, password and  status         
                cmd.CommandText = "select * from driver where dr_email=@email and dr_uname=@username";
                //create three parameterized query for the above select statement 
                cmd.Parameters.AddWithValue("@email", txbfemail.Text);
                cmd.Parameters.AddWithValue("@username", txtuser.Text);
                //Create DataReader         
                SqlDataReader reader;
                con.Open();
                reader = cmd.ExecuteReader();

                // check if username, password and status in reader exists in DB         
                if (reader.HasRows)
                {
                    if (SendEmail(txbfemail.Text))
                    {
                        pnlemail.Visible = false;
                        pnlpass.Visible = true;
                        lblmessage.Text = txtuser.Text;
                    }
                    else
                        lblerror.Text = "Failed to send Email";
                    lblerror.ForeColor = System.Drawing.Color.Red;
                    con.Close();
                }
                else
                {
                    lblerror.Text = "No Valid Email";
                    lblerror.ForeColor = System.Drawing.Color.Red;

                }
            
        }

        protected void btnsave_Click(object sender, EventArgs e)
        {
            
                SqlConnection con = new SqlConnection(_conString);
                // Create Command        

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
            //searching for a record containing matching username, password and  status         
                cmd.CommandText = "select * from ForgetCode where Email=@email and Code = @code and Date < '" + DateTime.Now+"'";
                //create three parameterized query for the above select statement 
                cmd.Parameters.AddWithValue("@email", txbfemail.Text);
                cmd.Parameters.AddWithValue("@code", txbactkey.Text);
                //Create DataReader         
                SqlDataReader reader;
                con.Open();
                reader = cmd.ExecuteReader();

                // check if username, password and status in reader exists in DB         
                if (reader.HasRows)
                {

                    if (!SaveNewPass())
                        lblactstatus.Text = "Failed to saved new password!!";
                    else
                        lblactstatus.Text = "password updated";
                    lblactstatus.ForeColor = System.Drawing.Color.Green;
                    con.Close();
                }
                else
                {
                    lblactstatus.Text = "code not found!!";
                    lblactstatus.ForeColor = System.Drawing.Color.Red;

                }
            
               
        }

        private bool SendEmail(string email)
        {
           bool validInsert = false;
            SqlConnection con2 = new SqlConnection(_conString);
            SqlCommand cmd2 = new SqlCommand();
            cmd2.Connection = con2; 
            cmd2.CommandText = "Insert into [ForgetCode] values (@code, @email, @Date)";
            con2.Open();
            Random generator = new Random();
            string ran = generator.Next(0, 1000000).ToString("D6");
            cmd2.Parameters.AddWithValue("@code", ran);
            cmd2.Parameters.AddWithValue("@email", email);
            cmd2.Parameters.AddWithValue("@Date", DateTime.Now.AddMinutes(10));

            validInsert = cmd2.ExecuteNonQuery() > 0;
            if (!validInsert) {
                return false;
            }
            con2.Close();
            try
            {
                sendcode(ran);
            }
            catch
            {
                return false;
            }
            return true;
        }
        private void sendcode(string actkey)
        {
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.Credentials = new System.Net.NetworkCredential("offencetraffic1234@gmail.com", "offencetraffic123456");
            smtp.EnableSsl = true;
            MailMessage msg = new MailMessage();
            msg.Subject = "Activation Code to change your PASSWORD";
            msg.Body = "Dear " + txbfemail.Text + ",\n This is Your Activation Key : " + actkey + " \n\n\n Thanks";
            string toaddress = txbfemail.Text;
            msg.To.Add(toaddress);
            string fromaddress = "offencetraffic1234@gmail.com";
            msg.From = new MailAddress(fromaddress);
            try
            {
                smtp.Send(msg);
            }
            catch
            {
                throw;
            }

        }
        private bool SaveNewPass()
        {
            bool validInsert = false;
            encryption ecrypt = new encryption();
            SqlConnection con2 = new SqlConnection(_conString);
            SqlCommand cmd2 = new SqlCommand();
            cmd2.Connection = con2;
            cmd2.CommandText = "UPDATE driver SET dr_pass = @pwd WHERE dr_email = @email and dr_uname=@username";
            cmd2.Parameters.AddWithValue("@pwd", ecrypt.Encrypt(txbfcpass.Text));
            cmd2.Parameters.AddWithValue("@email", txbfemail.Text);
            cmd2.Parameters.AddWithValue("@username", txtuser.Text);
            con2.Open();
            validInsert = cmd2.ExecuteNonQuery() > 0;
            if (!validInsert)
            {
                return false;
            }
            con2.Close();
            return true;
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

    }
}
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
using System.Net.Mail;

namespace Fine.forms
{
    public partial class PoliceRegistration : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["uname"] == null)
                {
                    Response.Redirect("LoginAdmin.aspx");
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (FileUpload2.HasFile)
                {
                    if (CheckFileType(FileUpload2.FileName))
                    {


                        String filen = Path.GetFileName(FileUpload2.PostedFile.FileName);
                        FileUpload2.PostedFile.SaveAs(Server.MapPath("~/profilepo/") + filen);

                        Encryption encrypt = new Encryption();
                        // Create Connection
                        SqlConnection con = new SqlConnection(_conString);
                        // Create Command
                        SqlCommand cmd = new SqlCommand();
                        cmd.Connection = con;
                        //search for username from tbluser
                        // SqlCommand cmd12 =new SqlCommand("User_Name)values(@uname)", con);
                        cmd.CommandText = "select * from police where po_num = @ponum OR po_email = @pomail OR po_nic = @ponic";
                        //create a parameterized query to prevent sql injection
                        cmd.Parameters.AddWithValue("@ponum", txtNum.Text);
                        cmd.Parameters.AddWithValue("@pomail", txtEmail.Text);
                        cmd.Parameters.AddWithValue("@ponic", txtNIC.Text);
                        // Create Command
                        SqlCommand cmd1 = new SqlCommand();
                        cmd1.Connection = con;
                        cmd1.CommandText = "INSERT INTO police(po_fname,po_lname,po_uname,po_pass,po_status,po_email,po_num,po_phone,po_nic,po_photo) VALUES (@First_Name,@Last_Name, @User_Name, @Password,@Status,@Email,@Number,@Contact_Number,@NIC,@Photo)";

                        //Create DataReader
                        SqlDataReader reader;
                        con.Open();
                        bool success = false;
                        reader = cmd.ExecuteReader();
                        //To check if the username already exists in the DB
                        if (reader.HasRows)
                        {
                            txtNum.Text = "Username Already Exist, Please ChooseAnother";
                            txtEmail.Text = "Email Already Exist, Please ChooseAnother";
                            txtNIC.Text = "NIC Already Exist, Please ChooseAnother";

                            txtNum.Focus();
                            txtEmail.Focus();
                            txtNIC.Focus();
                        }
                        else
                        {
                            //Ensure that the reader is closed
                            reader.Close();
                            cmd1.Parameters.AddWithValue("@First_Name", txtfirst.Text);
                            cmd1.Parameters.AddWithValue("@Last_Name", txtlast.Text);
                            cmd1.Parameters.AddWithValue("@User_Name", txtuser.Text);
                            cmd1.Parameters.AddWithValue("@Email", txtEmail.Text);
                            cmd1.Parameters.AddWithValue("@Password", encrypt.Encrypt(txtPass.Text));
                            cmd1.Parameters.AddWithValue("@Status", 1);
                            cmd1.Parameters.AddWithValue("@Contact_Number", txtPnum.Text);
                            cmd1.Parameters.AddWithValue("@Number", txtNum.Text);
                            cmd1.Parameters.AddWithValue("@NIC", txtNIC.Text);
                            cmd1.Parameters.AddWithValue("@Photo", "~/profilepo/" + filen);
                            cmd1.CommandType = CommandType.Text;

                            success = cmd1.ExecuteNonQuery() > 0;

                            if (success)
                            {

                                lblactstatus.ForeColor = System.Drawing.Color.Green;
                                lblactstatus.Text = "Details Registered.";

                            }
                            else
                            {

                                lblactstatus.ForeColor = System.Drawing.Color.Red;
                                lblactstatus.Text = "Error updating";

                            }
                            con.Close();


                            try
                            {
                                sendcode();
                            }
                            catch
                            {
                                throw;
                            }
                            //Response.Redirect("PoliceLogin.aspx?flag=true");

                        }
                    }
                }
            }

        }
        bool CheckFileType(string fileName)
        {
            string ext = Path.GetExtension(fileName);
            switch (ext.ToLower())
            {
                case ".png":
                    return true;
                case ".jpg":
                    return true;
                case ".jpeg":
                    return true;
                case ".pdf":
                    return true;
                default:
                    return false;
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

        private void reset()
        {
            txtfirst.Text = "";
            txtlast.Text = "";
            txtNIC.Text = "";
            txtuser.Text = "";
            txtEmail.Text = "";
            txtPnum.Text = "";
            txtNum.Text = "";
            txtPass.Text = "";
            txtPassWord.Text = "";
            FileUpload2.Attributes.Clear();
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            reset();

        }

        private void sendcode()
        {
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.Credentials = new System.Net.NetworkCredential("offencetraffic1234@gmail.com", "offencetraffic123456");
            smtp.EnableSsl = true;
            MailMessage msg = new MailMessage();
            msg.Subject = "Account Regristration";
            msg.Body = "Dear " + txtfirst.Text + ",\n Your account has been registered. Please use the following credentials to login Badge Number:  " + txtNum.Text + "  and password : " + txtPassWord.Text + " \n\n\n You are required to change your password after you have login for the first time.\n\n Thanks.";
            string toaddress = txtEmail.Text;
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
    }
}
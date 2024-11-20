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
using System.Globalization;



namespace Fine.forms
{
    public partial class DriverRegistration : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
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
                if (DateTime.Parse(txtDate.Text) > DateTime.Today)
                {
                    lbldate.ForeColor = System.Drawing.Color.Green;
                    lbldate.Text = "Date must not be greater, Please enter a valid date and recheck for your details";
                }
                else
                {
                    if (FileUpload2.HasFile)
                    {
                        if (CheckFileType(FileUpload2.FileName))
                        {
                            String filen = Path.GetFileName(FileUpload2.PostedFile.FileName);
                            FileUpload2.PostedFile.SaveAs(Server.MapPath("~/profiledr/") + filen);

                            Encryption encrypt = new Encryption();
                            // Create Connection
                            bool success = false;
                            SqlConnection con = new SqlConnection(_conString);
                            SqlConnection con2 = new SqlConnection(_conString);
                            // Create Command
                            SqlCommand cmd = new SqlCommand();
                            cmd.Connection = con;
                            //search for username from tbluser
                            // SqlCommand cmd12 =new SqlCommand("User_Name)values(@uname)", con);
                            cmd.CommandText = "select * from driver where dr_uname = @dr_uname  OR dr_email = @dremail OR dr_lic = @drlic OR dr_nic = @drnic";
                            //create a parameterized query to prevent sql injection
                            cmd.Parameters.AddWithValue("@dr_uname", txtuser.Text);
                            cmd.Parameters.AddWithValue("@dremail", txtEmail.Text);
                            cmd.Parameters.AddWithValue("@drlic", txtNum.Text);
                            cmd.Parameters.AddWithValue("@drnic", txtNIC.Text);
                            // Create Command
                            SqlCommand cmd1 = new SqlCommand();
                            cmd1.Connection = con;
                            cmd1.CommandText = "INSERT INTO driver(dr_fname,dr_lname,dr_uname,dr_pass,dr_status,dr_email,dr_lic,dr_phone,dr_nic,dr_photo,dr_date,dr_address,dr_comment) VALUES (@First_Name,@Last_Name, @User_Name, @Password,@Status,@Email,@Number,@Contact_Number,@NIC,@Photo,@Date,@Address,@Comment)";


                            //Create DataReader
                            SqlDataReader reader;
                            con.Open();
                            reader = cmd.ExecuteReader();
                            //To check if the username already exists in the DB
                            if (reader.HasRows)
                            {
                                txtuser.Text = "Username Already Exist, Please ChooseAnother";
                                txtEmail.Text = "Email Already Exist, Please ChooseAnother";
                                txtNum.Text = "License Number Already Exist, Please ChooseAnother";
                                txtNIC.Text = "NIC Already Exist, Please ChooseAnother";


                                txtuser.Focus();
                                txtEmail.Focus();
                                txtNum.Focus();
                                txtNIC.Focus();
                            }
                            else
                            {
                                //Ensure that the reader is closed
                                reader.Close();
                                string strDate = txtDate.Text;
                                DateTime dt = Convert.ToDateTime(strDate);
                                cmd1.Parameters.AddWithValue("@First_Name", txtfirst.Text);
                                cmd1.Parameters.AddWithValue("@Last_Name", txtlast.Text);
                                cmd1.Parameters.AddWithValue("@User_Name", txtuser.Text);
                                cmd1.Parameters.AddWithValue("@Email", txtEmail.Text);
                                cmd1.Parameters.AddWithValue("@Password", encrypt.Encrypt(txtPass.Text));
                                cmd1.Parameters.AddWithValue("@Status", 1);
                                cmd1.Parameters.AddWithValue("@Contact_Number", txtPnum.Text);
                                cmd1.Parameters.AddWithValue("@Number", txtNum.Text);
                                cmd1.Parameters.AddWithValue("@NIC", txtNIC.Text);
                                cmd1.Parameters.AddWithValue("@Photo", "~/profiledr/" + filen);
                                cmd1.Parameters.AddWithValue("@Date", dt);
                                cmd1.Parameters.AddWithValue("@Address", txtAdd.Text);
                                cmd1.Parameters.AddWithValue("@Comment", txtCom.Text);
                                cmd1.CommandType = CommandType.Text;

                                success = cmd1.ExecuteNonQuery() > 0;


                                if (success)
                                {
                                    con.Close();
                                    for (int i = 0; i < CheckBox1.Items.Count; i++)
                                    {

                                        if (CheckBox1.Items[i].Selected)
                                        {

                                            SqlCommand cmd2 = new SqlCommand();
                                            cmd2.Connection = con2; cmd2.CommandText = "Insert into [driver_license]values (@dirver_email, @d_type)";
                                            con2.Open();

                                            cmd2.Parameters.AddWithValue("@d_type", CheckBox1.Items[i].Value);
                                            cmd2.Parameters.AddWithValue("@dirver_email", txtEmail.Text);
                                            cmd2.ExecuteNonQuery();
                                            con2.Close();
                                        }
                                    }
                                    lblactstatus.ForeColor = System.Drawing.Color.Green;
                                    lblactstatus.Text = "Details Registered.";

                                    try
                                    {
                                        sendcode();
                                    }
                                    catch (Exception ex)
                                    {
                                        Response.Write(ex.Message);
                                    }
                                    //Response.Redirect("LoginDriver.aspx?flag=true");
                                }
                                else
                                {

                                    lblactstatus.ForeColor = System.Drawing.Color.Red;
                                    lblactstatus.Text = "Error updating";

                                }
                            }
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

        private void sendcode()
        {
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.Credentials = new System.Net.NetworkCredential("offencetraffic1234@gmail.com", "offencetraffic123456");
            smtp.EnableSsl = true;
            MailMessage msg = new MailMessage();
            msg.Subject = "Account Regristration";
            msg.Body = "Dear " + txtfirst.Text + ",\n Your account has been registered. Please use the following credentials to login username:  " + txtuser.Text + "  and password : " + txtPass.Text + " \n\n\n You are required to change your password after you have login for the first time \n\n\n  Thanks.";
            string toaddress = txtEmail.Text;
            msg.To.Add(toaddress);
            string fromaddress = "offencetraffic1234@gmail.com";
            msg.From = new MailAddress(fromaddress);
            try
            {
                smtp.Send(msg);
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
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
            txtuser.Text = "";
            txtEmail.Text = "";
            txtPass.Text = "";
            txtDate.Text = "";
            txtPnum.Text = "";
            txtNum.Text = "";
            txtNIC.Text = "";
            txtPassWord.Text = "";
            txtAdd.Text = "";
            txtCom.Text = "";
            FileUpload2.Attributes.Clear();
            CheckBox1.ClearSelection();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            reset();
        }

    }
}
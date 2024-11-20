using SelectPdf;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fine.forms
{
    public partial class PoliceAction : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["po_id"] != null)
                {
                    getInfo();
                }
                else
                {
                    
                    Response.Redirect("PoliceLogin.aspx"); 
                }
                    
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lbldate.Text = "";
                if (!string.IsNullOrEmpty(txtDate.Text) && DateTime.Parse(txtDate.Text) < DateTime.Today)
                {
                    lbldate.ForeColor = System.Drawing.Color.Green;
                    lbldate.Text = "Date must be greater, Please enter a valid court date and recheck for your details";

                    return;
                }
                SqlConnection con = new SqlConnection(_conString);
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                bool success = false;
                //search for username from tbluser
                // SqlCommand cmd12 =new SqlCommand("User_Name)values(@uname)", con);
                cmd.CommandText = "insert into action values(@act_name,@court_date,@act_status,@act_date,(select max(vio_id) from violation),@act_comment)";
                //create a parameterized query to prevent sql injection
                cmd.Parameters.AddWithValue("@act_name", ddlAction.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@court_date", txtDate.Text);
                cmd.Parameters.AddWithValue("@act_status", 1);
                cmd.Parameters.AddWithValue("@act_date", DateTime.Now);
                cmd.Parameters.AddWithValue("@act_comment", txtCom.Text);
                cmd.CommandType = CommandType.Text;
                con.Open();
                success = cmd.ExecuteNonQuery() > 0;

                if (success)
                {

                    lblactstatus.ForeColor = System.Drawing.Color.Green;
                    lblactstatus.Text = "Details Registered.";
                    con.Close();
                    SqlCommand cmd2 = new SqlCommand();
                    cmd2.Connection = con;
                    cmd2.CommandText = "select top 1 vio_id as Id, dr_email as Email from violation, driver where violation.dr_id = driver.dr_id order by vio_id DESC";
                    cmd2.CommandType = CommandType.Text;
                    SqlDataReader reader;
                    con.Open();
                    reader = cmd2.ExecuteReader();
                    int id = 0;
                    string email = "";
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            email = reader["Email"].ToString();
                            id = Convert.ToInt32(reader["Id"].ToString());

                            string link = "http://"+ HttpContext.Current.Request.Url.Authority.ToString() +"/forms/drivermail?id=" + id;
                            sendmail(link, email);
                        }
                    }
                }
                else
                {

                    lblactstatus.ForeColor = System.Drawing.Color.Red;
                    lblactstatus.Text = "Error updating";

                }
            }
          


        }
        public void sendmail(string link, string email)
        {
            HtmlToPdf converter = new HtmlToPdf();

            try
            {
                // create a new pdf document converting an url
                PdfDocument doc = converter.ConvertUrl(link);

                // create memory stream to save PDF
                MemoryStream pdfStream = new MemoryStream();

                // save pdf document into a MemoryStream
                doc.Save(pdfStream);

                // reset stream position
                pdfStream.Position = 0;

                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.Credentials = new System.Net.NetworkCredential("offencetraffic1234@gmail.com", "offencetraffic123456");
                smtp.EnableSsl = true;
                // create email message
                MailMessage message = new MailMessage();
                message.From = new MailAddress("offencetraffic1234@gmail.com");
                message.To.Add(new MailAddress(email));
                message.Subject = "Violation Details";
                message.Body = "Please login to view full details such as location details on map and total points.";
                message.Attachments.Add(new Attachment(pdfStream, "Document.pdf"));
                smtp.Send(message);


                // send email

                // close pdf document
                doc.Close();

                lblactstatus.Text = "Email sent";
            }
            catch (Exception ex)
            {
                lblactstatus.Text = "An error occurred: " + ex.Message;
            }
        }
      

        protected void ddlAction_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAction.SelectedValue == "Court")
                pnlCourtDate.Visible = true;
            else
                pnlCourtDate.Visible = false;
        }
        private void getInfo()
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select dr_nic, dr_lic, CONCAT(dr_fname,' ',dr_lname) fullname, cat_name, cat_price, cat_point from violation, " +
                "driver,dr_violation,category where vio_id = (select max(vio_id) from violation) and violation.dr_id = " +
                "driver.dr_id and drvio_id = (select max(vio_id) from violation) and category.cat_id = dr_violation.cat_id";
            SqlDataAdapter dad = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            //Fill the Dataset and ensure the DB Connection is closed  
            using (dad)//connection pooling, ensure connection is closed 
            {
                dad.Fill(ds);
            }
            repUser.DataSource = ds;
            repUser.DataBind();
        }
    }
}
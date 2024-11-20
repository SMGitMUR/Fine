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
    public partial class ReportViolation : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["po_id"] != null)
                {
                    getViolist();
                    getDriver();
                }
                else
                    Response.Redirect("PoliceLogin.aspx");
            }
        }
        private void getViolist()
        {         // Create Connection         

            //Create DataReader         
            SqlConnection con = new SqlConnection(_conString);         // Create Command        
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "SELECT cat_id, CONCAT(cat_name , ' Price: Rs', cat_price,' Points:', cat_point) as cat_desc  FROM category where cat_status='True'";
            //Create DataSet 
            SqlDataAdapter dad = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            //Fill the Dataset and ensure the DB Connection is closed  
            using (dad)//connection pooling, ensure connection is closed 
            {
                dad.Fill(ds);
            }

            //To load appropriate information in dropdown         
            CheckBoxList1.DataSource = ds;
            CheckBoxList1.DataTextField = "cat_desc";
            CheckBoxList1.DataValueField = "cat_id";
            CheckBoxList1.DataBind();
        }

        private void getDriver()
        {

            SqlConnection con = new SqlConnection(_conString);         // Create Command        
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "SELECT dr_id,dr_fname,dr_lname,dr_nic,dr_lic ,concat(dr_fname,' ',dr_lname,' | ',dr_nic,' | ',dr_lic) fullname FROM driver";   //Create DataReader         

            //Create DataSet 
            SqlDataAdapter dad = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            //Fill the Dataset and ensure the DB Connection is closed  
            using (dad)//connection pooling, ensure connection is closed 
            {
                dad.Fill(ds);
            }


            //To load appropriate information in dropdown         
            lbcus.DataSource = ds;
            lbcus.DataTextField = "fullname";
            lbcus.DataValueField = "dr_id";
            lbcus.DataBind();
        }



        protected void btnselcus_Click(object sender, EventArgs e)
        {
            pnlselcus.Visible = true;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                bool ifCheckbox = false;
                for (int i = 0; i < CheckBoxList1.Items.Count; i++)
                {
                    if (CheckBoxList1.Items[i].Selected)
                    {
                        ifCheckbox = true;
                    }

                }
                if (!ifCheckbox)
                {
                    Label1.ForeColor = System.Drawing.Color.Red;
                    Label1.Text = "Please Select An Offence";
                    return;
                }
                // Response.Redirect(Session["po_id"].ToString());
                SqlConnection con = new SqlConnection(_conString);
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                bool success = false;
                bool success2 = false;

                string pr = lblTPrice.Text;


                string[] price = pr.Split(' ');


                //search for username from tbluser
                // SqlCommand cmd12 =new SqlCommand("User_Name)values(@uname)", con);
                cmd.CommandText = "insert into violation values(@vio_name,@vio_status,@vio_date,@vio_lat,@vio_long,@po_id,@vio_cmt,@d_id,@d_price,@d_point)";
                //create a parameterized query to prevent sql injection
                cmd.Parameters.AddWithValue("@vio_name", txtvio.Text);
                cmd.Parameters.AddWithValue("@vio_status", 1);
                cmd.Parameters.AddWithValue("@vio_date", DateTime.Now);
                cmd.Parameters.AddWithValue("@vio_lat", hfLat.Value);
                cmd.Parameters.AddWithValue("@vio_long", hfLong.Value);
                cmd.Parameters.AddWithValue("@po_id", Session["po_id"].ToString());
                cmd.Parameters.AddWithValue("@vio_cmt", txtCom.Text);
                cmd.Parameters.AddWithValue("@d_id", lbcus.SelectedValue);
                cmd.Parameters.AddWithValue("@d_price", price[1]);
                cmd.Parameters.AddWithValue("@d_point", txtPoint.Text);
                cmd.CommandType = CommandType.Text;
                con.Open();
                success = cmd.ExecuteNonQuery() > 0;

                if (success)
                {
                    for (int i = 0; i < CheckBoxList1.Items.Count; i++)
                    {
                        if (CheckBoxList1.Items[i].Selected)
                        {
                            SqlConnection con2 = new SqlConnection(_conString);
                            SqlCommand cmd2 = new SqlCommand();
                            cmd2.Connection = con2;
                            cmd2.CommandType = CommandType.Text;
                            cmd2.CommandText = "insert into dr_violation values((select max(vio_id) from violation),@cat_id)";
                            cmd2.Parameters.AddWithValue("@cat_id", CheckBoxList1.Items[i].Value);
                            con2.Open();
                            success2 = cmd2.ExecuteNonQuery() > 0;
                            con2.Close();
                        }

                    }
                }
                if (success2)
                {
                    SqlConnection con3 = new SqlConnection(_conString);
                    SqlCommand cmd3 = new SqlCommand();
                    cmd3.Connection = con3;
                    bool success3 = false;
                    cmd3.CommandType = CommandType.Text;
                    cmd3.CommandText = "select sum(convert (int, substring(vio_point, CHARINDEX(':',vio_point)+1, LEN(vio_point)))) point from violation, driver where driver.dr_id = violation.dr_id and driver.dr_id = @DriverID";
                    cmd3.Parameters.AddWithValue("@DriverID", lbcus.SelectedValue);
                    SqlDataReader reader3;
                    con3.Open();
                    reader3 = cmd3.ExecuteReader();
                    int allPoints = 0;
                    if (reader3.HasRows)
                    {
                        while (reader3.Read())
                        {
                            allPoints += Convert.ToInt32(reader3["point"].ToString());
                        }

                    }
                    if (allPoints >= 100)
                    {

                        SqlConnection con4 = new SqlConnection(_conString);
                        SqlCommand cmd4 = new SqlCommand();
                        cmd4.Connection = con4;
                        cmd4.CommandText = "insert into action values(@act_name,@court_date,@act_status,@act_date,(select max(vio_id) from violation),@act_comment)";
                        //create a parameterized query to prevent sql injection
                        cmd4.Parameters.AddWithValue("@act_name", " Court And Pay Fine");
                        cmd4.Parameters.AddWithValue("@court_date", DateTime.Today.AddDays(10));
                        cmd4.Parameters.AddWithValue("@act_status", 1);
                        cmd4.Parameters.AddWithValue("@act_date", DateTime.Now);
                        cmd4.Parameters.AddWithValue("@act_comment", "court");
                        cmd4.CommandType = CommandType.Text;
                        con4.Open();
                        success3 = cmd4.ExecuteNonQuery() > 0;

                        if (success3)
                        {
                            con4.Close();
                            SqlConnection con5 = new SqlConnection(_conString);
                            SqlCommand cmd5 = new SqlCommand();
                            cmd5.Connection = con5;
                            cmd5.CommandText = "select top 1 vio_id as Id, dr_email as Email, CONCAT(dr_fname,' ',dr_lname) name from violation, driver where violation.dr_id = driver.dr_id order by vio_id DESC";
                            cmd5.CommandType = CommandType.Text;
                            SqlDataReader reader;
                            con5.Open();
                            reader = cmd5.ExecuteReader();

                            string email = "";
                            if (reader.HasRows)
                            {
                                while (reader.Read())
                                {
                                    email = reader["Email"].ToString();
                                    sendmail(email, DateTime.Today.AddDays(10), reader["name"].ToString());
                                }
                            }
                        }
                        else
                        {

                            lblactstatus.ForeColor = System.Drawing.Color.Red;
                            lblactstatus.Text = "Error Sending Mail";

                        }
                    }
                }

                Response.Redirect("PoliceAction");

            }
            else
            {
                Response.Write("ronbhbhgh");
            }
        }

        public void sendmail(string email, DateTime date, string name)
        {

            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.Credentials = new System.Net.NetworkCredential("offencetraffic1234@gmail.com", "offencetraffic123456");
            smtp.EnableSsl = true;
            MailMessage msg = new MailMessage();
            msg.Subject = "Court Date";
            msg.Body = "Hi "+ name + ",\n Please note that since your violation points are exceeding more than 100 points you are required to go to court on " + date.ToLongDateString()+" login to check futher more details.  ";
            string toaddress = (email);
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


        protected void btnCancel_Click(object sender, EventArgs e)
        {
            txtvio.Text = "";
            txtCom.Text = "";
            CheckBoxList1.ClearSelection();
        }
        protected void lbcus_SelectedIndexChanged(object sender, EventArgs e)
        {
            cusName.Text = "You selected: " + lbcus.SelectedItem.Text;
        }

        protected void CheckBoxList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int TOTAL_POINT = 0;
            int TOTAL_PRICE = 0;
            for (int i = 0; i < CheckBoxList1.Items.Count; i++)
            {
                if (CheckBoxList1.Items[i].Selected)
                {
                    SqlConnection con = new SqlConnection(_conString);
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "SELECT cat_price, cat_point FROM category WHERE cat_id = @cat_id";
                    cmd.Parameters.AddWithValue("@cat_id", CheckBoxList1.Items[i].Value);
                    SqlDataReader reader;
                    con.Open();
                    reader = cmd.ExecuteReader();
                    reader.Read();
                    TOTAL_PRICE += Convert.ToInt32(reader["cat_price"].ToString());
                    TOTAL_POINT += Convert.ToInt32(reader["cat_point"].ToString());
                    con.Close();
                }
            }
            lblTPrice.Text = "Price: " + TOTAL_PRICE.ToString();
            txtPoint.Text = "Point: " + TOTAL_POINT.ToString();
        }
    }
}
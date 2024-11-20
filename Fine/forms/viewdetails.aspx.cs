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
    public partial class viewdetails : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
  
                if (Session["uname"] == null || id == 0)
                {
                    Response.Redirect("LoginDriver.aspx");
                }
                GetInfo(id);
            }
        }
        private void GetInfo(int id)
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select dr_id, vio_name, vio_date, vio_lat, vio_long, vio_comment, po_num, vio_price, vio_point, act_name, court_date, act_id, act_comment " +
                "from violation, police, action, dr_violation where violation.vio_id = @vioId and violation.po_id = police.po_id" +
                " and violation.vio_id = action.vio_id and drvio_id = violation.vio_id";
            cmd.Parameters.AddWithValue("@vioId", id);
            SqlDataReader reader;
            con.Open();
            reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    txtDate.Text = Convert.ToDateTime(reader["vio_date"].ToString()).ToLongDateString();
                    txtvio.Text = reader["vio_name"].ToString();
                    txtDRID.Text = reader["dr_id"].ToString();
                    hfLat.Value = reader["vio_lat"].ToString();
                    hfLong.Value = reader["vio_long"].ToString();

                    txtCom.Text = reader["vio_comment"].ToString();
                    txtofficer.Text = reader["po_num"].ToString();

                    txtTotal.Text = reader["vio_price"].ToString();
                    myHiddenAmount.Value = reader["vio_price"].ToString();
                    txtPoint.Text = reader["vio_point"].ToString();
                    txtactcmt.Text = reader["act_comment"].ToString();
                    txtID.Text = reader["act_id"].ToString();
                    myHiddenId.Value = reader["act_id"].ToString();
                    txtact.Text = reader["act_name"].ToString();

                    if (reader["act_name"].ToString().Contains("Court"))
                    {
                        pnlCourtDate.Visible = true;
                        txtcourt.Text = Convert.ToDateTime(reader["court_date"].ToString()).ToShortDateString();
                    }

                    SqlConnection con2 = new SqlConnection(_conString);
                    SqlCommand cmd2 = new SqlCommand();
                    cmd2.Connection = con2;
                    cmd2.CommandType = CommandType.Text;
                    cmd2.CommandText = "select pay_method, pay_date, pay_amount from payment where act_id in (select act_id from action where vio_id in (select violation.vio_id from violation where dr_id = @driverId)) and act_id = @actId ";
                    //select * from payment where act_id in (select act_id from action 
                    //where vio_id in (select violation.vio_id from violation where dr_id = @driverId)) and act_id = @actId 
                    //if (reader.HasRows) Payment made else no payment
                    cmd2.Parameters.AddWithValue("@actId", txtID.Text);
                    cmd2.Parameters.AddWithValue("@driverId", txtDRID.Text);
                    SqlDataReader reader2;
                    con2.Open();
                    reader2 = cmd2.ExecuteReader();
                    if (reader2.HasRows)
                    {

                        while (reader2.Read())
                        {
                            paypanel.Visible = true;
                            Paypal.Visible = false;
                            txtmethod.Text = reader2["pay_method"].ToString();
                            txtpaydate.Text = reader2["pay_date"].ToString();
                            txtpaid.Text = "USD" + reader2["pay_amount"].ToString();


                            lblactstatus.ForeColor = System.Drawing.Color.Green;
                            lblactstatus.Text = "Paid";
                        }

                    }
                    else
                    {
                        Paypal.Visible = true;
                        lblactstatus.ForeColor = System.Drawing.Color.Red;
                        lblactstatus.Text = "Not Paid Yet";
                    }


                }
                GetOffence(id);
            }
            else
            {
                Response.Clear();
                Response.StatusCode = 404;
                Response.End();
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }

        }



        private void GetOffence(int id)
        {
            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select cat_name, cat_price, cat_point from dr_violation,category where dr_violation.drvio_id = @vioId and " +
                "dr_violation.cat_id = category.cat_id";
            cmd.Parameters.AddWithValue("@vioId", id);
            SqlDataAdapter dad = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            //Fill the Dataset and ensure the DB Connection is closed  
            using (dad)//connection pooling, ensure connection is closed 
            {
                dad.Fill(ds);
            }
            repTraOff.DataSource = ds;
            repTraOff.DataBind();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("droff.aspx");
        }
    }
}
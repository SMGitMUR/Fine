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
    public partial class drivermail : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                if (id == 0)
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
            cmd.CommandText = "select dr_nic, dr_lic, CONCAT(dr_fname,' ',dr_lname) fullname, vio_name, vio_date, vio_comment, po_num, vio_price, vio_point, act_name, act_comment, court_date " +
                "from violation, police, action, dr_violation, driver where violation.vio_id = @vioId and violation.po_id = police.po_id and " +
                "violation.vio_id = action.vio_id and drvio_id = violation.vio_id and violation.dr_id = driver.dr_id";
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
                    lblFname.Text = reader["fullname"].ToString();
                    lblLic.Text = reader["dr_lic"].ToString();
                    lblNic.Text = reader["dr_nic"].ToString();

                    txtCom.Text = reader["vio_comment"].ToString();
                    txtofficer.Text = reader["po_num"].ToString();

                    txtTotal.Text = reader["vio_price"].ToString();
                    txtPoint.Text = reader["vio_point"].ToString();
                    txtactcmt.Text = reader["act_comment"].ToString();
                    txtact.Text = reader["act_name"].ToString();
                    if (reader["act_name"].ToString().Contains("Court"))
                    {
                        pnlCourtDate.Visible = true;
                        txtcourt.Text = Convert.ToDateTime(reader["court_date"].ToString()).ToShortDateString();
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



    }
}
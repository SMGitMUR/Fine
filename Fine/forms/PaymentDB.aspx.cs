using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fine.forms
{
    public partial class PaymentDB : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            String date = Request.QueryString["date"];
            DateTime oDate = Convert.ToDateTime(date);

            SqlConnection con = new SqlConnection(_conString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = "insert into payment values(@pay_method,@pay_status,@pay_date,@act_id,@pay_amount)";
            cmd.Parameters.AddWithValue("@pay_method", "Paypal");
            cmd.Parameters.AddWithValue("@pay_status", 1);
            cmd.Parameters.AddWithValue("@pay_date", oDate);
            cmd.Parameters.AddWithValue("@act_id", Convert.ToInt32(Request.QueryString["actionid"]));
            cmd.Parameters.AddWithValue("@pay_amount", Request.QueryString["amount"]);
            cmd.CommandType = CommandType.Text;
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}
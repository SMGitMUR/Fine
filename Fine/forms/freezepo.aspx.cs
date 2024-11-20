using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Configuration;
using System.Data.SqlClient;

namespace Fine.forms
{
    public partial class freezepo : System.Web.UI.Page
    {
        private string _conString = WebConfigurationManager.ConnectionStrings["fineCS"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["uname"] == null)
            {
                Response.Redirect("LoginAdmin.aspx");
            }

            if (!Page.IsPostBack)
            {
                BindJobseekerData();

            }
        }
        private void BindJobseekerData()
        {
            string commandText = "SELECT * FROM police";
            SqlDataAdapter dad = new SqlDataAdapter(commandText, _conString);
            //Create a DataTable 
            DataTable dt = new DataTable();//1table
                                           // DataSet ds = new DataSet();//many table
            using (dad)
            {
                //Populate the DataAdapter with the DataTable  
                dad.Fill(dt);
            }
            //Set the DataTable as the DataSource         
            gvCatNames.DataSource = dt;
            gvCatNames.DataBind();
        }


        protected void gvCatNames_SelectedIndexChanged(object sender, EventArgs e)
        {

            txtjsId.Text = (gvCatNames.DataKeys[gvCatNames.SelectedIndex].Value.ToString());
            txtstatus.Text = ((Label)gvCatNames.SelectedRow.FindControl("lblCatName4")).Text;
            txtnum.Text = ((Label)gvCatNames.SelectedRow.FindControl("lblCatName5")).Text;
            txtfname.Text = ((Label)gvCatNames.SelectedRow.FindControl("lblCatName")).Text;
            txtlname.Text = ((Label)gvCatNames.SelectedRow.FindControl("lblCatName2")).Text;
            txtnic.Text =  ((Label)gvCatNames.SelectedRow.FindControl("lblCatName6")).Text;
           

        }
        private void ResetAll()
        {

            txtjsId.Text = "";
            txtstatus.Text = "";
            txtnum.Text = "";
            txtfname.Text = "";
            txtlname.Text = "";
            txtnic.Text = "";
          
        }

        protected void btnBlock_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (string.IsNullOrWhiteSpace(txtjsId.Text))
                {
                    lblMsg.Text = "Please select record to update";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                Boolean IsUpdated = false;
                int CatID = Convert.ToInt32(txtjsId.Text);
                //Add built-in function to remove spaces from Textbox Category name         
                String CatName = txtstatus.Text.Trim();

                SqlConnection sqlcon = new SqlConnection(_conString);

                SqlCommand cmd = new SqlCommand();
                //Add UPDATE statement to update category name for the above CatID         
                cmd.CommandText = "update police set po_status = @sta where po_id = @jid";
                //Create two parameterized queries [CatID and CatName]    
                cmd.Parameters.AddWithValue("@sta", CatName);
                cmd.Parameters.AddWithValue("@jid", CatID);
                cmd.Connection = sqlcon;
                sqlcon.Open();
                //use Command method to execute UPDATE statement and return  
                //boolean if number of records UPDATED is greater than zero         
                IsUpdated = cmd.ExecuteNonQuery() > 0;
                sqlcon.Close();

                if (IsUpdated)
                {
                    lblMsg.Text = CatName + " Officer Status updated successfully!";
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    BindJobseekerData();
                }
                else
                {
                    lblMsg.Text = "Error while updating " + CatName + " Status";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
                //Ensure that no rows are selected in Gridview by changing the EditIndex    
                //Refresh the GridView by calling the BindCategoryData()         
                ResetAll();
            }
               
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ResetAll();
        }
    }
}
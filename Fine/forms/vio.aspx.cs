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
    public partial class vio : System.Web.UI.Page
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
                BindCategoryData();

            }

        }
        private void BindCategoryData()
        {
            string commandText = "SELECT cat_id,cat_name,cat_price,cat_point FROM category where cat_status = 'True' ORDER BY cat_name";
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
            dlcat.DataSource = dt;
            dlcat.DataBind();
        }

        protected void lnkbtndelete_Click(object sender, EventArgs e)
        {
            DataListItem item = (sender as LinkButton).Parent as DataListItem;
            Session["catid"] = ((Label)item.FindControl("lblcatid")).Text;
            pmpdelete.Show();
        }

        protected void lnkbtnedit_Click(object sender, EventArgs e)
        {
            DataListItem item = (sender as LinkButton).Parent as DataListItem;
            txtcatname.Text = ((Label)item.FindControl("lblcatname")).Text;
            txtupprice.Text = ((Label)item.FindControl("lblCatPrice")).Text;
            Session["catid"] = ((Label)item.FindControl("lblcatid")).Text;
            Session["catname"] = ((Label)item.FindControl("lblcatname")).Text;
            Session["catprice"] = ((Label)item.FindControl("lblCatPrice")).Text;
            Session["catpoint"] = ((Label)item.FindControl("lblCatPoint")).Text;

            pmpedit.Show();
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            Boolean IsUpdated = false;

            int CatID = Convert.ToInt32(Session["catid"].ToString());
            String CatName = txtcatname.Text.Trim();

            SqlConnection con1 = new SqlConnection(_conString);                 // Create Command                 
            SqlCommand cmd2 = new SqlCommand();
            cmd2.Connection = con1;                 //search for username from tbluser   '--;               
            cmd2.CommandText = "select count(*) rownum from [category] where cat_name = @cidd and cat_status = 'True'";
            //create a parameterized query to prevent sql injection
            cmd2.Parameters.AddWithValue("@cidd", CatName);
            SqlDataReader reader;
            con1.Open();
            reader = cmd2.ExecuteReader();
            //To check if the email already exists in the DB 
            reader.Read();
            int rownum = Convert.ToInt32(reader["rownum"].ToString());
            if (rownum == 1 || rownum == 0)
            {
                SqlConnection sqlcon = new SqlConnection(_conString);

                SqlCommand cmd = new SqlCommand();
                //Add UPDATE statement to update category name for the above CatID         
                cmd.CommandText = "   update category set cat_name = @cname, cat_price = @cprice, cat_point = @cpoint where cat_id = @cid";
                //Create two parameterized queries [CatID and CatName]    
                cmd.Parameters.AddWithValue("@cname", CatName);
                cmd.Parameters.AddWithValue("@cid", CatID);
                cmd.Parameters.AddWithValue("@cprice", txtupprice.Text.Trim());
                cmd.Parameters.AddWithValue("@cpoint", txtuppoint.Text.Trim());
                cmd.Connection = sqlcon;
                sqlcon.Open();
                //use Command method to execute UPDATE statement and return  
                //boolean if number of records UPDATED is greater than zero         
                IsUpdated = cmd.ExecuteNonQuery() > 0;
                sqlcon.Close();

                if (IsUpdated)
                {
                    lblstatus.Text = CatName + " category updated successfully!";
                    lblstatus.ForeColor = System.Drawing.Color.Green;
                    lblstatus.Focus();
                    BindCategoryData();
                }
                else
                {
                    lblstatus.Text = "Error while updating " + CatName + " category";
                    lblstatus.ForeColor = System.Drawing.Color.Red;
                    lblstatus.Focus();
                }


            }
            else
            {
                reader.Close();
                con1.Close();

                //Add built-in function to remove spaces from Textbox Category name         

                lblstatus.Text = CatName + " already exist in category";
                lblstatus.ForeColor = System.Drawing.Color.Red;
                lblstatus.Focus();

            }
        }

        protected void btndelete_Click(object sender, EventArgs e)
        {
            Boolean IsDeleted = false;
            int CatID = Convert.ToInt32(Session["catid"].ToString());
            //Add built-in function to remove spaces from Textbox Category name         

            SqlConnection sqlcon = new SqlConnection(_conString);

            SqlCommand cmd = new SqlCommand();
            //Add DELETE statement to delete the selected category for the above CatID         
            cmd.CommandText = "   update category set cat_status = @cstatus where cat_id = @cid";
            //Create a parametererized query for CatID    
            cmd.Parameters.AddWithValue("@cid", CatID);
            cmd.Parameters.AddWithValue("@cstatus", "False");
            cmd.Connection = sqlcon;

            sqlcon.Open();


            //use Command method to execute DELETE statement and return           
            //boolean if number of records DELETED is greater than zero  
            IsDeleted = cmd.ExecuteNonQuery() > 0;


            sqlcon.Close();



            if (IsDeleted)
            {
                lblstatus.Text = " category deleted successfully!";
                lblstatus.ForeColor = System.Drawing.Color.Green;
                BindCategoryData();
                //Refresh the GridView by calling the BindCategoryData()         
            }
            else
            {
                lblstatus.Text = "Error while deleting category";
                lblstatus.ForeColor = System.Drawing.Color.Red;
            }


        }

        protected void lnkbtnadd_Click(object sender, EventArgs e)
        {
            pmpinsert.Show();
        }

        protected void btninsert_Click(object sender, EventArgs e)
        {
            Boolean IsAdded = false;
            //Add built-in function to remove spaces from Textbox Category name         
            String CatName = txtinsert.Text.Trim();

            SqlConnection con1 = new SqlConnection(_conString);                 // Create Command                 
            SqlCommand cmd2 = new SqlCommand();
            cmd2.Connection = con1;                 //search for username from tbluser   '--;               
            cmd2.CommandText = "select * from [category] where cat_name = @cidd";
            //create a parameterized query to prevent sql injection
            cmd2.Parameters.AddWithValue("@cidd", CatName);
            SqlDataReader reader;
            con1.Open();
            reader = cmd2.ExecuteReader();                 //To check if the email already exists in the DB                
            if (reader.HasRows)
            {
                lblstatus.Text = CatName + " already exist in category";
                lblstatus.ForeColor = System.Drawing.Color.Red;
                lblstatus.Focus();
            }
            else
            {
                reader.Close();
                con1.Close();

                SqlConnection con = new SqlConnection(_conString);

                SqlCommand cmd = new SqlCommand();
                //add INSERT statement to create new category name 
                cmd.CommandText = "  insert into category(cat_name,cat_price,cat_point,cat_status) values (@cname,@cprice,@cpoint,@cstatus)   ";
                cmd.Parameters.AddWithValue("@cname", CatName);
                cmd.Parameters.AddWithValue("@cprice", txtprice.Text.Trim());
                cmd.Parameters.AddWithValue("@cpoint", txtpoint.Text.Trim());
                cmd.Parameters.AddWithValue("@cstatus", "True");

                //create Parameterized query to prevent sql injection by     
                //using above String name, where spaces have been removed        
                cmd.Connection = con;
                con.Open();
                //use Command method to execute INSERT statement and return           
                //boolean if number of records inserted is greater than zero         
                IsAdded = cmd.ExecuteNonQuery() > 0;
                con.Close();


                if (IsAdded)
                {
                    lblstatus.Text = CatName + " category added successfully!";
                    lblstatus.ForeColor = System.Drawing.Color.Green;
                    //Refresh the GridView by calling the BindCategoryData()  
                    lblstatus.Focus();
                    BindCategoryData();

                }
                else
                {
                    lblstatus.Text = "Error while adding " + CatName + " category";
                    lblstatus.ForeColor = System.Drawing.Color.Red;
                    lblstatus.Focus();
                }
            }
        }
    }
}
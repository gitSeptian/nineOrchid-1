using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NineOrchid.Pages
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection conn;
        String strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            auth();
            if (auth().ToString() == "S")
            {
                Response.Redirect("~/Pages/Project/Home.aspx");
            }
            else
            {
                status.Text = auth();
                status.Visible = true;
            }
            
        }
        protected String auth()
        {
            string user = usertxt.Text;
            string password = userpw.Text;

            if (conn == null)
            {
                conn = new SqlConnection(strCon);
            }
            try
            {
                conn.Open();
                DataTable dt = new DataTable("data");
                DataTable dt1 = new DataTable();
                String query = "SELECT * FROM [NINEORCHIDDB].[dbo].[Tbl_MUser] WHERE username ='" + user + "'";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    query = query + "AND password = '" + password + "'";
                    da = new SqlDataAdapter(query, conn);
                    da.Fill(dt1);
                    if (dt1.Rows.Count > 0)
                    {
                        return "S";
                    }
                    else
                    {
                        return "Password Salah";
                    }
                }
                else
                {
                    return "User Not Found";
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
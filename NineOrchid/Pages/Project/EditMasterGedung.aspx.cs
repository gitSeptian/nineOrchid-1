using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NineOrchid.Pages.Project
{
    public partial class EditMasterGedung : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetData();
            }
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string ID = Request.QueryString["rowid"];
            NineOrchidBLL.GedungBLL bll = new NineOrchidBLL.GedungBLL();
            SortedList sl = new SortedList();
            sl.Add("@idxGedung-int", ID);
            sl.Add("@jml_lantai-varchar-2", jmlLantai.Text);
            sl.Add("@gedung_nm-varchar-20", nmGedung.Text);
            bll.Update(sl);
            Response.Redirect("~/Pages/Project/MasterGedung.aspx");

        }
        public void GetData()
        {
            string ID = Request.QueryString["rowid"];
            NineOrchidBLL.GedungBLL bll = new NineOrchidBLL.GedungBLL();
            SortedList sl = new SortedList();
            sl.Add("@idxGedung-int", ID);
            DataTable dt = bll.GetContent(sl);
            nmGedung.Text = dt.Rows[0]["gedung_nm"].ToString();
            jmlLantai.Text = dt.Rows[0]["jml_lantai"].ToString();


        }
    }
}
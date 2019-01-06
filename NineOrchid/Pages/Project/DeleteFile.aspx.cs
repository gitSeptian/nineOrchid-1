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
    public partial class DeleteFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string action = Request.QueryString["action"];
            getData(action);
           


        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string ID = Request.QueryString["rowid"];
            string action = Request.QueryString["action"];
            delete(action);
            ClientScript.RegisterStartupScript(this.GetType(), "RefreshParent", "<script type='text/javascript'>RefreshParent()</script>");

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "RefreshParent", "<script type='text/javascript'>RefreshParent()</script>");
        }
        public void getData(string action)
        {
            string ID = Request.QueryString["rowid"];
            if (action == "1")
            {
                NineOrchidBLL.GedungBLL bll = new NineOrchidBLL.GedungBLL();
                SortedList sl = new SortedList();
                sl.Add("@idxGedung-int", ID);
                DataTable dt = bll.GetContent(sl);
                string x = dt.Rows[0]["gedung_nm"].ToString();
                lblFileName.Text = x;
            }
            else if (action == "2")
            {
                NineOrchidBLL.KamarBLL bll = new NineOrchidBLL.KamarBLL();
                SortedList sl = new SortedList();
                sl.Add("@idxKamar-varchar-10", ID);
                DataTable dt = bll.GetContent(sl);
                string x = dt.Rows[0]["idxKamar"].ToString();
                lblFileName.Text = x;
            }
            else if (action == "3")
            {
                NineOrchidBLL.PerusahaanBLL bll = new NineOrchidBLL.PerusahaanBLL();
                SortedList sl = new SortedList();
                sl.Add("@idxPerusahaan-int", ID);
                DataTable dt = bll.GetContent(sl);
                string x = dt.Rows[0]["idxPerusahaan"].ToString();
                lblFileName.Text = x;
            }
            else if (action == "5")
            {
                NineOrchidBLL.PenghuniBLL bll = new NineOrchidBLL.PenghuniBLL();
                SortedList sl = new SortedList();
                sl.Add("@idxPenghuni-int", ID);
                DataTable dt = bll.GetContent(sl);
                string x = dt.Rows[0]["idxPenghuni"].ToString();
                lblFileName.Text = x;
            }
            else
            {
                lblFileName.Text = "";
            }

        }
        public void delete(string action)
        {
            if (action == "1")
            {
                string ID = Request.QueryString["rowid"];
                NineOrchidBLL.GedungBLL bll = new NineOrchidBLL.GedungBLL();
                SortedList sl = new SortedList();
                sl.Add("@idxGedung-int", ID);
                bll.Delete(sl);
            }
            else if (action == "2")
            {
                string ID = Request.QueryString["rowid"];
                NineOrchidBLL.KamarBLL bll = new NineOrchidBLL.KamarBLL();
                SortedList sl = new SortedList();
                sl.Add("@idxKamar-varchar-10", ID);
                bll.Delete(sl);
            }
            else if (action == "3")
            {
                string ID = Request.QueryString["rowid"];
                NineOrchidBLL.PerusahaanBLL bll = new NineOrchidBLL.PerusahaanBLL();
                SortedList sl = new SortedList();
                sl.Add("@idxPerusahaan-INT", ID);
                bll.Delete(sl);
            }
            else if (action == "4")
            {
                string ID = Request.QueryString["rowid"];
                NineOrchidBLL.KerabatBLL bll = new NineOrchidBLL.KerabatBLL();
                SortedList sl = new SortedList();
                sl.Add("@idxKerabat-INT", ID);
                bll.Delete(sl);
            }
            else if (action == "5")
            {
                string ID = Request.QueryString["rowid"];
                NineOrchidBLL.PenghuniBLL bll = new NineOrchidBLL.PenghuniBLL();
                SortedList sl = new SortedList();
                sl.Add("@idxPenghuni-INT", ID);
                bll.Delete(sl);
            }

        }
    }
}
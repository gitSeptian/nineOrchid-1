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
    public partial class EditMasterKamar : System.Web.UI.Page
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
            NineOrchidBLL.KamarBLL bll = new NineOrchidBLL.KamarBLL();
            SortedList sl = new SortedList();
            sl.Add("@idxKamar-varchar-10", ID);
            sl.Add("@kategori_kmr-varchar-20", KategoriKamar.Text);
            sl.Add("@peruntukan-varchar-10", peruntukanddl.SelectedValue);
            sl.Add("@isAC-bit", CheckBoxAC.Checked);
            sl.Add("@isTV-bit", CheckBoxTV.Checked);
            sl.Add("@trf_harian-varchar-50", trf_harian.Text);
            sl.Add("@trf_bulanan-varchar-50", trf_bulanan.Text);
            sl.Add("@trf_tiga_bulanan-varchar-50", trf_tiga_bulanan.Text);
            sl.Add("@ket-varchar-10", ket.Text);
            bll.Update(sl);
            Response.Redirect("~/Pages/Project/MasterKamar.aspx");
        }
        public void GetData()
        {
            string ID = Request.QueryString["rowid"];
            NineOrchidBLL.KamarBLL bll = new NineOrchidBLL.KamarBLL();
            SortedList sl = new SortedList();
            sl.Add("@idxKamar-varchar-10", ID);
            DataTable dt = bll.GetContent(sl);
            KategoriKamar.Text = dt.Rows[0]["kategori_kmr"].ToString();
            no_kamar.Text = dt.Rows[0]["no_kamar"].ToString();
            no_kamar.Enabled = false;

            if (dt.Rows[0]["peruntukan"].ToString() == "Pria")
            {
                peruntukanddl.SelectedValue ="1";
            }
            else if (dt.Rows[0]["peruntukan"].ToString() == "Wanita")
            {
                peruntukanddl.SelectedValue = "2";
            }
            else
            {
                peruntukanddl.SelectedValue = "3";
            }

            if (dt.Rows[0]["isAC"].ToString() == "iya")
            {
                CheckBoxAC.Checked = true;
            }
            else
            {
                CheckBoxAC.Checked = false;
            }
            if (dt.Rows[0]["isTV"].ToString() == "iya")
            {
                CheckBoxTV.Checked = true;
            }
            else
            {
                CheckBoxTV.Checked = false;
            }
       
            trf_harian.Text = dt.Rows[0]["trf_harian"].ToString();
            trf_bulanan.Text = dt.Rows[0]["trf_bulanan"].ToString();
            trf_tiga_bulanan.Text = dt.Rows[0]["trf_tiga_bulanan"].ToString();
            ket.Text = dt.Rows[0]["ket"].ToString();



        }
    }
}
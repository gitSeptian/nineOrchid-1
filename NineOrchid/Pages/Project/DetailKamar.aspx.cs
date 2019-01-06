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
    public partial class DetailKamar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetData();
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
            peruntukan.Text = dt.Rows[0]["peruntukan"].ToString();
            lantai_kmr.Text = dt.Rows[0]["lantai_kmr"].ToString();
            gedungkos.Text = dt.Rows[0]["gedung_nm"].ToString();

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
            stat_kamar.Text = dt.Rows[0]["stat_kmr"].ToString();
            var a = dt.Rows[0]["foto1"].ToString();
            if (!string.IsNullOrEmpty(a))
            {
                byte[] data = (byte[])dt.Rows[0]["foto1"];
                image1.ImageUrl = "data:image;base64," + Convert.ToBase64String(data);
            }
            var b = dt.Rows[0]["foto2"].ToString();
            if (!string.IsNullOrEmpty(b))
            {
                byte[] data = (byte[])dt.Rows[0]["foto2"];
                image2.ImageUrl = "data:image;base64," + Convert.ToBase64String(data);
            }
            var c = dt.Rows[0]["foto3"].ToString();
            if (!string.IsNullOrEmpty(c))
            {
                byte[] data = (byte[])dt.Rows[0]["foto3"];
                image3.ImageUrl = "data:image;base64," + Convert.ToBase64String(data);
            }
            var d = dt.Rows[0]["foto4"].ToString();
            if (!string.IsNullOrEmpty(d))
            {
                byte[] data = (byte[])dt.Rows[0]["foto4"];
                image4.ImageUrl = "data:image;base64," + Convert.ToBase64String(data);
            }
            var e = dt.Rows[0]["foto5"].ToString();
            if (!string.IsNullOrEmpty(e))
            {
                byte[] data = (byte[])dt.Rows[0]["foto5"];
                image5.ImageUrl = "data:image;base64," + Convert.ToBase64String(data);
            }

        }

        protected void submitKerebat_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pages/Project/MasterKamar.aspx");
        }
    }
}
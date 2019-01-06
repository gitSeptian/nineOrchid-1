using NineOrchidBLL;
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
    public partial class EditPenghuniMaster : System.Web.UI.Page
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
            var a = ImageUpload(FileUpladId);
            var b = ImageUpload(FileUploadPenghuni);
            string ID = Request.QueryString["rowid"];
            NineOrchidBLL.PenghuniBLL bll = new NineOrchidBLL.PenghuniBLL();
            SortedList sl = new SortedList();
            sl.Add("@idxPenghuni-INT", ID);
            sl.Add("@nm_penghuni-varchar-50", nama.Text);
            sl.Add("@tmpt_lhr-varchar-20", TempatLahir.Text);
            sl.Add("@tggl_lhr-varchar-20", tanggalLahir.Text);
            sl.Add("@type_id-varchar-10", ddlIDCard.SelectedValue);
            sl.Add("@no_id-varchar-30", no_id.Text);
            sl.Add("@agama-varchar-10", agama.Text);
            sl.Add("@no_hp-varchar-20", noHP.Text);
            sl.Add("@email-varchar-50", email.Text);
            sl.Add("@almt_asal-varchar-200", alamat_asal.Text);
            sl.Add("@pekerjaan-varchar-200", pekerjaan.Text);
            if (b != null)
            {
                sl.Add("@foto_penghuni-image", b);
            }
            if (a != null)
            {
                sl.Add("@foto_ktp-image", a);
            }
      
            sl.Add("@idxPerusahaan-INT", ddlPerusahaan.SelectedValue);


            bll.Update(sl);
            Response.Redirect("~/Pages/Project/MasterPenghuni.aspx");
        }
        public void GetData()
        {
            getddl();
            string ID = Request.QueryString["rowid"];
            NineOrchidBLL.PenghuniBLL bll = new NineOrchidBLL.PenghuniBLL();
            SortedList sl = new SortedList();
            sl.Add("@idxPenghuni-INT", ID);
            DataTable dt = bll.GetContent(sl);
            var str = dt.Rows[0]["TTL"].ToString();
            string[] tokens = str.Split(',');

            nama.Text = dt.Rows[0]["nm_penghuni"].ToString();
            agama.Text = dt.Rows[0]["agama"].ToString();
            tanggalLahir.Text = tokens[1];
            TempatLahir.Text = tokens[0];
            ddlIDCard.SelectedValue = dt.Rows[0]["type_id"].ToString();
            no_id.Text = dt.Rows[0]["no_id"].ToString();
            noHP.Text = dt.Rows[0]["no_hp"].ToString();
            email.Text = dt.Rows[0]["email"].ToString();
            alamat_asal.Text = dt.Rows[0]["almt_asal"].ToString();
            pekerjaan.Text = dt.Rows[0]["pekerjaan"].ToString();
            ddlPerusahaan.SelectedValue = dt.Rows[0]["idxPerusahaan"].ToString();

        }
        protected void getddl()
        {
            ddlProject ddl = new ddlProject();
            SortedList sl = new SortedList();
            sl.Add("@jenisddl-INT", 2);

            DataTable dt = ddl.GetDdl(sl);
            ddlPerusahaan.DataSource = dt;
            ddlPerusahaan.DataValueField = "Key_value";
            ddlPerusahaan.DataTextField = "Key_text";
            ddlPerusahaan.DataBind();
        }
        public byte[] ImageUpload(FileUpload imageContent)
        {
            if (imageContent.HasFile)
            {
                int imagefileLen = imageContent.PostedFile.ContentLength;
                byte[] imgarray = new byte[imagefileLen];
                HttpPostedFile image = imageContent.PostedFile;
                image.InputStream.Read(imgarray, 0, imagefileLen);
                return imgarray;

            }
            return null;
        }
    }
}
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NineOrchidBLL;
using System.IO;
using System.Xml;
using Newtonsoft.Json;

namespace NineOrchid.Pages.Project
{
   
    public partial class MasterPenghuni : System.Web.UI.Page
    {
        ddlProject ddl = new ddlProject();
        PerusahaanBLL perusahaanBLL = new PerusahaanBLL();
        PenghuniBLL penghuniBLL = new PenghuniBLL();
        public string GridContent;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClearForm();
                GetData();
            }
            
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            InsertData();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {

        }

        protected void checkPerusahaan_CheckedChanged(object sender, EventArgs e)
        {
            if (checkPerusahaan.Checked)
            {
                getddl();
                nmperusahaan.Enabled = false;
                AlamatPerusahaan.Enabled = false;
                kotaperusahaan.Enabled = false;
                telpPerusahaan.Enabled = false;
            }
            else
            {
                ddlPerusahaan.Enabled = false;
                nmperusahaan.Enabled = true;
                AlamatPerusahaan.Enabled = true;
                kotaperusahaan.Enabled = true;
                telpPerusahaan.Enabled = true;

                clearPerusahaan();
            }
            
        }
        protected void getddl()
        {
            SortedList sl = new SortedList();
            sl.Add("@jenisddl-INT", 2);

            DataTable dt = ddl.GetDdl(sl);
            ddlPerusahaan.DataSource = dt;
            ddlPerusahaan.DataValueField = "Key_value";
            ddlPerusahaan.DataTextField = "Key_text";
            ddlPerusahaan.DataBind();
            ddlPerusahaan.Enabled = true;
        }

        protected void ddlPerusahaan_SelectedIndexChanged(object sender, EventArgs e)
        {
            SortedList sl = new SortedList();
            sl.Add("@idxPerusahaan-INT", ddlPerusahaan.SelectedValue);
            DataTable dt = perusahaanBLL.GetContent(sl);
            nmperusahaan.Text = dt.Rows[0]["nm_perusahaan"].ToString();
            AlamatPerusahaan.Text = dt.Rows[0]["almt_perusahaan"].ToString();
            kotaperusahaan.Text = dt.Rows[0]["kota_perusahaan"].ToString();
            telpPerusahaan.Text = dt.Rows[0]["telp_perusahaan"].ToString();

        }
        protected void InsertData()
        {
            SortedList sl = new SortedList();
            try
            {
                sl.Add("@nm_penghuni-VARCHAR-50", nama.Text);
                sl.Add("@tmpt_lhr-VARCHAR-50", TempatLahir.Text);
                sl.Add("@tggl_lhr-VARCHAR-50", tanggalLahir.Text);
                sl.Add("@type_id-VARCHAR-50", ddlIDCard.SelectedValue);
                sl.Add("@no_id-VARCHAR-50", no_id.Text);
                sl.Add("@agama-VARCHAR-50", agama.Text);
                sl.Add("@no_hp-VARCHAR-50", noHP.Text);
                sl.Add("@email-VARCHAR-50", email.Text);
                sl.Add("@almt_asal-VARCHAR-50", alamat_asal.Text);
                sl.Add("@pekerjaan-VARCHAR-50", pekerjaan.Text);
                sl.Add("@nm_perusahaan-VARCHAR-50", nmperusahaan.Text);
                sl.Add("@almt_perusahaan-VARCHAR-200", AlamatPerusahaan.Text);
                sl.Add("@kota_perusahaan-VARCHAR-20", kotaperusahaan.Text);
                sl.Add("@telp_perusahaan-VARCHAR-20", telpPerusahaan.Text);

                if (ddlPerusahaan.Enabled == true)
                {
                    sl.Add("@idxPerusahaan-INT", ddlPerusahaan.SelectedValue);
                }

                penghuniBLL.Insert(sl);

                SuccessAction();
            }
            catch (Exception ex)
            {

                throw;
            }
          
        }
        protected void SuccessAction()
        {
            panelInfo.Visible = true;
            infolbl.Text = "success melakukan update data!";
            ClearForm();
        }
        protected void ClearForm()
        {
            nama.Text = "";
            TempatLahir.Text = "";
            noHP.Text = "";
            agama.Text = "";
            tanggalLahir.Text = "";
            ddlIDCard.SelectedIndex = 0;
            no_id.Text = "";
            email.Text = "";
            alamat_asal.Text = "";
            pekerjaan.Text = "";
            clearPerusahaan();
        }
        protected void clearPerusahaan()
        {
            nmperusahaan.Text = "";
            AlamatPerusahaan.Text = "";
            kotaperusahaan.Text = "";
            telpPerusahaan.Text = "";
        }
        public void GetData()
        {
            DataTable dt = new DataTable("data");
            SortedList sl = new SortedList();
            dt = penghuniBLL.GetContent(sl);
            string hasil;
            using (StringWriter sw = new StringWriter())
            {
                dt.WriteXml(sw);
                hasil = sw.ToString();
            }

            XmlDocument doc = new XmlDocument();
            doc.LoadXml(hasil);
            string content = JsonConvert.SerializeXmlNode(doc);
            GridContent = content;
        }
    }
}
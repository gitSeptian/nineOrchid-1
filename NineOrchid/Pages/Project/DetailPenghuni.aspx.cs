using Newtonsoft.Json;
using NineOrchidBLL;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace NineOrchid.Pages.Project
{
    public partial class DetailPenghuni : System.Web.UI.Page
    {
        KerabatBLL KerabatBLL = new KerabatBLL();
        PenghuniBLL penghuniBLL = new PenghuniBLL();
        public string GridContent;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                GetDataPenghuni();
                GetDataEmergency();
            }
            GetDataPenghuni();
            GetDataEmergency();
        }
        public void GetDataPenghuni()
        {

            string id = Request.QueryString["ID"];
            DataTable dt = new DataTable("data");
            SortedList sl = new SortedList();
    
            sl.Add("@idxPenghuni-INT", id);
            dt = penghuniBLL.GetContent(sl);
            var a = dt.Rows[0]["foto_penghuni"].ToString();
            if (!string.IsNullOrEmpty(a))
            {
                byte[] data = (byte[])dt.Rows[0]["foto_penghuni"];
                image.ImageUrl = "data:image;base64," + Convert.ToBase64String(data);
            }
            else
            {
                string root = Server.MapPath("~");
                string path = Path.GetDirectoryName(root);
                string path1 = Path.GetDirectoryName(path);
                string rootfolder = Path.GetDirectoryName(path1);
                string imagepath = rootfolder + "\\" + "Plugins" + "\\";
                var b = Path.Combine(imagepath, "userImage.png");
                image.ImageUrl = b;
            }
            
            labelNama.Text = dt.Rows[0]["nm_penghuni"].ToString();
            labelTTL.Text = dt.Rows[0]["TTL"].ToString();
            labelAlamat.Text = dt.Rows[0]["almt_asal"].ToString();
            labelAgama.Text = dt.Rows[0]["agama"].ToString();
            labelid.Text = dt.Rows[0]["no_id"].ToString();
            labelnoHP.Text = dt.Rows[0]["no_hp"].ToString();
            labelEmail.Text = dt.Rows[0]["email"].ToString();
            labelPekerjaan.Text = dt.Rows[0]["pekerjaan"].ToString();
          

        }
        public void GetDataEmergency()
        {
            string id = Request.QueryString["ID"];
            DataTable dt = new DataTable("data");
            SortedList sl = new SortedList();
            sl.Add("@idxPenghuni-INT", id);
            dt = KerabatBLL.GetContent(sl);
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {

        }

        protected void submitKerebat_Click(object sender, EventArgs e)
        {
            string id = Request.QueryString["ID"];
            DataTable dt = new DataTable("data");
            SortedList sl = new SortedList();
            sl.Add("@idxPenghuni-INT", id);
            sl.Add("@nm_kerabat-varchar-50", namaKerabat.Text);
            sl.Add("@almt_kerabat-varchar-200", alamatkerabat.Text);
            sl.Add("@kota_kerabat-varchar-10", kotakerabat.Text);
            sl.Add("@kntk_kerabat-varchar-20", kontakkerabat.Text);
            sl.Add("@hub_dgn_penghuni-varchar-20", hubungan.Text);

            KerabatBLL.Insert(sl);
            GetDataEmergency();
        }
    }
}
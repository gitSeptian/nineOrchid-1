using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NineOrchidBLL;
using System.IO;
using System.Xml;
using System.Data;
using Newtonsoft.Json;

namespace NineOrchid.Pages.Project
{
    public partial class MasterGedung : System.Web.UI.Page
    {
        GedungBLL bll = new GedungBLL();
        public string GridContent;
        protected void Page_Load(object sender, EventArgs e)
        {
            GetData();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                SortedList sl = new SortedList();
                sl.Add("@gedung_nm-varchar-20", nmGedung.Text);
                sl.Add("@jml_lantai-varchar-2", jmlLantai.Text);
                bll.Insert(sl);
                SuccessAction();

            }
            catch (Exception ex)
            {
                //infolbl.Text = ex.ToString();
                //panelInfo.CssClass = "alert alert-danger";
                throw ex;
            }
           
           
        }
        protected void SuccessAction()
        {
           // panelInfo.Visible = true;
            //infolbl.Text = "success melakukan update data!";
            nmGedung.Text = "";
            jmlLantai.Text = "";
        }
        public void GetData()
        {
            DataTable dt = new DataTable("data");
            SortedList sl = new SortedList();
            dt = bll.GetContent(sl);
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